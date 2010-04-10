From: Eric Raymond <esr@thyrsus.com>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 10:41:49 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410144149.GA23959@thyrsus.com>
References: <20100410040959.GA11977@coredump.intra.peff.net>
 <1270885256-31589-1-git-send-email-gitster@pobox.com>
 <20100410074430.GA12567@coredump.intra.peff.net>
 <7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
 <20100410084007.GA16843@coredump.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Raymond <esr@snark.thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:42:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0bsw-0008N9-8a
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab0DJOlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:41:50 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:39167
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0DJOlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:41:50 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 85F0920CBBC; Sat, 10 Apr 2010 10:41:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100410084007.GA16843@coredump.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144550>

Jeff King <peff@peff.net>:
> On Sat, Apr 10, 2010 at 12:48:49AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > +	dir.flags |= DIR_COLLECT_IGNORED;
> > 
> > I thought about using collect-ignored so that fill_directory() does not
> > have to be run twice, but IIRC it can short-circuit an entire directory
> > using the "simplify" logic (as it was designed to be used for "git add"),
> > no?
> 
> Hmm.  I didn't consider that. It may be sufficient to say "foo/ is
> ignored" and let callers decide for themselves that "foo/bar" is
> ignored, too (unless, of course, it appears as tracked earlier in the
> list).

Speaking as  a front-end author, I would prefer that all ignored paths 
be listed so I don't have to do globbing.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
