From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH v2 3/3] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 19:52:01 -0400
Message-ID: <48A4C521.6090507@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us> <1218752308-3173-4-git-send-email-marcus@griep.us> <20080814223740.GD10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmcz-0001Gv-Ju
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYHNXwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 19:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYHNXwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:52:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:47001 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYHNXwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:52:08 -0400
Received: by wr-out-0506.google.com with SMTP id 69so782765wri.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=cQ1VLGV/zg8X+hS4BrTq1RDsUhcKdN951j1du6jKcU4=;
        b=RDChodRWMArcJordD2MhvCi5ihtvmijWp3K7/D0iz5Ai2kQWZM4Pbix4ocP2mgufIW
         6dfg+uJDf18OmnlE8nNtxW64uHMSxiAcIX0Y8fnXN4sFgthH7uJwFWeKAo7Z5cc1+pIj
         ovu+b3dS8f22gSdHc1O30QmNqtzoq1Nemx0HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=i4b8V7XpRmgFz4Q+ygown4D67NIWB4YgUxeqhT3PSVohu/jsdxYGxr2dugkJRji2u7
         j4tfkT+3bx/6Ia0uKVlDgSbOVnZ/IidtyrWaMfn6zhMttgdfMFEgMHVsEJ5/YKDl7pqt
         2JYW9wBFy2N6f4+pgBGZZGx+TRlJ6OiLtAVD0=
Received: by 10.90.50.5 with SMTP id x5mr2676227agx.120.1218757927454;
        Thu, 14 Aug 2008 16:52:07 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id p60sm2451788hsa.14.2008.08.14.16.52.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 16:52:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080814223740.GD10544@machine.or.cz>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92443>

Petr Baudis wrote:
>> +-H::
>=20
> Can you guess what would I bug you about? ;-)

If we get '-h', I'll submit another patch :-P

> If it's non-human-readable anyway, why are you dividing this by 1024?=
 At
> any rate, it is not obvious at all that the size-pack is not actually
> size-pack but size-pack/1024. You should either add the (fixed) unit
> string behind or name it size-pack-kb - or just not divide it at all?

I divide by 1024 here because the loose object size is reported in KiB.
The total that ends up in size_pack is in B, hence to be consistent, I
report the pack size in KiB as well.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
