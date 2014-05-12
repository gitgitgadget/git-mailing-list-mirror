From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 12:35:05 +0200
Message-ID: <1399890905.11985.51.camel@seahawk>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
	 <53709788.2050201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 12 12:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjnZk-0005GF-HS
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 12:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbaELKfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 06:35:10 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:51868 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaELKfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 06:35:08 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so4555679eek.3
        for <git@vger.kernel.org>; Mon, 12 May 2014 03:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=0/2JpyyOe5j4fZm38fUNrdPbiQcbvEghQafqgDPXkE8=;
        b=J4xwm/DgkvNup3QLCwMnwnk255HGBEl0UwYCyLPJrzTCFqwvwEBFgH+1UfTrJefnhn
         QEHUQXxF4HfEiXkDYu8amR3H84EJJw5sswi4uzbobbn2/2sFXQ/dS0MMx7OuXWqReBBE
         j7w8PatU2lZr95H4wNT4vCthB8MSKdO9lfWR629i0oBeUorqOTtmfc2YfFlJQgLANiIW
         tF4+iLVo2s0G780YCMztWiYB0csxKcmzHRuA1cJyVvUx/ORF0b7SQFl1ghgZsYuIYcOw
         7j/Q7v7QsLD9xAHTN0N9iYq9/ifAXYGN+9aBH6l+3IXQsdF+Sy02aDVPddqmZiYzRuYR
         fhcQ==
X-Gm-Message-State: ALoCoQlAMOV1Tv5gIh7iR4cXTT35CZPNzAU7HXRrb0vYgcOeE7YgdKY7DrYQZ9mCqhxZ+5Rd5yKY
X-Received: by 10.14.183.5 with SMTP id p5mr31715782eem.52.1399890907458;
        Mon, 12 May 2014 03:35:07 -0700 (PDT)
Received: from [10.155.73.156] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id z44sm31920046eep.39.2014.05.12.03.35.05
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 12 May 2014 03:35:06 -0700 (PDT)
In-Reply-To: <53709788.2050201@alum.mit.edu>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248695>

Michael,

Thank you for writing this, I have to see I agree completely. As a
mostly lurker on this list, I tend to skip any thread Felipe is
participating in, as it tends to quickly spiral out of control.

This is also the main reason for me not to actively participate a bit
more, I prefer reasonable discussions over fighting.

On ma, 2014-05-12 at 11:42 +0200, Michael Haggerty wrote:
> On 05/12/2014 01:34 AM, Felipe Contreras wrote:
> > Recently Junio said he was willing to hear the opinion of other people
> > regarding the move from contrib to the core[1]. This move is already
> > under way, but suddenly Junio changed his mind.
> 
> I agree with Junio.  There are good technical arguments for and against
> moving git-remote-hg out of contrib.  Those arguments were discussed at
> length and I think their weight is on the side of not moving it.  But
> there are two other (in my opinion, stronger) reasons for keeping
> git-remote-hg out of the core:
> 
> 1. That subproject has not been maintained to the standards of the Git
> project; specifically, Git project standards include good commit
> messages and a willingness to engage with the community on a friendly
> and constructive way and to welcome feedback.  Because of your
> confrontational and nit-picking style, Felipe, many people who have
> tried to help you improve your work are rebuffed and end up giving up
> out of frustration or exhaustion.  Because of this, your commits do not
> benefit from the usual amount of help from the community and therefore
> their quality is not as high as required for commits to core Git.
> 
> 2. Moving git-remote-hg into the core would require even *more* of your
> presence on the Git mailing list.  But your very presence is detrimental
> to the rest of the community.  You insult and frustrate people who are
> trying to help you.  You attribute malign motivations to people who are
> trying to be scrupulously fair.  You string out enormous threads of
> nit-picking, legalistic argumentativeness that have little to do with
> the real issues at hand.
> 
> The last big "Felipe eruption" in the summer of 2013 caused an enormous
> amount of strife, wasted an inordinate amount of time of other community
> members, and caused at least one valued contributor to temporarily
> rage-quit the community.  That episode only ended when Junio asked you
> to leave the community [1], which, thankfully, you did for a while.
> 
> After you left, the atmosphere of the mailing list soon returned to its
> usual friendly, collegial, and efficient norm.
> 
> Recently you returned to the mailing list.  In my opinion everybody on
> the list, including especially Junio, interacted with you in a very
> polite and businesslike manner.  I believe you were given an honest
> chance at a fresh start in the community.  I wish you had taken it.  The
> Git project could really benefit from the help of a skilled and
> energetic developer like you!
> 
> But it didn't take long before you started the same theatrics again.
> And now again, dealing with your caustic attitude is wasting an order of
> magnitude more time of the other core developers than your contributions
> could possibly bring in benefits.
> 
> For me, the conclusion is unfortunate but clear: Felipe Contreras is (by
> far) a net liability to the Git project.  Specifically:
> 
> * The Git project will progress faster without you because the other
>   contributors will have to waste less time dealing with your antics.
> 
> * The Git community will grow faster without you, because your presence
>   will not cause existing contributors to withdraw and dissuade new
>   contributors from joining.
> 
> * The community will be a lot more pleasant without you.
> 
> Therefore, I am happy that you have apparently decided to split
> git-remote-hg into a separate project.  I wish you success with the
> project and I see no reason that it shouldn't continue to be successful.
>  But I am glad that I will not have to interact with you anymore.
> 
> > [...] Does it make sense to you that
> > you get thrown in jail for a crime you haven't committed merely because
> > someone thinks it's likely you will?
> 
> Being the leader of your own valuable open-source project is nothing
> like jail.  It is an opportunity for you to shine in an environment that
> is more suited to your personality.
> 
> > Given the huge amount of work I've put in these remote helpers, and the
> > fact that Junio said since day 1 he wanted these in the core[5] (and I
> > was operating under that assumption), I think the demotion back to the
> > contrib area (and therefore out-of-tree) should be made carefully, and
> > not from one day to he next as it happened.
> 
> None of the work was wasted.  git-remote-hg can live on.
> 
> This email is written in sorrow, not in anger.  Felipe, you seem to have
> so much potential.  If you would put as much effort in conducting social
> interactions as you do in coding, the whole balance would change
> entirely, and any software project would be happy to have you.  With all
> my heart I truly wish you the best in your future endeavors.
> 
> Michael
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/227750
> 

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
