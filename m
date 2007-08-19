From: "Aaron Gray" <angray@beeb.net>
Subject: Re: renaming question
Date: Sun, 19 Aug 2007 19:32:01 +0100
Message-ID: <03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm> <87vebbo0f1.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 20:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMpZT-00048y-JR
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 20:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXHSScJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbXHSScI
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 14:32:08 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:2017 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754559AbXHSScH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 14:32:07 -0400
Received: from mwgray.force9.co.uk (EHLO ze4427wm) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FKT50349 (AUTH angray);
	Sun, 19 Aug 2007 19:32:05 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3138
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56136>

>* Aaron Gray:
>
>> I have a very large C source project that I am converting from C to C++.
>>
>> Is it posssible to track changes with renamed files in GIT ?
>
> You don't need to rename the files if you compile them using g++.  If
> you still want to rename them, most history-related GIT commands
> accept an -M switch which enables rename ("move") detection.

For sanity they have to be renamed.

I am a bit of a GIT newbie. With the -M switch what would be the proceedure 
with a single file conversion such as with test.c and test.cpp ?

Would the following do the trick ?

    git add test.c
    git commit

    rename test.c test.cpp *
    vi test.cpp

    git rm test.c
    git add test.cpp
    git commit -M

Many thanks in advance,

Aaron
