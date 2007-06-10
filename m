From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 14:51:59 +0200
Message-ID: <8c5c35580706100551y52639ce3m7a2be93a3289be1c@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070610002802.GD31707@planck.djpig.de>
	 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
	 <20070610124052.GE955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jun 10 14:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMto-00041s-Bf
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbXFJMwB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbXFJMwB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:52:01 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:56420 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbXFJMwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:52:00 -0400
Received: by py-out-1112.google.com with SMTP id a29so2133070pyi
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 05:52:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mu/5FQNxS1H1o2fKOyfCTRWawlQTAApgjmmANX0BlOgt6R4jw9cm65+SCTAHYuYISeN5qRYlT/+po1sO5yYWnzU6K8s/XSHYtQGQYtHas/EP0VHaoLvhsvcZ35IrHABSINQKOpUJVfwVD24yL5l5jD7RGtq35B/l21sfXw2UcSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A+nfKQ4oU6a0QYLVXiPAuPFjX3xlCw3S3D6Z4jJIiaIaNexPpSa+5bOmwDL0uJcYWxe6t4kucDms6aqfDsPBqwzcAAqAGRC+e52xcDi9eItkgXQ4zAEtDr+ApD2t1w5iQy3jiEmHnUb1KZ2pC5KIza1QOER6P8vjh8Zj0A7H2bg=
Received: by 10.114.160.1 with SMTP id i1mr4501663wae.1181479919692;
        Sun, 10 Jun 2007 05:51:59 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 05:51:59 -0700 (PDT)
In-Reply-To: <20070610124052.GE955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49724>

On 6/10/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sun, Jun 10, 2007 at 02:30:58PM +0200, Lars Hjemli wrote:
> > On 6/10/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > >On Sun, Jun 10, 2007 at 10:58:29AM +0200, Lars Hjemli wrote:
> > >> >For .path a "Defaults to name of submodule" probably wouldn't hurt.
> > >>
> > >> True. But there might be some issues with this rule, so I'll leave it
> > >> as is for now.
> > >
> > >And what might those issues be?
> >
> > There's been some discussion about allowing a default value for path, see
> >  http://comments.gmane.org/gmane.comp.version-control.git/49620
>
> Euhm... this just points back to this thread...

I know ;-)

> or are you referring to Junio's misinterpretation of the patch 1/3
> commit message?

Well, yes, I _think_ it's a misinterpretation but there is always the
possibility of me being exceptionally slow and not getting his point.

>
> > >It doesn't have the extensions proposed by Linus, but it seems
> > >to be forward compatible with them.
> >
> > I'm trying to take baby-steps with the submodule support, so the
> > module/submodule extension Linus talked about would possibly come at a
> > later stage.
> >
> > Hmm, maybe I should just rename [module] to [submodule] right now?
>
> I don't see the need, but if you _really_ can't resist then please do it
> sooner rather than later.

Ok

--
larsh
