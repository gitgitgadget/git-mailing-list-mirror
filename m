From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Mon, 7 Jan 2013 15:41:33 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130107204132.GA23867@thyrsus.com>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
 <20121228230149.GA3575@book-mint>
 <20121229044200.GA16086@thyrsus.com>
 <20130106163420.GA3378@book-mint>
 <7vehhwiyt6.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 21:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsJWC-0006St-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 21:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab3AGUll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 15:41:41 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:44451
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab3AGUlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 15:41:40 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 4FCD64047B; Mon,  7 Jan 2013 15:41:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vehhwiyt6.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212918>

Junio C Hamano <gitster@pobox.com>:
> In the longer term, if parsecvs is revived either by Eric or
> somebody else, we will add the mention back to the documentation,
> probably with an updated URL.

I'm working on the revival right now. Repository generation is still
broken, and likely to remain so until I can make the export-stream stage
work, but just a few minutes ago I coaxed it into generating what looks 
like graphviz markup describing a commit graph on standard output.

Even though dot(1) barfs on the markup, this is encouraging. It almost
certainly means that the analysis and parsing stages aren't broken, and
by stubbing out enough functions I can figure out what is being passed
to the broken repository-maker well enough for my purposes.

Actually, I've already figured out how to generate blob and commit-header
markup.  The hard part is generating fileops; I don't quite understand
the generated data structures well enough to do that yet.  But I'm
making progress, and feeling more optimistic than I was yesterday.

In related news, I've sent Michael Haggerty patches that fix the visible
problems with cvs2git that I enumerated in previous mail.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
