From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
Subject: Re: How can I download a git commit as a diff patch?
Date: Wed, 30 Sep 2009 21:38:09 +0200
Message-ID: <20090930213809.71c2a8e8@varda>
References: <20090930154410.GA31502@thumper2>
	<20090930085500.a5856301.rdunlap@xenotime.net>
	<20090930190014.GA22161@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andy <genanr@emsphone.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755161AbZI3TiN@vger.kernel.org Wed Sep 30 21:38:32 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755161AbZI3TiN@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt50R-0005nk-HU
	for glk-linux-kernel-3@lo.gmane.org; Wed, 30 Sep 2009 21:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbZI3TiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 30 Sep 2009 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbZI3TiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Sep 2009 15:38:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:24124 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbZI3TiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Sep 2009 15:38:11 -0400
Received: by ey-out-2122.google.com with SMTP id 4so555670eyf.19
        for <multiple recipients>; Wed, 30 Sep 2009 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=n08zAXlA82TkdouQVgHHTLhRJoSGjr7gIn98JbAWGDY=;
        b=CUtr3U6VZEi1DA+cGZEmta4rpQrZURu4t0MC+/uhM44swwEGTJYVyiVe7f2N8/IDfm
         ZEM4GpFQMcQL+6dHaIumr4VZ9Rv1kDH72pPGPd+ouWKUye/lKz9Pqw0Z1FNauaWkfYFR
         CJcCd4tTrlJEs2TxInY7znCG+r0JjztQ0ZfyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=GlNrj9+p8Agnf7Q4xqWGDDnZORCjuPta8yVRwYSuH0SRWYwKEr4QicqejWYjESjTvY
         any+1OzHjYzvfSlZnNZLHwk7k3wk0GKTUcvfIMV4R4PizhW9Q9JzJeFVR+7jeor+tWT6
         tLcPgwoHkIgH0O/ixufgRiM9S2H4aVdq1nZsY=
Received: by 10.211.146.18 with SMTP id y18mr5948714ebn.55.1254339494878;
        Wed, 30 Sep 2009 12:38:14 -0700 (PDT)
Received: from varda (180.Red-83-38-72.dynamicIP.rima-tde.net [83.38.72.180])
        by mx.google.com with ESMTPS id 7sm28063eyg.41.2009.09.30.12.38.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 12:38:13 -0700 (PDT)
In-Reply-To: <20090930190014.GA22161@csclub.uwaterloo.ca>
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.16.1; x86_64-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129351>

El Wed, 30 Sep 2009 15:00:14 -0400

 CCing git@vger.kernel.org ??

lsorense@csclub.uwaterloo.ca (Lennart Sorensen) escribi=C3=B3:

> On Wed, Sep 30, 2009 at 08:55:00AM -0700, Randy Dunlap wrote:
> > On Wed, 30 Sep 2009 10:44:10 -0500 Andy wrote:
> >=20
> > > I just want to down a particular git commit as a patch, not a git=
 commit or
> > > anything.  Yes, I can see the diffs on the web, but unless I am m=
issing
> > > something all are in unless html formats for me.  And cut and pas=
t from the
> > > web page does not help either because some lines get mangled.  Is=
 there some
> > > site, or git itself, that would allow be to get the git commit as=
 a simple
> > > patch?
> >=20
> > Look at the commitdiff using the web interface, then click on "raw"=
 near
> > the upper left corner.
>=20
> Of course some git diff's are not in a format that patch will like as
> far as I can tell.
>=20
> For example commit 6cdee2f96a97f6da26bd3759c3f8823332fbb438 which has
> stuff like:
> diff --cc drivers/net/ixp2000/ixpdev.c
> index 588b44d,92fb823..1272434
> --- a/drivers/net/ixp2000/ixpdev.c
> +++ b/drivers/net/ixp2000/ixpdev.c
> @@@ -67,9 -68,9 +68,9 @@@ static int ixpdev_xmit(struct sk_buff *
>         ip->tx_queue_entries++;
>         if (ip->tx_queue_entries =3D=3D TX_BUF_COUNT_PER_CHAN)
>                 netif_stop_queue(dev);
> -       local_irq_enable();
> +       local_irq_restore(flags);
>=20
>  -      return 0;
>  +      return NETDEV_TX_OK;
>   }
>=20
>=20
>=20
> Ehm, what does that mean?  patch doesn't like it.
>=20
> Do git merges cause weird diffs?
>=20
