From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: CVS -> SVN -> Git
Date: Mon, 16 Jul 2007 13:08:09 +1200
Message-ID: <46a038f90707151808u67c4e834lb06ed86c855f58ec@mail.gmail.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	 <469804B4.1040509@alum.mit.edu>
	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
	 <46994BDF.6050803@alum.mit.edu>
	 <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
	 <469A099E.6060906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Frech" <david@nimblemachines.com>, esr@thyrsus.com, 
	"Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org, 
	dev <dev@cvs2svn.tigris.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: dev-return-2062-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Mon Jul 16 03:08:14 2007
Return-path: <dev-return-2062-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IAF4O-000372-Tv
	for gcvscd-dev@gmane.org; Mon, 16 Jul 2007 03:08:13 +0200
Received: (qmail 7126 invoked by uid 5000); 16 Jul 2007 01:08:11 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 7116 invoked from network); 16 Jul 2007 01:08:11 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAJJhmkZC+VLql2dsb2JhbACPPwEBAgcCCAcIFg
X-IronPort-AV: i="4.16,540,1175497200"; 
   d="scan'208"; a="62206588:sNHT27026181"
X-IRONPORT: SCANNED
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=POpxDaN4SKp37WJpSbMQx/a3oN76TZTzxS8b+ErhKzJoS/69QUVrrbl1L3gp9k/YkXSx8MgsKdVuNn8nRrYDp7EfelPAMSykaHrkckVjJVuYq7p/5dvJT94l4c2RB9eXfiLF/LqdBPNiA0992hnBO3kcAtR9fRxoWdDU/1OfY1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s1oDOarMaauax3+F762k4BqJg7eyap0Cr3B24iFXwvNYj+ZgyJaj7QfDPxaMrZAqRRiiUnTTn35dpTzPBkHVY19uO+7qsoW5PgoCvnoWhWlGCGHA/jlR9mmzbduzJQ+rDfhGZO7YuiT16831+VKhw7oq5v30WhIzr5GCRg3SOQA=
In-Reply-To: <469A099E.6060906@alum.mit.edu>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52616>

On 7/15/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > It took a day and half to get the svn dump parsing right (it's an
> > egregiously bad format) but only a couple of hours to write the
> > fast-import backend.
>
> I'm surprised you think that; I find the svn dump format quite easy and
> straightforward.  (Of course it assumes some Subversionisms, like easy
> deep directory copies, which I can imagine would be annoying in other
> contexts.)  What don't you like about the format?

Is there good doco and samples for it? I wouldn't mind doing things by
way of an SVN dump parser.

> Yes, fast-import is a very easy-to-write format and looks to be very
> well documented.  I don't think that having to write output in
> fast-import format would be any kind of a hindrance for such a tool.

Damn! You've now figured out that all my volunteering was for the easy
part of the job ;-)




m
