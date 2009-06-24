From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 23:35:56 -0700
Message-ID: <7vbpoe16lv.fsf@alter.siamese.dyndns.org>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org>
	<4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>
	<4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org>
	<f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com>
	<7vprcu96td.fsf@alter.siamese.dyndns.org>
	<buoljniyybp.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, Finn Arne Gangstad <finnag@pvv.org>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 08:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJM5W-0001v4-AQ
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 08:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbZFXGf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZFXGfz
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 02:35:55 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42484 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZFXGfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 02:35:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624063557.SCHZ17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 24 Jun 2009 02:35:57 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7ibx1c0024aMwMQ03ibxtd; Wed, 24 Jun 2009 02:35:57 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=mDV3o1hIAAAA:8 a=ybZZDoGAAAAA:8
 a=ad8oPz71dUZTKxbEULwA:9 a=oTqu3a-XxDy-yJ5I6Ykcu9UsEvUA:4 a=ii61gXl28gQA:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <buoljniyybp.fsf@dhlpc061.dev.necel.com> (Miles Bader's message of "Wed\, 24 Jun 2009 14\:50\:50 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122126>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> However, when 'feature' is fully cooked, before pushing it back to be
>> shared with others in the group, don't you do any testing with the work
>> done by others while you were working on 'feature'?  That means you first
>> integrate your 'feature' locally into shared 'master' and make sure all
>> fits together well.
>
> You seem to be making a lot of assumptions about workflows here.
>
> It seems quite plausible to me that one might want to keep the remote
> branch separate, even after pushing.  It's very common to cooperatively
> develop feature branches for a very long time before merging to the
> "real" master, but it's still extremely useful to keep them as branches
> in the same local git directory.

Sorry, but I do not understand your point.

My "feature is cooked, let's test it together with master" does not mean
"Now we are done with the feature, so let's 'branch -d' it" at all.  That
is an orthogonal issue.  You can keep 'feature' in the local repository
indefinitely.

Keeping the remote branch separate means pushing 'feature' to 'feature',
and keep it there.  I do not have any problem with that, either.

The '--track' I was having hard time justifying to myself was about
pushing 'feature' (and other features 'feature2', 'feature3',... that are
all forked from 'master' at the remote side) to 'master' at remote.  In
other words, the workflow being discussed to support why --track was a
good mode was about updating the remote 'master', not about keeping the
branches separate.

Either you are not following the thread, or you are agreeing with me
without realizing, or perhaps a bit of both.
