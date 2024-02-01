Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B458665C
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790345; cv=none; b=COCoNW0osj6BEgSX5f7SIi7zOBOg0txkoPmv2TmRwk8Q8+heAm3SB6NQw4QuB4VpVAReyxF3BvhurDHN05+Fg8ikx64B0rNCfFO4li16zuPN8Y7zJ1aZHE4fHKI/yUfuLfdA9aTN3wZCSK9E+6NMFrTsm1pLQJb/55wOhPojZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790345; c=relaxed/simple;
	bh=rmT98KXegVczCd0xy4WFbcP8ESn7LMZZKOaxL8E4EDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HUk2k/VwR/9tioVzLnrwoQYgboQo/WQz1KJSVafGEPo9pqrayw3jwHsNqvt74mowrZ7tD4jbVmv0mXGUMoYHqPoKDMJo1q0/esjtby0srSg6t+PPGaxXT2pnqxz8aZoiy3zw/4T0ihlcFsApxqoYxtoL6POSLPUttINF98rBSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=LkQMrfq/; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="LkQMrfq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=delpeuch.eu;
	s=s1-ionos; t=1706790340; x=1707395140; i=antonin@delpeuch.eu;
	bh=rmT98KXegVczCd0xy4WFbcP8ESn7LMZZKOaxL8E4EDM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=LkQMrfq/Jm5diBRDG9yY8rY9I4sOF95OPwK7vBRrNB6x5DcGBXVPMPRdU61M8I5H
	 UBUmjoDCoybqu2G1GVR23/1zC+sNXrixcAKlmg9e7dIU5mtOAOGiCK2XSItF4Efyq
	 3Q+kwn/eaSEjFXVb6YcbZObrtSwh7VAkOUuPOEyoEitPoVfZrZdmpdeqpS7d4C/RJ
	 nnm8rVhH6pbUjl7l5US7WqDPVhOobkOvSNgetxGbzY5wuI5fGQvKv+ClX1jQ8miSk
	 J8B1UVUW8TJbqP4a30mmiriGLS+gPxSDp8PNkRgFst2g/MsnNe42PvXCDnvEom/pA
	 uaaeZfOMdONfHZvfVw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.24] ([87.167.83.59]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MoNu2-1qgpAh3yK8-00opGj; Thu, 01 Feb 2024 13:20:28 +0100
Message-ID: <213029f5-63db-4fa6-9c88-2aebd0df9a15@delpeuch.eu>
Date: Thu, 1 Feb 2024 13:20:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
To: Hans Meiser <brille1@hotmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DhX4emPjSbz3IrWFfZs8C8zwMjDznRB1tYtiWODb8VbimaxVFO9
 ovnmbjLCts6TTfJe/Hy0zPMAozlK4I4YBKL6el8IeepWpaYfMkFerOsDnjcpoSvIUfaV587
 DoK5vufpoqktU674Ym5bf9f82g5QxDpl3bpzMORpo/m6vH0u6MYQLR6bS5bR2JSsnyMrqAe
 deE3Tj1/bwxjOrSCVwjYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UL7tqPB6Vak=;DSX5UBt1VBPBXFIrbHI13ncFoRl
 Ck50SYawEdtJBK7LA+Lzz+jNi5eHrIdkaRMySvKRlULz1w4SR/ndDFe/PzaUvcZaHQDinqoXh
 DJ11+sKzOhvymC/KAndC2mlzZ42eiEyST6T635dQ7ag4aJNpndco/tvtimhpnTGG6qRYGr46n
 A87z+CF8e1rbVrUUZJm2SL1HM8Ak7OHOpXLa85Oj9TELAxcIXjGMuSy2EbLyyjhPT6YWsSplG
 SNyPzdC/CL7rJk4c82mpl9uzZe8jCfNtGozR5t7HHPu27HZXJvWtcIcYsCB81dtwQ5CSZffwY
 hLnAOYRyUKXfQwJyfNX5RoMr0KdNUFBXGY1mHhM/L6CC3w2JSutPfzXJ/W02UfrKmpRzW8MCw
 KqbIpUvtJSR224JHPBsnndhKPTj0TlZxNRqJUHbL9ffPyvL+aXrhigSfdl7K84DsA3M28UzrC
 T//oK9U9jZH7SD40rkXCY1JbCzE/fptbcYnzRFHlu3xwygHiZsAsHfA2fdLl7mPUMSkky2UsX
 /8oHaJu/ROElcvVEtnZr3fEQDG0CVsiGBiHYoTur62bdf7yC9FIhxu1XxERfRkCbFEsSyqWZ/
 UCuUqAeVbwW+FcuEp8K1TIr7aIhnmuWIJprcqhNHGScW/KcVCgu8uyiU5Vp/+aYsAGnTSCVRB
 n+zQeYdonfaUJtu3Xfqfcg8VeplDXjaU/3t1HXsdkcHB0FHb4QqcH0stsbmjyTD2OHk5z7I5G
 xA+cDEc9lxU/MlZC6w9RTmUsF4XjOnvnamwP5x3aBL7DeQRh+shpSI=

Hi Hans,

As a new contributor I have also been wondering about that and I found
the notes of the 2023 contributor summit very interesting in this regard:

https://docs.google.com/document/d/1GKoYtVhpdr_N2BAonYsxVTpPToP1CgCS9um0K7=
Gx9gQ/edit#heading=3Dh.bdw77tvsksnr

There is a section on "Project management practices" which touches on
this topic, with the idea of using a bug tracker being raised for
instance. So you are not the only one thinking about it at least.

For what it's worth, I have written up a small report about my
contribution experience (which covers project management practices):

https://antonin.delpeuch.eu/posts/contribution-experience-report-git/

Best,

Antonin

On 01/02/2024 13:10, Hans Meiser wrote:
> Hi,
>
> is there any current discussion about moving Git development=C2=A0away f=
rom using a mailing list to some modern form of collaboration?
>
> I'd like to be able to follow a structured discussion in issues and to c=
ontribute to the Git documentation, but the mailing list currently just bl=
oats my personal inbox with loads of uninteresting e-mails in an unstructu=
red waterfall of messy discussion that I am not able to follow professiona=
lly.
>
> Are you consideration for migrating?
>
> Regards,
> Axel Dahmen
