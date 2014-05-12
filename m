From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 11:42:32 +0200
Message-ID: <53709788.2050201@alum.mit.edu>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= =?UTF-8?B?ZW4=?= 
	<tboegi@web.de>, Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 11:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjml4-0003hH-9s
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 11:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbaELJmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 05:42:45 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63237 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753474AbaELJmn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 05:42:43 -0400
X-AuditID: 12074413-f79076d000002d17-83-5370979284e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 73.9E.11543.29790735; Mon, 12 May 2014 05:42:42 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1CF6.dip0.t-ipconnect.de [93.219.28.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4C9gWu5024037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 May 2014 05:42:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <537008f06ceb8_8e47492f89f@nysa.notmuch>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsUixO6iqDtpekGwwfO9kha/zu5isZjx6jm7
	xcof79ksDj7Os9i16hybRdeVbiaLG+d3sVr8aOlhtjjUkmTR2fGV0eJR31t2B26PqedDPXbO
	usvusWfiSTaPs48eMHtcW7WfzePEjN8sHk+PfmL3eNa7h9Hj8yY5j9vPtrEEcEVx2yQllpQF
	Z6bn6dslcGecPHuVseCSasWjw8tYGxiXy3UxcnJICJhInFsznRXCFpO4cG89WxcjF4eQwGVG
	icMX2qGc80wSR29vZQKp4hXQltj+fAo7iM0ioCrx7u9LsDibgK7Eop5mIJuDQ1QgSOLPWUWI
	ckGJkzOfsIDYIgIZEv8vvGQGmckscJBJonVBL1hCWMBK4s26vcwgthDQRc9ObGABmcMpYCqx
	r4UTxJQQEJfoaQwCMZkF1CXWzxMCKWYWkJfY/nYO8wRGwVlIls1CqJqFpGoBI/MqRrnEnNJc
	3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJD4Et7BuOuk3CFGAQ5GJR5eD+aCYCHWxLLi
	ytxDjJIcTEqivB+mAYX4kvJTKjMSizPii0pzUosPMUpwMCuJ8J6cCJTjTUmsrEotyodJSXOw
	KInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwHgYZKliUmp5akZaZU4KQZuLgBBnOJSVSnJqX
	klqUWFqSEQ+K3fhiYPSCpHiA9tpPB9lbXJCYCxSFaD3FqMtxoWFFC5MQS15+XqqUOC8vyA4B
	kKKM0jy4FbBk+opRHOhjYd41IFU8wEQMN+kV0BImoCVW0vkgS0oSEVJSDYxTHNJ2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248693>

On 05/12/2014 01:34 AM, Felipe Contreras wrote:
> Recently Junio said he was willing to hear the opinion of other people
> regarding the move from contrib to the core[1]. This move is already
> under way, but suddenly Junio changed his mind.

I agree with Junio.  There are good technical arguments for and against
moving git-remote-hg out of contrib.  Those arguments were discussed at
length and I think their weight is on the side of not moving it.  But
there are two other (in my opinion, stronger) reasons for keeping
git-remote-hg out of the core:

1. That subproject has not been maintained to the standards of the Git
project; specifically, Git project standards include good commit
messages and a willingness to engage with the community on a friendly
and constructive way and to welcome feedback.  Because of your
confrontational and nit-picking style, Felipe, many people who have
tried to help you improve your work are rebuffed and end up giving up
out of frustration or exhaustion.  Because of this, your commits do not
benefit from the usual amount of help from the community and therefore
their quality is not as high as required for commits to core Git.

2. Moving git-remote-hg into the core would require even *more* of your
presence on the Git mailing list.  But your very presence is detrimental
to the rest of the community.  You insult and frustrate people who are
trying to help you.  You attribute malign motivations to people who are
trying to be scrupulously fair.  You string out enormous threads of
nit-picking, legalistic argumentativeness that have little to do with
the real issues at hand.

The last big "Felipe eruption" in the summer of 2013 caused an enormous
amount of strife, wasted an inordinate amount of time of other community
members, and caused at least one valued contributor to temporarily
rage-quit the community.  That episode only ended when Junio asked you
to leave the community [1], which, thankfully, you did for a while.

After you left, the atmosphere of the mailing list soon returned to its
usual friendly, collegial, and efficient norm.

Recently you returned to the mailing list.  In my opinion everybody on
the list, including especially Junio, interacted with you in a very
polite and businesslike manner.  I believe you were given an honest
chance at a fresh start in the community.  I wish you had taken it.  The
Git project could really benefit from the help of a skilled and
energetic developer like you!

But it didn't take long before you started the same theatrics again.
And now again, dealing with your caustic attitude is wasting an order of
magnitude more time of the other core developers than your contributions
could possibly bring in benefits.

For me, the conclusion is unfortunate but clear: Felipe Contreras is (by
far) a net liability to the Git project.  Specifically:

* The Git project will progress faster without you because the other
  contributors will have to waste less time dealing with your antics.

* The Git community will grow faster without you, because your presence
  will not cause existing contributors to withdraw and dissuade new
  contributors from joining.

* The community will be a lot more pleasant without you.

Therefore, I am happy that you have apparently decided to split
git-remote-hg into a separate project.  I wish you success with the
project and I see no reason that it shouldn't continue to be successful.
 But I am glad that I will not have to interact with you anymore.

> [...] Does it make sense to you that
> you get thrown in jail for a crime you haven't committed merely because
> someone thinks it's likely you will?

Being the leader of your own valuable open-source project is nothing
like jail.  It is an opportunity for you to shine in an environment that
is more suited to your personality.

> Given the huge amount of work I've put in these remote helpers, and the
> fact that Junio said since day 1 he wanted these in the core[5] (and I
> was operating under that assumption), I think the demotion back to the
> contrib area (and therefore out-of-tree) should be made carefully, and
> not from one day to he next as it happened.

None of the work was wasted.  git-remote-hg can live on.

This email is written in sorrow, not in anger.  Felipe, you seem to have
so much potential.  If you would put as much effort in conducting social
interactions as you do in coding, the whole balance would change
entirely, and any software project would be happy to have you.  With all
my heart I truly wish you the best in your future endeavors.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/227750

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
