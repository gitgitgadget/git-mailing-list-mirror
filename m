Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8373199A1
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459914; cv=none; b=MS1f0vMKEeiWhei/pF5ew/O8lpMNNAmFTGdcm0Ckjh4fmWA5a5gKb2KTqtpdyZpL/eQr0fgYztS7yymB/fLVVmpcWKbWnJX9qQt1KPqufadlp6FQdTw6Wa6ImoxjDgSvVJOSQUaFaQGh6APU3U1a3o1vF9cruw149/VaMY8banU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459914; c=relaxed/simple;
	bh=BO56gkoJ0QNX0TcTBIakqRZw0ypgfdPD3FkFQEXDjzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkrB7J18R3Zvi7xnqOL+P1P3JPInkF/ksahBphfsMXWF0/xNBNNMa9Bfl175/SydrD504k7Iq7CgjDYjp04/c5M8V+hVhgftsweFstJotT1wKSV9Olkk8YYcPkSnvrjvxU7qTyhJIYM3n36fUFRAyhXwF//PDX2nr3VIJEw/x04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=FvTQGRAe; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="FvTQGRAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714459903; x=1715064703; i=tboegi@web.de;
	bh=mI2ejZ8vyhyrpqyhYpa9CI0a0V8T2cdg5RC7J3FLG2A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FvTQGRAegto6MrsRgjcmO76c2ohnpvQp5qG2Cv7uqL6fxHa/AQ6gDwL2TYwIfX6w
	 kQD8x08QO0d/t4cOiObWaZcDFKqragS7PAAtjR43UjBS5iVg1e2bJZPplISYJswXp
	 nGrjrpl6XbF7ya/R4Hncdp7Hr2we/b7Cm7KjfsEcCO7Kqv7kOPiMmj+1OoTZZjMsi
	 MTQsntR72vydD7SYxrVtpC4UbS9RFSfKLT8ssmE/m2FuV9xmdnZVCd11eD6ttdNg7
	 Cuzkg0Pc++RfQhewe5T1COjW8hJBJ762qTvcDwgPpDs8pcpNGJsfRZYeGXsOh/up4
	 mGPydKQT7di9Fp4G1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS13n-1sDdXY2R8V-00TGnh; Tue, 30
 Apr 2024 08:51:43 +0200
Date: Tue, 30 Apr 2024 08:51:42 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Matheus Afonso Martins Moreira <matheus.a.m.moreira@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Reply to community feedback
Message-ID: <20240430065142.GA1504@tb-raspi4>
References: <20240429205351.GA27257@tb-raspi4>
 <e7f49f373b2a3b51785d369e1f504825@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f49f373b2a3b51785d369e1f504825@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Kj7GDdIny0GFL61+9yMY4qXCVLOLaYNdOxWFSI3sD6R083MQG59
 PtDesOoPOtm5QojkM51/NySqDeH/3X1y9JAaQeQsWEvRTENDCJ+1oiOFsZgVFO/zT+DEyZd
 q43KEWz+tsjXew2RQKjN1HdDQt9Je+Z8Z5eLq/pCSdYSE4JvdaMZ1AdLGghK84jFuWwcwX9
 Vu2z5VMlbauz6hH0Y7nfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:79TMW6wqjhY=;+rIqw1tddPB7JQPKOM6mdpRSNlW
 OAqkO8ZgjpRDf2TK8VHAtAgjpRoBAnwCofPe1p2op2YbXj2HooN03oIWg2sO3TzT9i5JHNp15
 EDobXd047BY79wndgLIHYYoNy4LSYdw2ERCX2QYCpvWDrRALrwFvUGacpshSumeULpDi70qAm
 woqmdz9TRDL0qjicmzm3TbX1lk213CrlJBPeGQmyG3kH9Dt6r+klltNwhdvIAoxvfX5Js5WVv
 SKEjsiJiiTN1+ouorO076jp3Bkh06nQPJPD4K0XEh5JyEsSzX+BQ/F5Qijhtt2djI+0YJmop6
 5octPMfWigoe+4i4hk3tlJrMfUxWGv6ldDsg08wp5GnRTdjgpVcl3Q2cHtRtGtUpO6IPagtj+
 Jo4o0R889Ja885Y8m4essFSJG9xCb5kQsX3spKDyqsIM7jPob7lr2t0Qeda5D6/6A3/d9krSQ
 hgarRvJuyP0vmZY8eWG7YI9wwPBL0kqU/GlX1GYdsWZu5Y6qeTf99QGhpGLVZJH9JmoBLE1uu
 HorvDDUWUYwoaVGRuYZ/pyn5S0Q0WQ1qEEpgcyhsmdejd7pExe7ECaR3iEfpg/NrT4ZrUe/6k
 Pf1IOd9YwAlIRjPnrLspVdZNIExMx/wupIF77whMEbn92dStZrBOrAqFiELvRGLrPraAdvTBY
 JWxn5kv247kqJ8L6sjY7LDNlZo4baXSPwOJMan9vil/1GboJcLeH66RQIK8at/yacYA5cQLmH
 NWrewQalhSrM1haY1AnLPdTGQmtIhjSzolfj4pxND+gwZwJL8Go/2hd7EtmyAm92hoSxv9Hmr
 vQ8Cb915Pzk9vkjJ4+b0tNlTQiSlgdVY8WtMrMa5W3UZk=
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 07:04:40PM -0300, Matheus Afonso Martins Moreira w=
rote:

