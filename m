From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 21:48:44 +0100
Message-ID: <AANLkTin-gwN+QXjjwr7UPMi=QwSFdDjRBqmx9jgunhJM@mail.gmail.com>
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
	<FyEIt68YHr11lsX_CGcHmYfITTgX-iSs9tVNIBMG7FQ_WhGc4ttvXw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:48:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGiJ-0005ce-C1
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab0IBUsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:48:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39509 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0IBUsp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:48:45 -0400
Received: by ywh1 with SMTP id 1so396398ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jFLhXUTDCG90Ib4e9SpwoTzDZi1UH9iPlns0WW8T1mU=;
        b=oshyg8cs9/ijjXWi7vsW3r/nCDgJsJpZmJObjTzHvhD5EPqKY6xd5L6txmEpoiVJRm
         2Jpcb1vGG9e3oCae2rSmjH7ARA77yeApTjb5iKsnf5VAJoXYeIAYbUw7Cf5Kt8fGSX2H
         E8LNy2ZdfGk85C7KShMImyX9fWrqf5T4DuOhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FqGXJL0uwi08RUbuJJL912P8ZEQLhb+n7OcVXWfeB0NhOokWQVgoJJATmjrSz+pgVA
         2Nj2uqt86Pt9cGr01D6/LymmW6q6xzQuG2ugRvgjEx0Rb/KEN0DeIT24D0FYHONMtsCf
         QAw3+6Iii8N/+Qh8BRXbELMUqPAwN4DW1u+XE=
Received: by 10.90.82.9 with SMTP id f9mr91824agb.3.1283460524413; Thu, 02 Sep
 2010 13:48:44 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 13:48:44 -0700 (PDT)
In-Reply-To: <FyEIt68YHr11lsX_CGcHmYfITTgX-iSs9tVNIBMG7FQ_WhGc4ttvXw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155203>

On Thu, Sep 2, 2010 at 9:28 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> I think pack-objects already has a --threads option allowing to
> specify the number of threads to use.
>
> =C2=A0 --threads=3D1
>
> should do it.

 git pack-objects --help
 ....
  ....
       --threads=3D<n>
           Specifies the number of threads to spawn when searching for =
best
           delta matches.

 wha-hey!  thank youuu brandon.

 okaay... so maaaybeee there's a workaround (not involving patches to g=
it. whew)

l.
