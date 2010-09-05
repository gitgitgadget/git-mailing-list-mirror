From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 5 Sep 2010 18:16:26 +0100
Message-ID: <AANLkTimZA=VpGjcZEjoRVJUZcwnYoPQF5bNHyM2J8byE@mail.gmail.com>
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
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
	<AANLkTim1XMY6Qe+h9LpqfoBzFE+B5AobcOpHx1rDfXwZ@mail.gmail.com>
	<alpine.LFD.2.00.1009042119570.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kyle Moffett <kyle@moffetthome.net>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 19:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsIph-0001Q2-QH
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab0IERQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 13:16:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37010 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0IERQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 13:16:27 -0400
Received: by vws3 with SMTP id 3so2710765vws.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xeoz3y0ViEpNHX7KUCepUsdWrUKkYVPVHAl4+5Tl1oQ=;
        b=YeteMPV+b2bLMKEhejF101Uy67kwzmVUP5GdFOeYESKMm9j4oxWgKnMG9BkTYtgn/h
         c4JavsATyiLpXsEmXbisMdL6B2Lqc/x7+w5oC+SuPLbRi/WcNG1IZUSo1dsHg6SDgfr5
         ykuJjwxnFOG2uONPuIxOs0YPWD7qS9ySbudjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wltbgpBFgF5XMZXBf24U0k81djoKs8U+GxmPBuyA0H7GiJG6JyshyTk3FLjE2QfUie
         gAU+Jk4Pw9MYJpx6rt8L2qRyq6oqhm4YdnaW77PALuKxEblQOaf0hwB7DiwyGU9dbkK7
         KvNWoVkPA00AbIcEHfWX5HnUQNaIv7XxgPNqQ=
Received: by 10.220.62.202 with SMTP id y10mr508794vch.58.1283706986814; Sun,
 05 Sep 2010 10:16:26 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sun, 5 Sep 2010 10:16:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009042119570.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155461>

On Sun, Sep 5, 2010 at 2:32 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 4 Sep 2010, Luke Kenneth Casson Leighton wrote:
>
>> so, i believe that a much simpler algorithm is to follow nicolas' ad=
vice, and:
>>
>> * split up a pack-index file by its fanout (1st byte of SHAs in the =
idx)
>> * create SHA1s of the list of object-refs within an individual fanou=
t
>> * compare the per-fanout SHA1s remote and local
>> * if same, deduce "oh look, we have that per-fanout list already"
>> * grab the per-fanout object-ref list using standard p2p filesharing
>>
>> in this way you'd end up breaking down e.g. 50mb of pack-index (for
>> e.g. linux-2.6.git) into rouughly 200k chunks, and you'd exchange
>> rouughly 50k of network traffic to find out that you'd got some of
>> those fanout object-ref-lists already. =C2=A0which is nice.
>
> Scrap that idea -- this won't work. =C2=A0The problem is that, by nat=
ure,
> SHA1 is totally random. =C2=A0So if you have, say, 256 objects to tra=
nsfer
> (and 256 objects is not that much) then, statistically, the probabili=
ty
> that the SHA1s for those objects end up uniformly distributed across =
all
> the 256 fanouts is quite high. =C2=A0the algorithm I mentioned comple=
tely
> breaks down in that case.

 mmm... that's no so baad.  requesting a table/pseudo-file with 1
fanout or 256 fanouts is still only one extra round-trip.  if i split
it into pseudo-subdirectories _then_ yes you have 256 requests.  that
can be avoided with a bit of work.  so, no biggie :)

l.
