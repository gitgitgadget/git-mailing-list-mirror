From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2] Add configuration variable for sign-off to
	format-patch
Date: Mon, 6 Apr 2009 20:09:25 +0200
Message-ID: <20090406180925.GA466@macbook.lan>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net> <20090331204338.GA88381@macbook.lan> <20090401102610.GC26181@coredump.intra.peff.net> <20090401175153.GA90421@macbook.lan> <7veiw69p26.fsf@gitster.siamese.dyndns.org> <49D9E040.40007@op5.se> <vpqvdpi5807.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <exon@op5.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 06 20:13:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqtJU-0000Kq-P0
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 20:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZDFSJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZDFSJa
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 14:09:30 -0400
Received: from darksea.de ([83.133.111.250]:37643 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbZDFSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 14:09:29 -0400
Received: (qmail 6288 invoked from network); 6 Apr 2009 20:09:13 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Apr 2009 20:09:13 +0200
Content-Disposition: inline
In-Reply-To: <vpqvdpi5807.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115862>

On Mon, Apr 06, 2009 at 01:36:24PM +0200, Matthieu Moy wrote:
> Andreas Ericsson <exon@op5.com> writes:
> 
> > How about:
> > "Some projects (notably the Linux kernel and git itself) put special
> > meaning in a 'Signed-off-by' line while other's dont. Please refer
> > to your project's documentation for appropriate behaviour."
> >
> > Optionally with the following amendment:
> >
> > "In general, you should refrain from signing off on a patch containing
> > material that you're not sure can be legally spread under the project's
> > license."
> 
> To me, this is at least an improvement over refering to
> SubmittingPatches (which is targeted to Git contributors) in the
> documentation (targeted to Git users), yes.

To me too. When writing I was probably too focused on Git.

> Not sure whether these two sentences should come in the documentation
> for the config option or the command-line switch.

I think you should be able to get to this note from all locations where
this option is provided (+ the commit option) so maybe a link ?

cheers Heiko
