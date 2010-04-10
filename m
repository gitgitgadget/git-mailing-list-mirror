From: Eric Raymond <esr@thyrsus.com>
Subject: Re: [RFC/PATCH] status: Add a new NUL separated output format
Date: Sat, 10 Apr 2010 17:12:23 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410211223.GA29067@thyrsus.com>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
 <20100410192529.23731.79803.julian@quantumfyre.co.uk>
 <20100410195003.GA28871@thyrsus.com>
 <1702f7c7b0e0689149702335c9efad3f@212.159.54.234>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 10 23:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0hyf-0006kR-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 23:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0DJVMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 17:12:24 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:47459
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab0DJVMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 17:12:24 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 486D220CBBC; Sat, 10 Apr 2010 17:12:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1702f7c7b0e0689149702335c9efad3f@212.159.54.234>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144594>

Julian Phillips <julian@quantumfyre.co.uk>:
> I didn't use "-" instead of " " as that seemed out of scope for a output
> formatting option.  Though I don't personally have an objection to it, I
> also don't see a particularly strong need for it as with the -Z format
> there is no ambiguity.

Good point.  OK, the combinaation of -Z and a switch to list ignored
files should solve Emacs VC's problem.  

Having some sort of JSON dump might still not be a bad idea.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
