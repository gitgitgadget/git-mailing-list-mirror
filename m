From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 21:52:38 +0200
Message-ID: <bd6139dc0807281252y650b9347md1d4ac788151d19f@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:53:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYmq-0000z2-RT
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYG1Twk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 15:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYG1Twk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:52:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:16864 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbYG1Twj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 15:52:39 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5933965wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MHQw+DcdZzyY8KAaSKgiVGVNA/li92lcf6sYQ3NusEw=;
        b=mVf8D6+EDrxW4/pn7+GDg4WkPGsreauWBLQLGoi0sAWhwW1sAQPL+QQ+a69l6/UlSp
         hk52WoPiBDE7UCpc/Nr4ezgcu/ubSwZDQS4yPuPlefKYroH2tu8Z0pP64sAo5N6eJH7I
         1KEMjJvXAwbk9Gasc9SmrXGyrdHfQ6fkvsHog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=cm5Gm6MpE6YpnW0dkh0u/kKuLxk/4EXzQ9QWQs8LdfcmwB87k54I+fLtwUQmTN6MUV
         Ev2fQvvw0bQdLHBBk7Mjd7VH+RpLPOgaMogB94KKxYkIJUkPETi4Sc93Q1sK/hrmvVr3
         aiVi9OxfTA7S6/bfYdBVJWRUPCECy1Q+ajCeM=
Received: by 10.142.232.20 with SMTP id e20mr1743201wfh.85.1217274758840;
        Mon, 28 Jul 2008 12:52:38 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 12:52:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807282008470.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90494>

On Mon, Jul 28, 2008 at 21:09, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Well, I have to say that the workflow is a bit backwards if the person who
> _publishes_ the thing is the one saying "Ooops, my version no goodie,
> other version please, but so that pull still works".

Why so? In this case the other branch was also owned by the publishing
person. I don't quite follow how this is any stranger than ours?
(Which is stranger to me, why would you want to merge in a branch if
you're not going to do anything with it anyway? I'm sure there are
valid workflows for it, which is why we have it, just saying that I
think 'theirs' makes more sense to me than 'ours')

> I would have expected the one who has the good version to make the choice.

Why have the person with the good version merge with... a bad version?
Isn't it usually "I will merge with you, because I know your branch
makes things go twice as fast" (paraphrasing Linus from his git talk
at google).

-- 
Cheers,

Sverre Rabbelier
