From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 20 Feb 2009 15:36:11 -0500
Message-ID: <499F143B.7080708@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>  <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>  <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>  <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>  <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>  <499EE761.2010902@tedpavlic.com> <2c6b72b30902201034r47850c8aq248b673ee96bdf3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lac89-0006As-1r
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 21:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbZBTUgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 15:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbZBTUgZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 15:36:25 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:37775 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744AbZBTUgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 15:36:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 99FE180D8022;
	Fri, 20 Feb 2009 15:29:38 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXdzuI5gLt3f; Fri, 20 Feb 2009 15:29:38 -0500 (EST)
Received: from TedBook.local (rrcs-24-123-153-141.central.biz.rr.com [24.123.153.141])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 97AC080D801C;
	Fri, 20 Feb 2009 15:29:37 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <2c6b72b30902201034r47850c8aq248b673ee96bdf3a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110888>

Both patches (the new and the old) seem to fix the original problem.

However, I now notice that both patches introduces a new problem. From 
the tig repo (with no .tigrc), I run tig to view the single-line 
changelog. I then hit "Enter" to view the first commit (which is your 
fix). I then hit "j" and "k" to scroll through it.

*Sometimes* the entire line gets highlighted with a green background, 
and *sometimes* it doesn't (i.e., sometimes the green background doesn't 
highlight the whitespace between the end of the line and the right-hand 
side of the terminal, and sometimes it does). That is, if I hold down 
"j" to scroll through the commit, and then hold down "k" to scroll back, 
lines that were highlighted all the way from left to right on the way 
down are only highlighted part of the way on the way up.

--Ted

On 2/20/09 1:34 PM, Jonas Fonseca wrote:
> On Fri, Feb 20, 2009 at 18:24, Ted Pavlic<ted@tedpavlic.com>  wrote:
>>> Looks like there might be a pattern and I might have an excuse to go
>>> knock on the door of one of my "Mac" friends. ;) However, first I
>>> would kindly ask if one of you have time to test the attached patch.
>> Any verdict on this patch (it WFM)? I notice tig is still unpatched to fix
>> this problem.
>
> I didn't look more into it. Maybe you can try the attached patch for me.
>

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
