From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 18:04:54 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212230454.GA20054@thyrsus.com>
References: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
 <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
 <20131212193918.GA17529@thyrsus.com>
 <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
 <20131212205819.GA18166@thyrsus.com>
 <CACPiFCJDP6OVju2xzm2NWR5gc=bZDeNmXsD_MFH2mgHQru_u6Q@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 00:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrFJU-0004c0-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 00:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3LLXE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 18:04:56 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43196
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3LLXEz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 18:04:55 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id D18A3380459; Thu, 12 Dec 2013 18:04:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCJDP6OVju2xzm2NWR5gc=bZDeNmXsD_MFH2mgHQru_u6Q@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239249>

Martin Langhoff <martin.langhoff@gmail.com>:
> On Thu, Dec 12, 2013 at 3:58 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> >>  - regardless of commit ids, do you synthesize an artificial commit?
> >> How do you define parenthood for that artificial commit?
> >
> > Because tagging is never used to deduce changesets, the case does not arise.
> 
> So if a branch has a nonsensical branching point, or a tag is
> nonsensical, is it ignored and not imported?

I don't know what happens when identically-named tags point at changes that
resolve into two different commits.  I will figure that out and document it.

There's evidence, in the form of some code that is #ifdefed out, that 
Keith considered trying to make synthetic commits from tag cliques. But
abandoned the idea because he couldn't figure out how to assign such
cliques to a branch.

I'm not sure what counts as a nonsensical branching point. I do know that
Keith left this rather cryptic note in a REAME:

	Disjoint branch resolution. Branches occurring in a subset of the
	files are not correctly resolved; instead, an entirely disjoint
	history will be created containing the branch revisions and all
	parents back to the root. I'm not sure how to fix this; it seems
	to implicitly assume there will be only a single place to attach as
	branch parent, which may not be the case. In any case, the right
	revision will have a superset of the revisions present in the
	original branch parent; perhaps that will suffice.

-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
