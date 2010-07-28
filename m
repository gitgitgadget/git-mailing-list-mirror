From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 13:38:34 +1000
Message-ID: <AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
	<AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 05:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdxTc-0001Eg-G5
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 05:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab0G1Dig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 23:38:36 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51185 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab0G1Dif convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 23:38:35 -0400
Received: by vws3 with SMTP id 3so4020932vws.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KL/eN0Q4LMssx/FvOKDhwEUmfyQfSEk91isqu35PpVw=;
        b=tc/WVcDnQ7bcVx0o/rGbL9+6o1cze8yhAoVsNQ8jEq+EVPwBJVfuGSp+pYqQJgmFqM
         pRcLb8kOTMWMfdZiKLaQbgIasixWZKtRxsCVBurcwBGpt8a+DldApO6V1JVpJx29PzpL
         e0hxANyzGfliSpOnQdnjDrE1JimBIfPdUOrSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qjsdIP94WFWasx5JievZ3lvZpPE1QUoX9bRnRhi4vhT50pGvml+4rJ0PMBh3+o51Qf
         UxnrQXWtEVjTbN6SsIZVRWGYjIVB5vUK+bhJcUdMD59lZYTRutmITR1LNz1QRwMoHhOC
         serSA93CNbM7YrGVPaQtyV9lmezc55SiLB1To=
Received: by 10.220.96.4 with SMTP id f4mr5814895vcn.267.1280288314424; Tue, 
	27 Jul 2010 20:38:34 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Tue, 27 Jul 2010 20:38:34 -0700 (PDT)
In-Reply-To: <AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152034>

(corrected reply context, sorry)

On Wed, Jul 28, 2010 at 1:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> 2010/7/28 Avery Pennarun <apenwarr@gmail.com>:
>> 2010/7/27 Elijah Newren <newren@gmail.com>:
>>> 0) Sparse clones have "all" commit objects, but not all trees/blobs=
=2E
>>>
>>> Note that "all" only means all that are reachable from the refs bei=
ng
>>> downloaded, of course. =C2=A0I think this is widely agreed upon and=
 has
>>> been suggested many times on this list.
>>
>> I think downloading all commit objects would require very low
>> bandwidth and storage space, so it should be harmless.
> >
> > In fact, I have a pretty strong impression that also downloading
> > all *tree* objects would be fine too.
>
> Here you go. A pack with only commits and trees of git.git#master is
> 15M. With blobs, it is 28M. Git is not a typical repo with large blob=
s
> though.
> --
> Duy
>



--=20
Duy
