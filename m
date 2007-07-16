From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: CVS -> SVN -> Git
Date: Mon, 16 Jul 2007 13:05:37 +1200
Message-ID: <46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	 <469804B4.1040509@alum.mit.edu>
	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
	 <46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>, 
	"Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org, 
	dev <dev@cvs2svn.tigris.org>
To: esr@thyrsus.com
X-From: dev-return-2061-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Mon Jul 16 03:05:46 2007
Return-path: <dev-return-2061-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IAF1x-0002bM-Bs
	for gcvscd-dev@gmane.org; Mon, 16 Jul 2007 03:05:43 +0200
Received: (qmail 6097 invoked by uid 5000); 16 Jul 2007 01:05:38 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 6087 invoked from network); 16 Jul 2007 01:05:38 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAJJhmkZC+VLsjWdsb2JhbACPPwEBAgcCBgkIGA
X-IronPort-AV: i="4.16,540,1175497200"; 
   d="scan'208"; a="62206529:sNHT18804044"
X-IRONPORT: SCANNED
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Euz8RyZtyeRJqtF0ju+ecWrh+96o/F3tzmJtOP4k7dZ55aEbeR3JrN4alkvLBYcBOa9M19zKyyaIxWrsOT7xrju024otgSz7keGvm8lUpZcEZ8zgIdzezZR2axB4YIIJTf7PiYdbnI14Pya51b7n3cIm69zMhcYkQzU+fbOuDGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r9dEFa3IWaG0XcI7NmFCPzXfRcgRuaRAKrGL3jVONxbvJLzm/tX87ZY60GlLnyV0XiyfaEdmKjLwZMaOJ1g6miAaGZBjgnlAVeJio75yzhZcVCw86EPQAH+OrUJxq0GU09zfQ18ksRFJCkDs5ieBejfQVXZcTwnbEkcIWAzTKxA=
In-Reply-To: <20070715013949.GA20850@thyrsus.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52615>

On 7/15/07, Eric S. Raymond <esr@thyrsus.com> wrote:
> Not quite.  I'm suggesting it's an appropriate lingua franca for centralized
> VCSes with branching, e.g. everything pre-Arch.

That's a huge goal that gets in the way of waht we want to do here: we
are trying to save time, not embark on some huge mission.

cvs2svn has all the "wtf-did-cvs-mean-by-that" algorithms that are
very hard to write and maintain, and it seems to be the best one at
that. Of course, it also writes SVN repos -- but I'm sure that's the
easiest part.

     We don't need no meta VCS for any of this.

All we need is to hook into the "write out a repo based on all the
stuff we parsed from cvs". Perhaps it's doable, and if Michael helps
out abstracting that part a bit, maintainable long term too.

cheers,



m
