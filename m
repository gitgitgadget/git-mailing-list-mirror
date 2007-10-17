From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Wed, 17 Oct 2007 09:14:45 +0200
Message-ID: <e5bfff550710170014m395d5b8cld87a5c2c9f7d71a@mail.gmail.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
	 <20070709173720.GS29994@genesis.frugalware.org>
	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
	 <4713FA4A.5090501@bluelane.com>
	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
	 <471433F3.40606@bluelane.com>
	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
	 <471454B5.7040802@bluelane.com>
	 <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
	 <47159BF9.9040400@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Wed Oct 17 09:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii37K-0005WZ-01
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbXJQHOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbXJQHOr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:14:47 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:50987 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbXJQHOq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:14:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1664560rvb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AS0QWc2a35Jr2zrxvFfRWv2cTCf8Lyvd/C1DEK03Y+Y=;
        b=d4rjl5bsxOQdnrnTPwna/Y1xKz6h3IcK7OTTdyrE5vlWoybO+n8LfaVZqOngrRob062dImZlxZj5fIMmNBMN4hMr7xeO+PHP+UwdbL4zXbxlU1H1lvpTXrHZ4vtZoa6kXfQTiWJHl/Bqsfwa1KfvQK/8Ora025K3YMbpIXSlyn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OqsMTqd2yJVylyyUVJnfRACi1WDQi8TG2rNcAT8f658dQM6d/PI8cXJObU/BkLSQflb+eUvJQ3KBdXuvliyQLNonBNJ6zEIQQ3BoNXAGfink9ZYmTZWbrOd5RtHmXdvvAMIx+s94VhM3MFfufs3L5+ouLY06bT5KnCckyofJfkw=
Received: by 10.140.144.4 with SMTP id r4mr3997010rvd.1192605285600;
        Wed, 17 Oct 2007 00:14:45 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Wed, 17 Oct 2007 00:14:45 -0700 (PDT)
In-Reply-To: <47159BF9.9040400@bluelane.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61342>

On 10/17/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>
> 't' worked fine but still can see how to diff do of the list of
> changes for a file. Viewing diffs of files based on change sets
> worked fine but I think with BitKeeper I found it helpful to be
> able to do a full 'kompare' type diff the file only; often I'm
> not interested in which change set it went into.
>

Well, open tree view ('t'), select the file you are interested of,
then click the magic wand button on the tool bar, now revisions you
see are filtered by that file, if you browse the revisions the
patch/diff you see will always point to your file (also if you can see
the whole patch).

> Something for a future version or am I lucky and you have
> it covered already?
>

Don't know, depends on how you answer to the above point ;-)

>
> Good Idea, thought it's brought up a few questions:
>
>         1. When I do the <control-minis> to Decrease the font size
>            I can't undo it with the <control-plus>. Also <control-plus>
>            doesn't seem to do anything.
>
>         2. When displaying the "Lane info" why can't I see the
>            branch names?
>

Thanks for the reports, I will investigate as soon as I have a bit of
spare time.

>
> I'll read it a few more times. I seem to sometimes get into a state
> where I'm locked onto the current change set and can't get back to
> the other change sets without starting another qgit.
>

Please, could you be so kind to better explain me the above point.
Seems interesting, but I didn't get how to reproduce.


> >
> > Yes it is. There are a lot of new featrures, is almost as stable as
> > the previous and if you are interested in file history (annotations)
> > in qgit-2.0 this feature has been greatly speeded up.
>
> Do you know if it's a lot of work to install Qt4?
>

With Mandriva you are just at an uprmi away.

Try something like

urpmi libqt4-devel

It worked for me ;-)

Marco
