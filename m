From: Karl Fogel <kfogel@red-bean.com>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 15:44:41 -0700
Message-ID: <87sl7qzjty.fsf@red-bean.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	<469804B4.1040509@alum.mit.edu>
	<46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	<4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
	<46994BDF.6050803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com,  Martin Langhoff <martin.langhoff@gmail.com>,
    Julian Phillips <julian@quantumfyre.co.uk>,  git@vger.kernel.org,
    dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: dev-return-2045-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sun Jul 15 00:44:49 2007
Return-path: <dev-return-2045-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9qM4-0005Mc-S4
	for gcvscd-dev@gmane.org; Sun, 15 Jul 2007 00:44:49 +0200
Received: (qmail 10327 invoked by uid 5000); 14 Jul 2007 22:44:46 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 10317 invoked from network); 14 Jul 2007 22:44:46 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAELvmEZCksE9kmdsb2JhbACPOwEBAgcEBg4Z
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="62156557:sNHT25736067"
X-IRONPORT: SCANNED
Mail-followup-to: dev@cvs2svn.tigris.org
In-Reply-To: <46994BDF.6050803@alum.mit.edu> (Michael Haggerty's message of "Sun\, 15 Jul 2007 00\:19\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52515>

Michael Haggerty <mhagger@alum.mit.edu> writes:
> My idea is not to built (for example) cvs2git; rather, I'd like cvs2svn
> to be split conceptually into two tools:
>
> cvs2<abstract_description_of_cvs_history>, whose job it is to determine
> the most likely "true" CVS history based on the data stored in the CVS
> repository, and
>
> <abstract_description_of_cvs_history>2svn
>
> Then later write
>
> <abstract_description_of_cvs_history>2git
> <abstract_description_of_cvs_history>2hg
>
> etc.
>
> The first split is partly done in cvs2svn 2.0.  And I naively imagine
> that writing the new output back ends won't be all that much work.

I think an intermediate interchange format is the right way to go.

But, isn't this what VCP / RevML is all about?  Perhaps RevML is
already suited to be that interchange format... (Haven't looked at it
in detail, just pointing out that there has at least been an attempt
to reinvent this wheel already :-) ).

-Karl