> Thank you for your feedback.
>
> > are there any plans to integrate the parser into connect.c and fetch ?
>
> Yes.
>
> That was my intention but I was not confident enough to touch connect.c
> before getting feedback from the community, since it's critical code
> and it is my first contribution.

Welcome to the Git community.

I wasn't aware of t0110 as a test case...

>
> I do want to merge all URL parsing in git into this one function though,
> thereby creating a "single point of truth". This is so that if the algor=
ithm
> is modified the changes are visible to the URL parser builtin as well.
>

That is a good thing to do. Be prepared for a longer journey, since we hav=
e
this legacy stuff to deal with. But I am happy to help with reviews, even
if that may take some days,

[]

> When adding test cases, I looked at the possibilities enumerated in urls=
.txt
> and generated test cases based on those. I also looked at the urlmatch.h
> test cases. However...
>
> > Some work can be seen in t5601-clone.sh
>
> ... I did not think to check those.
>
> > Especially, when dealing with literal IPv6 addresses,
> > the ones with [] and the simplified ssh syntax 'myhost:src'
> > are interesting to test.
>
> You're right about that. I shall prepare an updated v2 patchset
> with more test cases, and also any other changes/improvements
> requested by maintainers.
>
> > And some features using the [] syntax to embedd a port number
> > inside the simplified ssh syntax had not been documented,
> > but used in practise, and are now part of the test suite.
> > See "[myhost:123]:src" in t5601
>
> Indeed, I did not read anything of the sort when I checked it.
> Would you like me to commit a note to this effect to urls.txt ?

On short: please not.
This kind of syntax was never ment to be used.
The official "ssh://myhost:123/src" is recommended.
When IPv6 parsing was added, people discovered that it could be
used to "protect" the ':' from being a seperator between the hostname
and the path, and can be used to seperate the hostname from the port.
Once that was used in real live, it was too late to change it.
If we now get a better debug tool, it could mention that this is
a legacy feature, and recommend the longer "ssh://" syntax.

>
> > Or is this new tool just a helper, to verify "good" URL's,
> > and not accepting our legacy parser quirks ?
>
> It is my intention that this builtin be able to accept, parse
> and decompose all types of URLs that git itself can accept.
>
> > Then we still should see some IPv6 tests ?
>
> I will add them!
>
> > Or may be not, as we prefer hostnames these days ?
>
> I would have to defer that choice to someone more experienced
> with the codebase. Please advise on how to proceed.

Re-reading this email conversation,
I think that we should support (in the future),
what we support today.
Having a new parser tool means, that there is a chance to reject
those URLs with the note/hint, that they are depracted, and should
be replaced by a proper one.
=46rom my point of view this means that all existing test case should pass
even with the new parser, as a general approach.
Deprecating things is hard, may take years, and may be done in a seperate
task/patch series. Or may be part of this one, in seperate commits.

>
> > The RFC 1738 uses the term "scheme" here, and using the very generic
> > term "protocol" may lead to name clashes later.
> > Would something like "git_scheme" or so be better ?
>
> Scheme does seem like a better word if it's the terminology used by RFCs=
.
> I can change that in a new version if necessary.
> That code is based on the existing connect.c parsing code though.
>
> > I think that the "///" version is superflous, it should already
> > be covered by the "//" version
>
> I thought it was a good idea because of existing precedent:
> my first approach to creating the test cases was to copy the
> ones from t0110-urlmatch-normalization.sh which did have many
> cases such as those. Then as I developed the code I came to
> believe that it was not necessary: I call url_normalize
> in the url_parse function and url_normalize is already being
> tested. I think I just forgot to delete those lines.
>
> Reading that file over once again, it does have IPv6 address
> test cases. So I should probably go over it again.
>
> Thanks again for the feedback,
>
>   Matheus
>
