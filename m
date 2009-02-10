From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 14:07:21 -0500
Message-ID: <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com> <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWxzO-0006vz-9l
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbZBJTH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbZBJTH1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:07:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:47308 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554AbZBJTHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 14:07:24 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 75E7E1FFC281; Tue, 10 Feb 2009 19:07:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 53BE71FFC273;
	Tue, 10 Feb 2009 19:07:17 +0000 (UTC)
In-Reply-To: <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109292>


On Feb 10, 2009, at 1:29 PM, Jonas Fonseca wrote:

> On Tue, Feb 10, 2009 at 14:29, Ted Pavlic <ted@tedpavlic.com> wrote:
>> I notice that when I do the sequence...
>>
>> *) open tig
>> *) hit <CR> to view first changeset
>> *) hit "j" to scroll one line
>>
>> the green highlighting on the first line moves to the second, but the
>> whitespace following the "commit 00000000000000" stays green. For  
>> example,
>> if I do the sequence above in the tig repo, I'm left with
>>
>> commit e278600f599f60a2b98aeae6bfbb6ba92cf92d6f---GREEN BG HERE---
>> ---This line (Refs:) has GREEN BG---
>>
>> The "commit" has a black background.
>>
>> Is that a bug? Or do I need to upgrade my ncurses?
>
> Sounds like a bug. Probably from the drawing optimizations in  
> tig-0.14.

I am also getting this bug.  It is easiest to reproduce for me by  
running "git log | tig" and just moving the cursor down.  Any action  
that causes the entire window to update (pressing up/down at the  
bottom/top of the screen, PageUp/PageDown, or even just <Enter> to  
scroll down a line) causes the line to appear normally again, although  
movement from that point usually breaks it again.

> No upgrade should be necessary. Could you give me some information
> about what terminal application you are using. Also, have you added
> any specific color settings to ~/.tigrc?

OS 10.5.6's Terminal.app, with TERM=xterm-color
I have no .tigrc

~~ Brian
