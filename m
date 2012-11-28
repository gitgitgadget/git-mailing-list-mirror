From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 22:47:00 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121128034700.GD1669@thyrsus.com>
References: <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <20121128032337.GB1669@thyrsus.com>
 <20121128033009.GA3931@sigill.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:47:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYcO-0000tB-It
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab2K1DrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:47:08 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59030
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab2K1DrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:47:07 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id ECF4F4065F; Tue, 27 Nov 2012 22:47:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121128033009.GA3931@sigill.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210694>

Jeff King <peff@peff.net>:
> A much more compelling argument to me would be that you are doing some
> bidirectional magic between git and svn, and you want to make make sure
> that an svn->git->svn translation will result in the exact same bytes.
> Then the argument is still "because SVN has it", but at least it is "and
> we interoperate with it" and not simply chasing a cool but useless
> feature.

Er, well, that *is* in fact the exact reason I want it.

I didn't put it exactly that way because I didn't expect anyone here
to particularly care about round-tripping like that.  But remember 
that I do a lot of stuff with repo surgery and conversion tools.

As a matter of fact (and this list is the first to hear about it) 
I'm working on code right now that massages a git import stream
into a Subversion dumpfile.  Soon, unless I hit a blocker I'm
not expecting, I'll ship it.

Yes, there will be serious limitations and unavoidable metadata loss.
But in every case *except timestamps* that loss is Subversion's fault
for having a weak ontology.  Timestamps are the one place git doesn't 
hold up its end.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
