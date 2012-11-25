From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:32:29 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125173229.GA32394@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <20121125095356.GA22279@thyrsus.com>
 <CAMP44s1oRpm4QkhcbfAuxK8UTZnuSVfNhAQnmUd1xiwhwLEqGw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 18:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcg5J-0005OY-Qh
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 18:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab2KYRdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 12:33:22 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43209
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2KYRdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 12:33:21 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 52DD74065F; Sun, 25 Nov 2012 12:32:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1oRpm4QkhcbfAuxK8UTZnuSVfNhAQnmUd1xiwhwLEqGw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210376>

Felipe Contreras <felipe.contreras@gmail.com>:
> Seems sensible, but I don't know what "rejection" would actually mean.

Why is this mysterious?  We reject a patch when we don't choose to merge it.

> My "extensions" are on the way to the contrib area. Is the contrib
> area supposed to have different rules? I don't know.

I don't have a strong opinion about this.  I lean towards looser rules
for contrib because, among other things, it's a place for experiments
and we disclaim responsibility for maintaining it. But requiring 2.6
compatibility for Python scripts is not really onerous.

> Too late.

I'd be happy to help you out by auditing them for version dependencies.

> I don't see what this means in practical terms. People are going to
> write code in whatever language they want to write code in. How
> exactly are "we" going to "encourage" them not to do that is not
> entirely clear to me.

One way is by having clear guidelines for good practice that *include*
Python, and tell people exactly what the requirements are.

> Subcommands are also probably more efficient in c. And lets remember
> that most people use git through the *official* subcommands.

See my remarks on the 80-20 rule elsewhere in the thread.  Execessive
worship of "efficiency" is a great way to waste effort and pile up
hidden costs in maintainance problems.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
