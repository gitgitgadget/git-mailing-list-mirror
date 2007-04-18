From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 14:21:37 -0700
Message-ID: <f2b55d220704181421o3376d69fh8d0217de3c8242bf@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417104520.GB4946@moonlight.home>
	 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	 <200704171818.28256.andyparkins@gmail.com>
	 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	 <Pine.LNX.4.64.0704181130150.12094@racer.site>
	 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	 <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marcin Kasperski" <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHb1-0004Mz-89
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992767AbXDRVVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992760AbXDRVVk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:21:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:9028 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992768AbXDRVVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 17:21:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so338416wxd
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 14:21:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SQmJYKlGGBKsDbphHJKvwizbwrWEEmMuvJwR8Z4BvasVkm6RzIdsKd98H8kSNZ2BNLk8Jpx7otAsKBTe1utfvWCblgt4nhq5knFbIEXFSJFhzTKgpvCfllLZq1K9K+YqNf0cfGRaiePlxAFkX7wydviKlE/RfwG2HOiG547+PcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cOtKoYAGEGz33SvsoZpZ4b/4kuEZrIfwByzIjncouSMP+chb+IGRzoeSA7cTSP5TRx1XM25qwztRF4yLZxQujDxHO7UbXcuowr5uXu/sfom2wKC5wVKpqt/DsUifXLvX4Vn8zn7HcVWLPRyOLXSxUtqbH44WY8VdsZim8o/6amE=
Received: by 10.70.19.16 with SMTP id 16mr1729380wxs.1176931297803;
        Wed, 18 Apr 2007 14:21:37 -0700 (PDT)
Received: by 10.70.17.7 with HTTP; Wed, 18 Apr 2007 14:21:37 -0700 (PDT)
In-Reply-To: <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44951>

Suppose I were dealing with career software developers, backed by real
money, who also happened to be intelligent, thoughtful people, and I
wanted to make the case for git vs. CVS/SVN.  I'd start by handing
them copies of the O'Reilly Perforce book and suggesting that they
read it cover to cover.  Focus on the chapters on how well organized
development and release branches, and good tracking of feature/fix
propagation among them, can help you cope with the vagaries of
real-life software development.

Then I'd explain the relative merits of Perforce and git -- on one
hand, availability and quality of documentation, training, tech
support, and Windows versions; on the other hand, a genuinely
distributed design, which means that you don't need psychic powers to
arrive at a sane branch structure.  Specifically, git's design makes
private branches ultra-cheap for the developers that use them and
zero-impact on the release infrastructure, and the integrity of
_content_ and _history_ doesn't rely on any resemblance between my
branch layout and yours.  Speed, scalability, zero license cost, and
the hypothetical ability to hack on it yourself are nice too, but
they're basically fringe issues unless you're so big that you can't
just throw money at the problem -- in which case they're still fringe
issues because you're the enterprise-customer tail that wags the
vendor dog.  (If you're big _and_ cash-poor, or if you're stuck on a
VC system so badly designed that no amount of money thrown at the
problem will help, you have a different problem.)

If you do this right, it should be clear that CVS is in the dust on
all fronts and SVN doesn't (AFAICT) have any advantage over Perforce
that git doesn't have more of.  You might also mention that git was
designed by Linus to systematically not suck, and has been
successfully handed over to a strong maintenance/enhancement team that
works in public view.  And Linus is still here policing to keep
suckage from creeping in.  ;-)  The hypothetical smart developers will
then agree to go with either Perforce or git, depending on which the
people who have to do the hard work -- release managers and the IT
Morlocks -- are most comfortable with.

If you take this route, be prepared to wind up with Perforce.  It's
got its weaknesses, and I prefer git myself, but you could certainly
do a lot worse.  I'm not as anti-SVN as Linus, but there aren't many
workflows for which I would recommend it over Perforce.  Personally, I
wouldn't voluntarily introduce any other version control system into
the discussion, because the others that I've used in the course of one
day job or another suck massively by comparison, and the ones I
haven't used (or have only toyed with) don't appear to have any
compelling advantage over git.  (Having _marginally_ better
documentation isn't much to brag about).

Until someone writes a good book on git and sets up shop as a
commercial support organization, presenting Perforce vs. git as a
classic buy/build decision is probably the best you can do.  (You
don't have to "build" git, of course, but you'd have to build your own
in-house training and tech support capability.)  I say this as someone
who routinely sits in the "release manager" chair, uses git by choice,
and is currently suffering the pain and agony of migrating a perfectly
good git-based integration process to Perforce, simply because it
appears to be the right thing for this developer organization.
(Doubtless this colors my opinion du jour.)

Cheers,
- Michael
