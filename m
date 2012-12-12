From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 07:23:55 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121212122355.GA25981@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <50C811ED.4000600@workspacewhiz.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 13:24:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TilMH-0000eV-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 13:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2LLMYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 07:24:00 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34903
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab2LLMX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 07:23:59 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C60BD4408D; Wed, 12 Dec 2012 07:23:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50C811ED.4000600@workspacewhiz.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211347>

Joshua Jensen <jjensen@workspacewhiz.com>:
> Anyway, my preference is to allow scripts to run in-process within
> Git, because it is far, far faster on Windows.  I imagine it is
> faster than forking processes on non-Windows machines, too, but I
> have no statistics to back that up.
> 
> Python, Perl, or Ruby can be embedded, too, but Lua probably embeds
> the easiest and smallest out of those other 3 languages.
> 
> And shell scripts tend to be the slowest on Windows due to the
> excessive numbers of process invocations needed to get anything
> reasonable done.

I don't think there's *any* dimension along which lua is not clearly
better than shell for this sort of thing, so no argument there.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
