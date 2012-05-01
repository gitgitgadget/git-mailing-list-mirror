From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line termination mode
Date: Tue, 01 May 2012 02:28:17 +0200
Message-ID: <m2ehr4sq1q.fsf@igel.home>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
	<1335817705-24718-1-git-send-email-jk@jk.gs>
	<7vd36oesjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 02:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP0xA-0006AC-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 02:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438Ab2EAA2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 20:28:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49773 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896Ab2EAA2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 20:28:23 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VhNkn72s8z3hhXN;
	Tue,  1 May 2012 02:28:17 +0200 (CEST)
Received: from igel.home (ppp-88-217-104-31.dynamic.mnet-online.de [88.217.104.31])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VhNkp0ZCTz4KK36;
	Tue,  1 May 2012 02:28:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 9AB91CA2A9; Tue,  1 May 2012 02:28:17 +0200 (CEST)
X-Yow: Bo Derek ruined my life!
In-Reply-To: <7vd36oesjr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Apr 2012 15:58:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196638>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, are we sure that
>
> 	printf "add bar\0initial"
>
> works per specification, or merely works by accident in some
> implementation?

Since the backslash is not followed by $ ` " \ <newline> it is not
special to the shell.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
