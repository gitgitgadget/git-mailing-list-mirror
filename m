From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 22:29:40 -0700
Message-ID: <7vtz3oxnej.fsf@alter.siamese.dyndns.org>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
	<4A09594F.4040603@drmicha.warpmail.net>
	<7vprec4znj.fsf@alter.siamese.dyndns.org>
	<81bfc67a0905132030g39432e63ne72ace88edf79848@mail.gmail.com>
	<7vab5gz41o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Finn Arne Gangstad <finnag@pvv.org>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 07:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4TVt-0000ib-3J
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbZENF3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 01:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbZENF3l
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:29:41 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34593 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZENF3k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 01:29:40 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514052940.NUKP17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Thu, 14 May 2009 01:29:40 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rHVg1b0074aMwMQ04HVhEo; Thu, 14 May 2009 01:29:41 -0400
X-Authority-Analysis: v=1.0 c=1 a=FUvhmXxEDlAA:10 a=J7j2KiR9MRMA:10
 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=JFQp7xKQWubTTYs6mwkA:9
 a=1uUxMnhfNKSU4ZEg2I0A:7 a=-41QWPP9r-qEuqi-a0y1u-NLnooA:4 a=qIVjreYYsbEA:10
 a=MSl-tDqOz04A:10 a=ev6fDj6a8zRPZhL_:21 a=SxKP0yh4yATrst7Q:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119142>

Junio C Hamano <gitster@pobox.com> writes:

> Caleb Cushing <xenoterracide@gmail.com> writes:
>
>> On Wed, May 13, 2009 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Thanks for saying this concisely, and saving me from repeating this.
>>
>> I just don't think one should have to explicitly set something to shut
>> warnings up. defaults are there for a reason. next thing you know it's
>> going to ask me if I'd like to continue, and then it will ask me to
>> press n for next.
>>
>> Why even have them?
>
> Why do you waste other people's time after repeatedly told this was
> discussed to death and everything is recoded in the list archive?

You know what is most frustrating for me with this whole thing?

As you might have guessed already, I am one of the oldest users of git, am
accustomed to the way "matching push" works, and I like it as a sensible
default behaviour for _my workflow_.  If I, Linus and you were the only
git users, there won't be these half-page-full of warning messages.

But there are others, and one of them was motivated enough to write a
patch series to introduce push.default that allows a setting that may be
more suitable than 'matching' in certain workflows, even though I may not
ever use that workflow in my projects myself.  This early vaccination
approach was the least evil solution proposed back then (which I think was
modelled after the already in-progress "deny git push from updating the
current branch" topic), and you were not around to know that I even toned
down the series not to make it too strongly suggest that the default will
change.

No, "you were not around" part is not what is frustrating.  What is
frustrating is that the original author who felt strongly enough against
'matching' default to write the patch is not defending the change in this
thread, and I have to spend time writing responses like this that I
otherwise could be using for something else to improve the project with.
And what is even more frustrating is that I cannot afford the time to
repeat the full discussion here (nor I have inclinations to), and if you
are the type who does not do his own homework, it would appear to you as
if I am all for changing the default and as if I am being unreasonable.

I do not mind appearing to be a bad guy to you or anybody per-se, but I
think people who got what they wanted earlier should come and defend the
reason why they got what they wanted.

I am nice enough not to threaten them by saying something like "since
nobody seems to be serious enough to defend this earlier change, let's
change our mind and get rid of that warning" ;-)

Oh, I already anticipate that I'll have the same frustration defending the
"deny git push from updating the current branch" that was settled eons
ago.  I am not looking forward to it.
