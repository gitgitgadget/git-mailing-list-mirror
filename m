From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Mon, 29 Nov 2010 17:35:26 +0700
Message-ID: <AANLkTiksxy5xJiw+T37KTaCV0s6OU7KbQhgQSo=tQi7_@mail.gmail.com>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
 <AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
 <AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
 <AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com> <1291025571.4262.21.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 11:36:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN15X-0000hc-1D
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 11:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0K2Kf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 05:35:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33607 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab0K2Kf5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 05:35:57 -0500
Received: by wwa36 with SMTP id 36so4530467wwa.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 02:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Xn+PoZ7Xty5+Krha5QA96utbky7syjVd+RWhUMtspEc=;
        b=tzl9KQKjrTM8FdAHI/kiUXpESEPAVfKbOyzO9Gq4umm1eNWdaQlhvUedxUqTpvuwmI
         LFQG059ElWjKubLeMn+nZ/wHIsXeaHxhx444Hi1hIm8qV3OnEJL1QmO/0AieDRXpKjV7
         T3tMz5RHfAE/2LbRSzgY3K7bQ8sor2kY/grA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Oc+sUAKbYLkyMJvaKa86ivQIXEVBcbMpqpaQIQW7s4YKGBK7CjnshTL44Vm47fWHc9
         /gvI9PtAOJKrK8QHTJ4tVo49XcfPQ37W3gYLmlyHuo3YAYNwWwq65CguUy22hgUT3kUP
         loPHZ3OfxPJdVFZU3pZVW71/x/LUWQRSnI1s8=
Received: by 10.216.162.70 with SMTP id x48mr170564wek.4.1291026956564; Mon,
 29 Nov 2010 02:35:56 -0800 (PST)
Received: by 10.216.167.193 with HTTP; Mon, 29 Nov 2010 02:35:26 -0800 (PST)
In-Reply-To: <1291025571.4262.21.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162382>

On Mon, Nov 29, 2010 at 5:12 PM, Will Palmer <wmpalmer@gmail.com> wrote=
:
> On Sat, 2010-11-27 at 21:19 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason wrote:
>> Right, but is there an actual use case for people who are developing
>> code to use something like git over p2p? Maybe I'm just being
>> unimaginative, but I can't see a case where people are working on th=
e
>> same project and can't find a way to push/pull from each other using
>> the existing methods. Especially since it's easy to sign up for free
>> Git hosting and use something like Tor to pull/push from there. Or t=
o
>> set up your own git HTTP server on a Tor *.onion server.
>
> To me, the use-case wouldn't be because I /can't/ use existing method=
s,
> it's because I /don't want to/ use existing methods :)
> p2p tends to imply:
> =C2=A0..
> =C2=A0- Downloads from multiple sources at the same time

I would add "automatically" and it's a real case for me. I work on the
same project on different machines (each of them has different
resources that I need from time to time). So I clone to all the
machines. If I make a fix in one machine, other machines should
automatically fetch it. It's like a private p2p network with a single
user. If I add another machine to the network, all nodes should be
aware of it, without me doing "git remote add" on each node.
--=20
Duy
