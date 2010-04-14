From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Wed, 14 Apr 2010 22:44:45 +0200
Message-ID: <m27ho9sr0i.fsf@igel.home>
References: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Santiago <santiago@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29SB-0005Zs-4G
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740Ab0DNUot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:44:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56873 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab0DNUos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:44:48 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2D2CB1C15659;
	Wed, 14 Apr 2010 22:44:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 1D73490355;
	Wed, 14 Apr 2010 22:44:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id MLV96VHgK8JL; Wed, 14 Apr 2010 22:44:46 +0200 (CEST)
Received: from igel.home (ppp-88-217-96-221.dynamic.mnet-online.de [88.217.96.221])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 14 Apr 2010 22:44:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C2030CA297; Wed, 14 Apr 2010 22:44:45 +0200 (CEST)
X-Yow: I've been WRITING to SOPHIA LOREN every 45 MINUTES since JANUARY 1ST!!
In-Reply-To: <20100414133831.GA12135@f.santiago.vpn.redhat.com> (Ed Santiago's
	message of "Wed, 14 Apr 2010 07:38:31 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144911>

Ed Santiago <santiago@redhat.com> writes:

> Question mark character appears to be valid in a CVS tag,

According to the CVS docs only letters, digits, '-' and '_' are valid
for tag names.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
