From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default semantics
Date: Tue, 19 Feb 2008 19:03:23 -0600
Message-ID: <5d46db230802191703v1e273284k71817fcd8a2639a1@mail.gmail.com>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
	 <20080219043353.GA23239@sigill.intra.peff.net>
	 <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com>
	 <20080219150826.GA24499@sigill.intra.peff.net>
	 <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com>
	 <20080219152549.GC24499@sigill.intra.peff.net>
	 <alpine.LSU.1.00.0802191610480.30505@racer.site>
	 <20080219163743.GA31668@sigill.intra.peff.net>
	 <alpine.LSU.1.00.0802191651550.30505@racer.site>
	 <20080219170507.GA1144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdNV-0007e6-A6
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbYBTBD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763985AbYBTBD0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:03:26 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:53225 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763682AbYBTBDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:03:25 -0500
Received: by el-out-1112.google.com with SMTP id v27so1171055ele.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 17:03:24 -0800 (PST)
Received: by 10.142.194.1 with SMTP id r1mr5930901wff.197.1203469403451;
        Tue, 19 Feb 2008 17:03:23 -0800 (PST)
Received: by 10.150.156.18 with HTTP; Tue, 19 Feb 2008 17:03:23 -0800 (PST)
In-Reply-To: <20080219170507.GA1144@sigill.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 5ec8bd7f820e8c29
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74490>

On 2/19/08, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 19, 2008 at 04:54:14PM +0000, Johannes Schindelin wrote:
>
> > > Just say "git push origin HEAD"?
> >
> > The point is: if that becomes the default (with a certain config option),
> > people will get used to typing "git push".  They will not even _know_
> > about the explicit form.
>
> I guess I hoped that people giving answers on the IRC channel would be a
> little less clueless. Perhaps that is just optimism.
>
> > See followup.
>
> I'm actually starting to like your patch now...;)
>
> > BTW if that is really the way to go, we will have to have a _long_ period
> > (I am talking about 6-12 _months_ if not more) where there _must not_ be a
> > default action for git-push.  Otherwise people _will_ get more confused
> > than necessary.
>
> I agree that it would need a long deprecation period to change behavior.
> It would almost be easier to have a "git <foo>" command where <foo> is
> some sort of restricted, safe-for-certain-workflows version of push.
>

For those interested, this is how I plan to have the default for
pyrite.  The default currently just calls "git push origin HEAD"
Calling with another target repository and refspec would still be
supported of course.

In general, the plan it to take the most common work flows and simply
the UI around those.  This includes silently doing "git add -u" before
pushing a commit and "pyt diff" will diff between the working
directory and HEAD because I have never been interested in the state
of the index, only in the state of the working dir.

-Govind
