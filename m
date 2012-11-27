From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 13:35:31 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121127183530.GB11845@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
 <20121127143510.GA15831@google.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 19:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdQ0h-000574-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 19:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab2K0Sfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 13:35:40 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56922
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab2K0Sfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 13:35:39 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 30C3940661; Tue, 27 Nov 2012 13:35:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121127143510.GA15831@google.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210583>

Magnus B=E4ck <baeck@google.com>:
> While "constant traffic" probably overstates the issue, these are not
> theoretical problems. I recall at least three cases in the last year
> or so where Git has seen breakage with Solaris or Mac OS X because
> of sed or tr incompatibilities, and I don't even read this list that
> thoroughly.

This is exactly the sort of of pain experience would lead me to
expect. =20

OK, this is where I assume the full Old Fart position (30-year
old-school Unix guy, author of "The Art of Unix Programming", can
remember the years before Perl and still has sh idioms in his
fingertips) and say "Get with the 21st century, people! Or at least
1990..."

As a general scripting language shell sucks *really badly* compared to
anything new-school. Performance, portability, you name it, it's a
mess.  It's not so much the shell interpreters itself that are the
portabilty problem, but (as Magnus implicitly points out) all those
userland dependencies on sed and tr and awk and even variants of
expr(!) that get dragged in the second you try to get any actual work
done.

Can we cease behaving like we're still pounding keys on 110-baud
teletypes now?  Some old-school Unix habits have persisted long past
the point that they're even remotely sane.  Shell programming at any
volume above a few lines of throwaway code is one of them - it's
*nuts* and we should *stop doing it*.

(Yes, I too still make this mistake occasionally out of ancient reflex.
But I know I shouldn't, and I always end up regretting it.)
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
