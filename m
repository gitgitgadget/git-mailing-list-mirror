From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-completion.bash: replace zsh notation that breaks bash 3.X
Date: Fri, 18 Jan 2013 16:02:59 +0100
Message-ID: <m2obgmjzz0.fsf@igel.home>
References: <1358505065-16913-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, felipe.contreras@gmail.com, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:03:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwDTm-000712-7h
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 16:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab3ARPDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 10:03:14 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33420 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710Ab3ARPDL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 10:03:11 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YnllG3Cjcz4KKSV;
	Fri, 18 Jan 2013 16:03:06 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YnllG2sZyzbbjh;
	Fri, 18 Jan 2013 16:03:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ZlZ198hhsRbK; Fri, 18 Jan 2013 16:02:38 +0100 (CET)
X-Auth-Info: nVNIWftC1uTHWbi9bVHFZBBMqGgxWlhJgl7ajVmTbMY=
Received: from igel.home (ppp-93-104-134-30.dynamic.mnet-online.de [93.104.134.30])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 18 Jan 2013 16:02:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 5055BCA2A1; Fri, 18 Jan 2013 16:02:59 +0100 (CET)
X-Yow: Sign my PETITION.
In-Reply-To: <1358505065-16913-1-git-send-email-drafnel@gmail.com> (Brandon
	Casey's message of "Fri, 18 Jan 2013 02:31:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213913>

Brandon Casey <drafnel@gmail.com> writes:

> +				array[$(($#array+1))]="$c"

You don't need $(( )) since the array index is already evaluated as an
arithmethic expression.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
