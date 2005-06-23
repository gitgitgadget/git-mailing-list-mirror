From: "Adam Kropelin" <akropel1@rochester.rr.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 23:52:47 -0400
Message-ID: <07be01c577a7$05108660$03c8a8c0@kroptech.com>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org> <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 06:22:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlJDy-0005ew-DT
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 06:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVFWE2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVFWE2J
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 00:28:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:37279 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262066AbVFWE2B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 00:28:01 -0400
Received: from ms-smtp-03.nyroc.rr.com (ms-smtp-03.nyroc.rr.com [24.24.2.57])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j5N3r7YG010241;
	Wed, 22 Jun 2005 20:53:08 -0700
Received: from mail.kroptech.com (cpe-24-93-20-125.rochester.res.rr.com [24.93.20.125])
	by ms-smtp-03.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id j5N3qmP4026359;
	Wed, 22 Jun 2005 23:52:48 -0400 (EDT)
Received: from pia (pia.kroptech.com [192.168.200.3])
	by mail.kroptech.com (Postfix) with SMTP id 34B6311376E;
	Thu, 23 Jun 2005 00:11:06 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Jeff Garzik" <jgarzik@pobox.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Scanned: Symantec AntiVirus Scan Engine
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
>> git commit --figure-out-for-me-what-files-changed
>
> Well, it _does_ do that. That's what the "git status" thing does, and
> look at the initial commit message comments that it prepares for you: 
> it
> tells you which files are modified but haven't been marked for 
> check-in
> etc.
>
> But the thing is, you need to have a graphical tool for that. I don't
> want to have some silly command line that asks for each modified file
> whether you want to include that file in the commit or not.

I know I shouldn't invoke this particular acronym, but I rather like 
CVS's approach. If the user does not specify any files on the command 
line, assume he wants to check in everything that has changed (added and 
removed files excluded). When you see the initial commit message you can 
review the list of affected files and you can always abort and specify 
files explictly if you realize you want to exclude some.

I like that method because it gives you a kick in the pants for having 
mixed multiple unrelated changes in your working directory. "Oh, you 
were lazy and changed six unrelated things without comitting, eh? You 
will now pay for your lack of rigor by typing filenames..." On the flip 
side, you get rewarded with less typing if you keep your working 
directory clean.

--Adam

