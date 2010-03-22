From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 20:33:47 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003212011280.14365@iabervon.org>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>  <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>  <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>  <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
  <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>  <20100320210406.GA29899@progeny.tock> <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de>  <20100321110807.GA24016@progeny.tock>
 <alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de> <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 01:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtVac-0000T1-Lj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 01:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0CVAdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 20:33:49 -0400
Received: from iabervon.org ([66.92.72.58]:48503 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab0CVAdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 20:33:49 -0400
Received: (qmail 19197 invoked by uid 1000); 22 Mar 2010 00:33:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2010 00:33:47 -0000
In-Reply-To: <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142877>

On Sun, 21 Mar 2010, Ramkumar Ramachandra wrote:

> Hi,
> 
> > Personally, I would have little problems just adding the remote and
> > checking out the branch, just to test the thing after I got a promising
> > progress report. And I think those who are truly interested in
> > git-remote-svn will have little problems, either. The important part would
> > be the visible progress (i.e. mails by the student to this list).
> 
> Thanks for the elaborate explanation. The way I see it, there are two
> extreme situations I must avoid. The first is being opaque for the
> risk of not being able to integrate it into git.git at the end of the
> summer term. The other extreme is worrying so much about the
> integration of each little bit that the project keeps getting
> detracted, and eventually loses focus. To strike a balance, I will
> post progress reports to the mailing list (atleast) once a week, and
> keep a public development branch for myself. Occasionally, it might
> help to post patches for small components of the project with
> unittests to get a wider test audience.

One thing to keep in mind is that you'll get review at a slower rate than 
you'll make progress, and you'll need progress, review, and fixes to get 
integration. This means that the optimal pattern is to post incomplete 
things (marked [RFC PATCH]) when you've got enough there to show where 
you're going and you think the quality of the code you have is pretty 
good. Your patches go out, and you work on the next step while other 
people find them, read them, write comments, and you get the comments. 
Then you incorporate the changes for the comments into the next round (or 
you acknowledge the need for changes, but defer them to the third round, 
if you've got a second round ready). The thing that really stalls a 
project, either in the middle or at the end, is when you can't do anything 
while you wait for a round-trip exchange with reviewers (or multiple 
round-trips, if the comments are non-trivial and you need further 
explanation or to propose alternatives).

The longer you anticipate between sending the patches out and having them 
included, and the busier you can stay in that time, the better. 
Overlapping does mean that you end up reworking later patches, but (unless 
you can save up hours of work) it's better to have patches to rework than 
to be starting from scratch at that point, and it's better to know what 
you'll have to rework as early as is feasible.

	-Daniel
*This .sig left intentionally blank*
