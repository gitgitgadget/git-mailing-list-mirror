From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: Re: [git] Re: Bug in git-stash(.sh) ?
Date: Fri, 4 May 2012 01:21:07 -0400
Message-ID: <20120504052106.GA15970@sigill.intra.peff.net>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
 <87wr4za9mr.fsf@gmail.com>
 <m2pqasb8mr.fsf@linux-m68k.org>
 <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
 <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
 <20380.33897.666338.766096@winooski.ccs.neu.edu>
 <20120429220132.GB4491@sigill.intra.peff.net>
 <20381.49180.329586.983166@winooski.ccs.neu.edu>
 <20120501134254.GA11900@sigill.intra.peff.net>
 <20386.53745.200846.115335@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
X-From: magit+bncCN2hpKqZChDHzo39BBoEvRlLKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 04 07:21:14 2012
Return-path: <magit+bncCN2hpKqZChDHzo39BBoEvRlLKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChDHzo39BBoEvRlLKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQAx6-0005bR-TV
	for gcvgm-magit-3@m.gmane.org; Fri, 04 May 2012 07:21:13 +0200
Received: by qabg40 with SMTP id g40sf1245632qab.10
        for <gcvgm-magit-3@m.gmane.org>; Thu, 03 May 2012 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=NWvhDR1tynBDkJj8ECv4nEDhyKVCdYnOkVBX7rcdxGk=;
        b=g17Rslmte0apR7Q0TbLEgR143rRFtvz5PT25cM+ZbLZqZndnKB3uL+l7SVxGmmf9VR
         0/ndyiFyBAx+3N38sd4p/CQ/b3by2b5my4vH0wuwcz25gqKhGBJGfkA3dit0SY433oMi
         rz7o5P5ezprZW3J4W7CleXH8QjcsMOu9XDH7o=
Received: by 10.50.179.65 with SMTP id de1mr300767igc.0.1336108871717;
        Thu, 03 May 2012 22:21:11 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.58.146 with SMTP id g18ls1541505ibh.3.gmail; Thu, 03 May
 2012 22:21:11 -0700 (PDT)
Received: by 10.50.159.133 with SMTP id xc5mr2934649igb.0.1336108871199;
        Thu, 03 May 2012 22:21:11 -0700 (PDT)
Received: by 10.50.159.133 with SMTP id xc5mr2934648igb.0.1336108871187;
        Thu, 03 May 2012 22:21:11 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id e7si916904iga.3.2012.05.03.22.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 22:21:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 14975 invoked by uid 107); 4 May 2012 05:21:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 01:21:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 01:21:07 -0400
In-Reply-To: <20386.53745.200846.115335-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org>
X-Original-Sender: peff-AdEPDUrAXsQ@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) smtp.mail=peff-AdEPDUrAXsQ@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196987>

On Thu, May 03, 2012 at 02:44:01PM -0400, Eli Barzilay wrote:

> > Once that is fixed, then we can consider whether something more should
> > happen for stash (though I am inclined to say that is enough; it is a
> > feature that you can do "git stash list --date=relative" to see the
> > stash timestamps).
> 
> Since the general problem is bigger, how about just the quick patch of
> adding --date=default in the list_stash function as a stopgap?  That
> seems to be close enough to how it should work anyway.

It is bigger in scope, but the fix is still pretty small. I was trying
to trick^W gently prod you into making a patch, but that does not seem
to have worked. :) So here is a series that fixes it, and we don't have
to worry about a stopgap.

  [1/4]: t1411: add more selector index/date tests
  [2/4]: log: respect date_mode_explicit --format:%gd
  [3/4]: reflog-walk: clean up "flag" field of commit_reflog struct
  [4/4]: reflog-walk: always make HEAD@{0} show indexed selectors

The first two fix and test the bug I mentioned, and as a result solve
the stash problem. The second two fix and test the bug that Junio
mentioned. This doesn't affect stash, but it's the right thing for "git
log" to do.

> > >   * Some new %gi uses the index number: stash@{1}, and %gI produces
> > >     refs/stash@{1}, unrelated to any date setting
> > >   * git-stash.sh uses %gi so the output has the numbers
> > >   * Some new option for "stash list" for the format string, so it's
> > >     possible to show the dates if you want to with something like
> > >     git stash list --format:"%gi: %gs (%gd)"
> > 
> > I don't have a huge problem with that. But what issue is it really
> > solving? Are people using "git stash list --date=iso" and then
> > getting confused by the output? Or is it simply a matter of
> > mistakenly applying the config when it should not be? The latter
> > needs fixed in either case.
> 
> It's basically an attempt to have a %gi that is disconnected from date
> options (config or flags), which solves the config problem in a
> trivial way (no date options are used)...

I don't have a problem at all with %gi; I think it would be a good
addition. I just think that stash shouldn't use, as the "--date" thing
is a feature that there is no reason to deny to stash users (it just
needs to be less buggy :) ).

-Peff
