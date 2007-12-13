From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] clone: support cloning full bundles
Date: Thu, 13 Dec 2007 10:37:34 +0100
Message-ID: <8aa486160712130137l29409395va2b62f5d559ca54e@mail.gmail.com>
References: <1197456485-22909-1-git-send-email-sbejar@gmail.com>
	 <Pine.LNX.4.64.0712121449310.27959@racer.site>
	 <8aa486160712120721k26158972qf11c889da98572c6@mail.gmail.com>
	 <Pine.LNX.4.64.0712121846070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 10:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2kVz-0006gT-5l
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603AbXLMJhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbXLMJhh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:37:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:28665 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbXLMJhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:37:35 -0500
Received: by wr-out-0506.google.com with SMTP id c49so291076wra.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7kdw75sx+UhGpZl8C6z+hHemJOmYvGMA9ltyYyS+I5k=;
        b=BOsaw5ZBOCRKfW7tH8v1/60Va7xCFpe8NO2FwEu601+BcQkvrpq4iyqq5YgDsOewSAgYAX73jMX9iTC1uMKQLoy+AY5lKmYzD7oilP4TP+eUjxPzMqOLAYg7pGdOcq7vu9d1xlPSoLPnJogvQGAe6H0dpZ5PB3kC2MoI0ZotQow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=llVkpZJ9LDOhMqQUAW9CoyFd34y3yLq8hzhZuTukJNhijoAmQE6tVO3XTleaaHGkYo9j7hRDjuUXivk/nJafMVNNvS6Zqx9zkdmBUvTwv1vOR67xCV7hUtzL1XH4xzyqOAto2LY5v4xPVRzD9kIWYyRhgCWYSOh/YIIb+8LLhUo=
Received: by 10.150.201.13 with SMTP id y13mr577046ybf.31.1197538654741;
        Thu, 13 Dec 2007 01:37:34 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Thu, 13 Dec 2007 01:37:34 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712121846070.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68137>

On Dec 12, 2007 7:46 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 12 Dec 2007, Santi B?jar wrote:
>
> > On Dec 12, 2007 3:50 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Wed, 12 Dec 2007, Santi B?jar wrote:
> > >
> > > > It still fails for incremental bundles.
> > >
> > > Of course it does.  The whole point of incremental bundles is that
> > > they do _not_ contain all objects, but rely on some objects being
> > > present on the "fetch" side.
> >
> > I know this. But then there is no bundle equivalent of the shallow
> > clones, as with:
> >
> > git clone --depth <depth> <repo>
>
> Ah, thanks.  Completely forgot about this.

But you were right, I confused incremental and shadow. So the next step would be

git bundle create --depth <depth> ...

I'll see what I can do.

Thanks
