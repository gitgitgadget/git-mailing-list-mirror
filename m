From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default semantics
Date: Tue, 19 Feb 2008 19:21:08 -0600
Message-ID: <5d46db230802191721p527c0a85k362c7b364c7e99c4@mail.gmail.com>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
	 <20080219150826.GA24499@sigill.intra.peff.net>
	 <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com>
	 <20080219152549.GC24499@sigill.intra.peff.net>
	 <alpine.LSU.1.00.0802191610480.30505@racer.site>
	 <20080219163743.GA31668@sigill.intra.peff.net>
	 <alpine.LSU.1.00.0802191651550.30505@racer.site>
	 <20080219170507.GA1144@sigill.intra.peff.net>
	 <5d46db230802191703v1e273284k71817fcd8a2639a1@mail.gmail.com>
	 <7vr6f8e8lx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdec-0003gf-Cy
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbYBTBVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYBTBVL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:21:11 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:21756 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbYBTBVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:21:10 -0500
Received: by wf-out-1314.google.com with SMTP id 28so562269wff.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 17:21:08 -0800 (PST)
Received: by 10.142.84.3 with SMTP id h3mr5981096wfb.34.1203470468140;
        Tue, 19 Feb 2008 17:21:08 -0800 (PST)
Received: by 10.150.156.18 with HTTP; Tue, 19 Feb 2008 17:21:08 -0800 (PST)
In-Reply-To: <7vr6f8e8lx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 0abe4a616ff4952b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74496>

On 2/19/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>
> > For those interested, this is how I plan to have the default for
> > pyrite.  The default currently just calls "git push origin HEAD"
> > Calling with another target repository and refspec would still be
> > supported of course.
> >
> > In general, the plan it to take the most common work flows and simply
> > the UI around those.  This includes silently doing "git add -u" before
> > pushing a commit and "pyt diff" will diff between the working
> > directory and HEAD because I have never been interested in the state
> > of the index, only in the state of the working dir.
>
> For both counts, it feels so much like Cogito.
>
> I would not comment on "the most common" adjective, but I am
> still a big believer of "core git gives common foundation for
> Porcelains that support different workflows to talk with each
> other" ideal, and I really like that you are building a
> Porcelain that would suit your favorite workflow.
>
>
Once I have it in better shape, I hope to get commentary from the rest of the
git users on how their workflows go and see where I can simplify things or
where they need to be more complex.  I don't want it to _just_ be for my
workflow.  I want something that appeals to the common user (if there is such
a thing, and with git, I don't know that you can say that).

-Govind
