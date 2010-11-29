From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Mon, 29 Nov 2010 10:12:51 +0000
Message-ID: <1291025571.4262.21.camel@wpalmer.simply-domain>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
	 <AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
	 <AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
	 <AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 11:13:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN0jH-0001QR-U1
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 11:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab0K2KM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 05:12:56 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51367 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab0K2KM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 05:12:56 -0500
Received: by fxm15 with SMTP id 15so2250039fxm.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 02:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=vkzWGYLBXwvlJd8oQVRMqrG6bvL8WX1rHPhCsllYC8I=;
        b=heVF42/ipf2TFCIjqt5AcyfQ3M+nue/DquNGLe1hmsoH3lyLn1VHBr65251+otxukh
         9XFVGpLmgaGKkY0SP6vRhVF5FlrzUHNjOu8pHqkJv4ZX2INHQkeAaG3jkJ5z6ACEQP7O
         4s42/6DD6EtYX5QSk/mgymj1LuO1BOxUk2ShU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MIGaBt18AQcB1qGdkIxPTwy9taqRSlhLJQQoEyK709NLK8arcKSq6effeGJuhLTWlh
         D37jcILy5FAceY6LZ5At318OXQrckAcZzaTkQ9c9fX47wbWhYIOeFrhBG0RNT7t2LcCD
         OSOYyxMzK3II3y/BT4XM2ZiUKRf82mCqAvKUc=
Received: by 10.223.102.141 with SMTP id g13mr5235117fao.133.1291025574647;
        Mon, 29 Nov 2010 02:12:54 -0800 (PST)
Received: from [192.168.2.128] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id y3sm479170fai.14.2010.11.29.02.12.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 02:12:52 -0800 (PST)
In-Reply-To: <AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162378>

On Sat, 2010-11-27 at 21:19 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> Right, but is there an actual use case for people who are developing
> code to use something like git over p2p? Maybe I'm just being
> unimaginative, but I can't see a case where people are working on the
> same project and can't find a way to push/pull from each other using
> the existing methods. Especially since it's easy to sign up for free
> Git hosting and use something like Tor to pull/push from there. Or to
> set up your own git HTTP server on a Tor *.onion server.

To me, the use-case wouldn't be because I /can't/ use existing methods,
it's because I /don't want to/ use existing methods :)
p2p tends to imply:
 - Resume-able downloads
 - Downloads from multiple sources at the same time
 - Transparently using an alternative source if one becomes unavailable
 - Load-balancing
 - referencing/linking based on "what it is" instead of "where it is"

The reason this stuff isn't a big itch for anybody is that these
problems tend to come about when cloning, which doesn't really happen
that often. When there's a new release, fetching the latest
release-tag /might/ bring about the same needs, though in my experience
"there's a new release" generally means nothing to me, since I check if
there's a new release by running "git remote update" and looking for ne=
w
tags, merging with my local patches if I see a relevant one.

I'm not convinced that any of this is something which is git's job, so
much as it sounds like something which could benefit from another
transport layer that git can optionally tie into. Sure, these could be
developed together (p2p with git in mind), but adding a giant p2p
section to the git codebase sounds like bloat.

I want my version control software to use p2p concepts for efficiency. =
I
don't want my version control software to be a p2p client any more than
I want my text-editor to be a mail client.

(In case it's not clear, I am in favour of p2p ("gittorrent")-like
functionality being in git)
