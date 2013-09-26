From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Remove ciabot from contrib
Date: Thu, 26 Sep 2013 17:13:04 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130926211304.GA19056@thyrsus.com>
References: <1380227582-7836-1-git-send-email-stefanbeller@googlemail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 23:23:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPJ1s-00019d-4O
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 23:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab3IZVXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 17:23:16 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54502
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab3IZVXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 17:23:16 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2013 17:23:15 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 2EEFB40171; Thu, 26 Sep 2013 17:13:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1380227582-7836-1-git-send-email-stefanbeller@googlemail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235437>

Stefan Beller <stefanbeller@googlemail.com>:
> According to
> http://thread.gmane.org/gmane.comp.version-control.git/212649
> Eric, the original author of ciabot, doesn't want the ciabot
> no longer be included in git.git, hence the removal of the
> whole directory.

Note: I was *not* the original author of the ciabot scripts.  I was
their maintainer (baton passed to me by the original authors) when
the CIA service irrecoverably crashed, and did suggest they be
removed.  (It is however true that I had rewritten the scripts
pretty heavily, enough so to perhaps be considered a coauthor.)

Junio demurred based on some representations that a development team
not including the CIA author had plans to revive the CIA service.  I said
"Wait and see, then" - having the ciabot stuff carried in git was
doing me no harm, I was just doing what I thought was my duty by
suggesting the cleanup.

That was almost exactly a year ago now.  The CIA revival effort has since 
sunk without trace.  In part, this is because I fielded a much simpler 
and properly decentralized replacement called "irker" which is now 
widely enough deployed to have suppressed the demand for CIA.  Repository
hook scripts for irker ship with the irker distribution.

I think enough time has passed that removal would be appropriate.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
