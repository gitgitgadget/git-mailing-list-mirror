From: David Lang <dlang@digitalinsight.com>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 12:49:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0607271245200.11436@qynat.qvtvafvgr.pbz>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  
 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz>  
 <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com><Pine.LNX.4.64
 .0607270936200.4168@g5.osdl.org><Pine.LNX.4.63.0607271140100.11253@qynat.qv
 tvafvgr.pbz> <Pine.LNX.4.64.0607271232090.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jon Smirl <jonsmirl@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 21:50:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6BsV-0006eM-UI
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 21:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWG0Tuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 15:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWG0Tuh
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 15:50:37 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:49063 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750907AbWG0Tug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 15:50:36 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Thu, 27 Jul 2006 12:50:36 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Thu, 27 Jul 2006 12:50:16 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607271232090.4168@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24336>

On Thu, 27 Jul 2006, Linus Torvalds wrote:

> On Thu, 27 Jul 2006, David Lang wrote:
>>
>>> (*) I will, in fact, claim that the difference between a bad programmer
>>> and a good one is whether he considers his code or his data structures
>>> more important. Bad programmers worry about the code. Good programmers
>>> worry about data structures and their relationships.
>>
>> personally I'd add to this that after the data structures are defined and you
>> turn to the code the API is significantly more important then the code itself.
>
> I think people sometimes put too much emphasis on ABI's.

I was careful to say aPi, not aBi :-)

> Sure, if you're depending on a library, the ABI is supremely important.
> But I literally believe that one of the things that makes open source
> technically superior to most other projects is the fact that ABI's can be
> changed more easily, and sometimes at all.

very true

> If you have good data structures, the ABI's are largely irrelevant, and if
> you have a problem with an existing ABI, you can just write a new
> entrypoint instead (and leave the old ABI alone).
>
> On the other hand, if you have bad datastructures, the ABI often reflects
> that, and having the balls to say that your ABI's are broken and need to
> be re-done in order to fix the data structures is _very_ important.
> Otherwise you'll never be able to fix anything.

however it's possible to have a good data structure and a bad API. I'm just 
emphisising the API over the 'elegance', etc of the code that implements it.

> So I think that ABI's are often _way_ overhyped. If they are good,
> everybody is happy. But if the interfaces are bad, you had better be
> willing to just say "screw the ABI" and just fix it.
>
> Now, that doesn't mean that you should change ABI's on a whim, and
> regardless of any other issues, your user base is always important. But I
> don't think ABI's are, or should be, "sacred".

I'm not meaning to imply in any way that API's are sacred, just that they are 
very important and deserve a lot of thought before implementation.

David Lang
