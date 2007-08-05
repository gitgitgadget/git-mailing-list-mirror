From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Sun, 5 Aug 2007 09:58:00 +0200
Message-ID: <20070805075800.GA4256@ugly.local>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B2132D.7090304@alum.mit.edu> <9e4733910708021659y6e9bb7ddk58817b4de3df26a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: users-return-1646-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Sun Aug 05 09:58:07 2007
Return-path: <users-return-1646-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IHb03-0004Qy-2t
	for gcvscu-users@gmane.org; Sun, 05 Aug 2007 09:58:07 +0200
Received: (qmail 9873 invoked by uid 5000); 5 Aug 2007 07:58:04 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 9861 invoked from network); 5 Aug 2007 07:58:04 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAACIgtUaD9nj6n2dsb2JhbACOEgEBAgcEBgcIGA
X-IronPort-AV: i="4.19,221,1183359600"; 
   d="scan'208"; a="63619505:sNHT18209646"
X-IRONPORT: SCANNED
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
Content-Disposition: inline
In-Reply-To: <9e4733910708021659y6e9bb7ddk58817b4de3df26a0@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-07-16)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54965>

On Thu, Aug 02, 2007 at 07:59:41PM -0400, Jon Smirl wrote:
> I seem to recall discussing an algorithm  to fix this on the cvs2svn
> mailing list. There was a somewhat simple way to correlate the
> "unlabeled-1.2.4" in one file might be the same as "unlabeled-1.2.6"
> problem.
> 
yes, name them after the first symbol that appears on them. like
unlabeled-1.2.4 being named __KDE_3_5_RELEASE because of such tag
(without the underscores, obviously) appearing on it.
the naive per-file implementation doesn't get you that far, though.
again, one'd have to collect data from all files first, correlate
it and make a "majority vote". very similar to your favorite symbol
source problem. ;)

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
