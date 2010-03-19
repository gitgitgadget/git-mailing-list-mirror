From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Fri, 19 Mar 2010 19:55:34 +0100
Message-ID: <m2k4t8qgyh.fsf@igel.home>
References: <m2tyswb1jp.fsf@igel.home>
	<7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>
	<ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
	<m23a01yzcc.fsf@igel.home> <4B9F2DB0.30400@viscovery.net>
	<m2pr34kpzm.fsf@igel.home> <4BA07AEE.2080100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 19:55:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshMF-0007rb-V6
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab0CSSzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:55:39 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37370 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0CSSzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:55:38 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id A579B1C15793;
	Fri, 19 Mar 2010 19:55:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 9B492902D0;
	Fri, 19 Mar 2010 19:55:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id XQR4Jgm1-SUt; Fri, 19 Mar 2010 19:55:35 +0100 (CET)
Received: from igel.home (ppp-88-217-104-40.dynamic.mnet-online.de [88.217.104.40])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 19 Mar 2010 19:55:35 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 3590CCA29C; Fri, 19 Mar 2010 19:55:35 +0100 (CET)
X-Yow: Now that I have my ``APPLE,'' I comprehend COST ACCOUNTING!!
In-Reply-To: <4BA07AEE.2080100@viscovery.net> (Johannes Sixt's message of
	"Wed, 17 Mar 2010 07:47:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142633>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Andreas Schwab schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Andreas Schwab schrieb:
>>>> The nested list in the description of the -t option wasn't properly
>>>> indented.  Additionally, make it a horizontal labeled list since the
>>>> labels are all short.
>>> IMHO, converting a vertical list to a horizontal list is a step in the
>>> wrong direction, even if the labels are short. It is far easier to scan a
>>> vertical list for a match than a horizontal list.
>> 
>> The linebreak after the label is useless when all labels are much
>> shorter than the indentation.
>
> I use Junio's man pages, and they look like so:
>
>        -t
>            Identify the file status with the following tags
>            (followed by a space) at the start of each line:
>
>            H   cached
>            S   skip-worktree
>            M   unmerged
>            R   removed/deleted
>            C   modified/changed
>            K   to be killed
>            ?   other

That's not what I see.

       -t
           Identify the file status with the following tags (followed by a
           space) at the start of each line:

           H
               cached

           S
               skip-worktree

           M
               unmerged

           R
               removed/deleted

           C
               modified/changed

           K
               to be killed

           ?
               other


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
