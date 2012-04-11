From: Hadmut Danisch <hadmut@danisch.de>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 13:47:51 +0200
Message-ID: <4F856F67.4000609@danisch.de>
References: <4F855E6B.4010504@danisch.de> <20120411105906.GA19823@burratino> <4F8565BC.1070701@danisch.de> <vpq7gxmzf75.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 11 13:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHw1m-0000Tu-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 13:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab2DKLry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 07:47:54 -0400
Received: from mail.rackland.de ([212.86.200.188]:50662 "EHLO mail.rackland.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab2DKLrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 07:47:53 -0400
Received: from [192.168.160.116] (178-26-58-165-dynip.superkabel.de [178.26.58.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.rackland.de (Postfix) with ESMTPSA id D1A482C0CF;
	Wed, 11 Apr 2012 13:47:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <vpq7gxmzf75.fsf@bauges.imag.fr>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195169>

Am 11.04.2012 13:21, schrieb Matthieu Moy:
> BTW, it is rarely good practice to create an empty branch in an existing
> repository. You'll have different branches that do not share any
> history, and they would likely be better in separate repositories (or at
> least, be in separate local repositories, pushed to the same remote bare
> repository, in which case you don't need anything special, just "git
> init" and "git push"). That doesn't mean you shouldn't do it, but just
> that you may want to think twice before doing it ;-).

That's a pretty good point for discussion.


Sometimes people are working on different sorts of information, that are
nevertheless closely related, e.g. open source software and the web
pages describing it (like in git hub), or a web server tree and the
software generating it. They are related, but do not logically share a
history.


Creating independent branches by pushing two separates into a single
remote bare is a nice idea, but if I understood git correctly, the very
first commit in a repos is always to the master branch, where you have
two masters trying to push into the shared remote bare. This is
obviously solvable if you use the correct commands and maybe delete and
re-clone the repos, but this is all overcomplicated and non-trivial.
Nothing I could do without reading manuals.

So your proposal might work perfectly, but in my eyes it is error prone
and not user friendly.

regards
