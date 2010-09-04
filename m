From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 10:24:24 +1000
Message-ID: <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, "Ted Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 02:24:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrgYm-00070z-RC
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 02:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab0IDAY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 20:24:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46712 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0IDAYZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 20:24:25 -0400
Received: by wyf22 with SMTP id 22so491631wyf.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pNs3tSiMGVNMRqCb9BCHnFU97hAcZaiwfcRjrfMZ6fE=;
        b=dXEiC7D7/g6wCspVFWL5u0yyA2JqhtmX2whxw6zJPcQ/iXtjJ5hq6VNdn/g1kw6b0Y
         iIeoSP3egsTQGiray/+gm62TrKy/O4mQy2N7X3B4Hbvy1xUjmdaZBJfoHUu2JAfe65vE
         a26E70hzEmMxyA+NNXgEBQe4CHJOclEE0iVCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f4khzccS5guz9QS3pol1EnUU/2k8hD9i9ZXxLYZXpBXxeYiTu/vys6qiyvaPM7TWcm
         OSGhdrxjBDq/R6KgdEEj2GWCR/N4SUWfx3M4J6lkszDrc61ajHr0CkeI4zwGWkmNoUZu
         vTI/cvcp+N05st9hxmlJJb8vNGW22MejEIV2M=
Received: by 10.216.180.200 with SMTP id j50mr570243wem.36.1283559864694; Fri,
 03 Sep 2010 17:24:24 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Fri, 3 Sep 2010 17:24:24 -0700 (PDT)
In-Reply-To: <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155291>

On Sat, Sep 4, 2010 at 7:11 AM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> =C2=A0i'll take a look at that. =C2=A0but whilst i'm doing that, the =
main
> question i really need to know is: how do you get one single explicit
> object out of git?

git cat-file <type> <sha-1>

However if you are going to send objects, one by one, it is extremely
inefficient. I think Nico has pointed that out. Individual object
sending should only be done for large blobs.
--=20
Duy
