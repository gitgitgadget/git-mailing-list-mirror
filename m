From: "Adam Kropelin" <akropel1@rochester.rr.com>
Subject: Re: I want to release a "git-1.0"
Date: Thu, 2 Jun 2005 19:40:48 -0400
Message-ID: <00e101c567cc$80c0de80$03c8a8c0@kroptech.com>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:40:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdzHq-000516-PD
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 01:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFBXmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFBXmO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 19:42:14 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:17596 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261477AbVFBXlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 19:41:18 -0400
Received: from mail.kroptech.com (cpe-24-93-20-125.rochester.res.rr.com [24.93.20.125])
	by ms-smtp-03.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id j52NemP4013513;
	Thu, 2 Jun 2005 19:40:48 -0400 (EDT)
Received: from pia (pia.kroptech.com [192.168.200.3])
	by mail.kroptech.com (Postfix) with SMTP id A64CA11376E;
	Thu,  2 Jun 2005 19:56:13 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Anyway, I wrote just a _very_ introductory thing in
> Documentation/tutorial.txt, I'll try to update and expand on it later. 
> It
> basically has a really stupid example of "how to set up a new 
> project".

I've been working my way thru the tutorial, trying to up my git clue 
level a bit. One part where things start to go a bit pear-shaped for me 
is in the description of git-diff-files vs. git-diff-cache. The tutorial 
takes pains to emphasize the difference between "working directory 
contents", "index file", and "committed tree", and I'm on board with 
that. What confuses me is the following:

> Unlike "git-diff-files", which showed the difference between the index
> file and the working directory, "git-diff-cache" shows the differences
> between a committed _tree_ and the index file.
> ...
> [example where git-diff-cache shows difference between working
> directory and committed tree]
> ...
> "git-diff-cache" also has a specific flag "--cached", which is used to
> tell it to show the differences purely with the index file, and ignore
> the current working directory state entirely

The example and the description of --cached seem to contradict the first 
sentence's description the tool's purpose in life. If it shows you 
differences between a committed tree and the index file, why is it 
looking in my working directory at all? In order to get the behavior the 
first sentence describes you actually have to use --cached.

Am I on right track?

--Adam

