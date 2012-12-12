From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 07:26:25 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121212122625.GB25981@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <20121212063208.GA18322@sigill.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 13:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TilOf-0002mV-17
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 13:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab2LLM02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 07:26:28 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34911
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2LLM02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 07:26:28 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 9D5024408D; Wed, 12 Dec 2012 07:26:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121212063208.GA18322@sigill.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211349>

Jeff King <peff@peff.net>:
> I think there are really two separate use cases to consider:
> 
>   1. Providing snippets of script to Git to get Turing-complete behavior
>      for existing Git features. For example, selecting commits during a
>      traversal (e.g., a better "log --grep"), formatting output (e.g., a
>      better "log --format" or "for-each-ref --format").
> 
>   2. Writing whole new git commands in a language that is quicker or
>      easier to develop in than C.

That's good analysis.  I agree with your use-case split, I guess I'm just not
very aware of the places in git where (1) is important.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
