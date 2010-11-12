From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix
 for long forms of -M and -C.
Date: Fri, 12 Nov 2010 08:43:12 +0100
Message-ID: <20101112074312.GG8911@home.lan>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <1289420833-20602-2-git-send-email-ydirson@altern.org>
 <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Nov 12 08:43:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGoI9-0003ff-QA
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 08:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab0KLHnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 02:43:20 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:60860 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab0KLHnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 02:43:20 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A14C1D4800D;
	Fri, 12 Nov 2010 08:43:13 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGoHw-00016Y-Bs; Fri, 12 Nov 2010 08:43:12 +0100
Content-Disposition: inline
In-Reply-To: <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161327>

On Thu, Nov 11, 2010 at 07:00:05PM -0800, Kevin Ballard wrote:
> On Nov 10, 2010, at 12:27 PM, Yann Dirson wrote:
> 
> > -M[<n>]::
> > ---detect-renames[=<n>]::
> > +--find-renames[=<n>]::
> > ifndef::git-log[]
> > 	Detect renames.
> > endif::git-log[]
> > @@ -246,7 +246,7 @@ endif::git-log[]
> > 	hasn't changed.
> > 
> > -C[<n>]::
> > ---detect-copies[=<n>]::
> > +--find-copies[=<n>]::
> > 	Detect copies as well as renames.  See also `--find-copies-harder`.
> > 	If `n` is specified, it has the same meaning as for `-M<n>`.
> 
> I'm not sure I like the wording --find-copies and --find-renames. Maybe I'm
> just being silly, but it sounds like those are directives, saying "I want you
> to find copies/renames", as opposed to just saying "while you're working you
> should also detect copies/renames". The original flag --find-copies-harder
> is a bit different, because it's modifying the action of finding copies
> rather than making finding copies the prime directive.

Well, I don't see how --find-copies-harder is much different: it is
just a more powerful version of -C, as seen by the fact that it implies -C.


> On the other hand, --detect-copies and --detect-renames sounds to me like
> you're just telling it that it should, well, detect copies/renames as it goes
> about its business.

I can understand this.  However, I feel that the fact they are just
options, as opposed to the explicit "diff/show/whatever" commands that
take them as modifiers, would be enough to balance the nuance in the
words.  That may just be a matter of taste, but the consistency with
--find-copies-harder may be important here.

-- 
Yann
