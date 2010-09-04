From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 10:57:24 +1000
Message-ID: <AANLkTimCca8PJQSQks4fvktVL7mE8gtFXpJKvCz9A+Wh@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, "Ted Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 02:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orh4U-000117-VM
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 02:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab0IDA50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 20:57:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42776 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab0IDA5Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 20:57:25 -0400
Received: by gwj17 with SMTP id 17so968257gwj.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VW/0WBxhcwI8tEE04LBaTM+/Pjq5mZnC4bYvFo6s1Rc=;
        b=rZdmX0pkbt3Ou2NcfPtUn0jTJcW3tXSHdR7C137tZ5GwkQygS5UqEUMPKS+QsTVkck
         0L+zx5L0+3d+5nuXzVh4xPrJsAVtMfHgjq6Abp2tEtESQ69KscmaW+jyqXVRxYCxJbf2
         ZLU8qxi6tuD5XdQpr9w7KFFPUIKbFKwuEr+SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b8QeBEbcLxme4pVp4EYOCG2n22kj32Gkz5rTz25usu/WW/0mM7Cq5IsSGwMO/PS+nh
         gRDMWaWpLgoCKnSyASn+uuzzGLJoqzQfbKgmfMFfiKH/uNa5IE9yUuRU9J/7r6MFM2qh
         hvTwbCPA6YABswSoOhokMfHkmd4v5/MBfBkiY=
Received: by 10.150.192.9 with SMTP id p9mr197524ybf.145.1283561844684; Fri,
 03 Sep 2010 17:57:24 -0700 (PDT)
Received: by 10.151.39.6 with HTTP; Fri, 3 Sep 2010 17:57:24 -0700 (PDT)
In-Reply-To: <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155295>

On Sat, Sep 4, 2010 at 10:24 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Sat, Sep 4, 2010 at 7:11 AM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>> =C2=A0i'll take a look at that. =C2=A0but whilst i'm doing that, the=
 main
>> question i really need to know is: how do you get one single explici=
t
>> object out of git?
>
> git cat-file <type> <sha-1>
>
> However if you are going to send objects, one by one, it is extremely
> inefficient. I think Nico has pointed that out. Individual object
> sending should only be done for large blobs.

On second thought, I don't know, maybe it could work if this sort of
individual object sending is based on bup. Bup splits files into small
pieces. Common parts of files are likely shared, reducing the need to
delta. But then you would deal with a huge number of small blobs.
--=20
Duy
