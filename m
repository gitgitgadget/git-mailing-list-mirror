From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: CVS -> SVN -> Git
Date: Thu, 19 Jul 2007 21:14:18 +0200
Message-ID: <469FB80A.8000001@fs.ei.tum.de>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu>	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>	 <46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com> <46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: esr@thyrsus.com, Michael Haggerty <mhagger@alum.mit.edu>, 
 Julian Phillips <julian@quantumfyre.co.uk>,
  git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: dev-return-2069-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Jul 19 21:20:15 2007
Return-path: <dev-return-2069-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IBbXq-0004pg-78
	for gcvscd-dev@gmane.org; Thu, 19 Jul 2007 21:20:14 +0200
Received: (qmail 19220 invoked by uid 5000); 19 Jul 2007 19:20:12 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Delivered-To: moderator for dev@cvs2svn.tigris.org
Received: (qmail 15060 invoked from network); 19 Jul 2007 19:14:23 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAF9Un0aBuzYH/2dsb2JhbAAt
X-IronPort-AV: i="4.16,558,1175497200"; 
   d="scan'208"; a="62491095:sNHT19628070"
X-IRONPORT: SCANNED
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53022>

[sorry for jumping in so late, didn't read git@vger for a while]

Martin Langhoff wrote:
> On 7/15/07, Eric S. Raymond <esr@thyrsus.com> wrote:
>> Not quite.  I'm suggesting it's an appropriate lingua franca for 
>> centralized
>> VCSes with branching, e.g. everything pre-Arch.

I do not think Eric is right here.  You will allways lose information when converting CVS to svn, and if it is just the uncertainty, the non-atomicity.  This is also information (hidden one, though).

> That's a huge goal that gets in the way of waht we want to do here: we
> are trying to save time, not embark on some huge mission.
> 
> cvs2svn has all the "wtf-did-cvs-mean-by-that" algorithms that are
> very hard to write and maintain, and it seems to be the best one at
> that. Of course, it also writes SVN repos -- but I'm sure that's the
> easiest part.

True.  However, cvs2svn has many assumptions (or at least has had when I last checked) which are targeted to svn, and unsuitable for a generic system (tags + branches).

>     We don't need no meta VCS for any of this.

Yes.  I've already done what people want, it is not called cvs2xxx, but fromcvs [1].  I don't think it is necessary to define an output format.  Of course, that's possible, but limiting yourself to a file format means you're losing flexibility, which is needed for efficient, correct and fast repository conversion.

cheers
  simon

[1] http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs/

-- 
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low €€€ NOW!1  +++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
