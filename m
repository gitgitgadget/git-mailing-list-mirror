From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 22:32:46 +0000
Message-ID: <CAMOZ1BtPzzaFDpYkjyM2WhKQbi0e863Bc3kBYEDgj1W9-xG+0A@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org> <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
 <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com> <CAMOZ1Bspiz-J4Z7d8t7+jA_rKmzKcjhxuUpUSv7BrjJ=kCBfBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:33:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9PAQ-0003Fa-7d
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab1I2WdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 18:33:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49626 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab1I2WdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 18:33:17 -0400
Received: by iaqq3 with SMTP id q3so1154535iaq.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nBWYGM1PQPSKLxlNI7utmDEzwlMqkcWjXDXHw1gp0iQ=;
        b=a1UwVlOrZmyUqjXnn9QH1ZoyuDUOvLYox+6A9CySjKPpM9dWJS88bgcR0JTYVPn/Uc
         nCGgnJT1Ra4wuKySbAcqfguVYxurxAXkNG5YJg2Zom2UpPRt2jiW1iT1otCzYBTsYivT
         8I11JocRCyWBo9IQAhxpwAEpQvkWUPqn0EpEU=
Received: by 10.42.134.4 with SMTP id j4mr1614735ict.135.1317335596964; Thu,
 29 Sep 2011 15:33:16 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 15:32:46 -0700 (PDT)
In-Reply-To: <CAMOZ1Bspiz-J4Z7d8t7+jA_rKmzKcjhxuUpUSv7BrjJ=kCBfBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182453>

On Thu, Sep 29, 2011 at 22:29, Michael Witten <mfwitten@gmail.com> wrote:

> Consider trying the "Hidden History" scenario with the current
> approach, which only allows for "git checkout --orphan":
>
>  $ cd repo
>  $ git checkout --orphan separate-history
>  $ # Hack away as usual or not
>  $ git status # lots of "new file" notifications obscuring my changes
>  $ git commit

To avoid confusion, please note that the line:

  $ git checkout --orphan separate-history

was meant to read:

  $ git checkout --orphan hidden-history
