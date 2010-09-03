From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 11:34:21 +0100
Message-ID: <AANLkTimFwSZY5b=w32oiX05u--=tFw0-A8kXTtghMpSg@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
	<AANLkTimDi=KYZ7Bs4C+WEGoP8y-yzjynddWpkxohWoix@mail.gmail.com>
	<alpine.LFD.2.00.1009022033520.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 12:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrTcI-0003hv-5w
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 12:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948Ab0ICKeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 06:34:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35276 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab0ICKeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 06:34:22 -0400
Received: by gxk23 with SMTP id 23so645085gxk.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1aM3PEt5D2hwRxAygzwxhhnYQFwfGxfDN/RxqZu30L0=;
        b=bniWLPn+ghnrA3yLd58ek++ylcIDEj8jbHR1TL7G4/fDzxxOoLNEZ5xRdWxqqFJzmh
         7PsabH8BoyJuvUvv39ThZiob3T08pLiqONzF2bMUvz4m534oqcaEuHJH+uQqd8yMMJCr
         8upx2nE4DyD21t3gzLH89uUL+QCA7DLkMnSAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XT5Ax9Lzas235n0p50K3L6V5pJcPdvZMsscHiPk37AQHG57qKTyd0BHRRhDhlfwcPD
         GUaOxBK0RgZyBygnUoHy4uNRfZtnELaDAhVQTFEwzWwCnQqnnEZX6JD6CGRd6HbT+GEs
         UzXqeD9qXlGXzfvGQqkH722cqN0BfTDdZkDyk=
Received: by 10.150.219.1 with SMTP id r1mr320454ybg.173.1283510061445; Fri,
 03 Sep 2010 03:34:21 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Fri, 3 Sep 2010 03:34:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009022033520.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155240>

On Fri, Sep 3, 2010 at 1:36 AM, Nicolas Pitre <nico@fluxnic.net> wrote:

>> =C2=A0i can - so that git pack-objects, after "git repack -f", retur=
ns a
>> canonical pack! :)
>
> But did you try it? =C2=A0The -f means "don't reuse any existing pack=
 data
> and recompute every delta from scratch to find the best matches".

 yehh, i tried it - on a small 2mb repo.  whoopsie.  ok.  still one or
two ideas left.
