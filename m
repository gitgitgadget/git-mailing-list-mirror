From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/1] support -4 and -6 switches for remote operations
Date: Sun, 31 Jan 2016 17:03:36 +0100
Message-ID: <56AE3058.3060609@web.de>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net> <20160130131353.GA20429@dcvr.yhbt.net>
 <56AD4887.3070207@web.de> <20160131000144.GA10117@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 17:04:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPuTp-00047a-Jh
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 17:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbcAaQD5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2016 11:03:57 -0500
Received: from mout.web.de ([212.227.15.14]:55441 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757479AbcAaQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 11:03:56 -0500
Received: from macce.local ([79.223.121.144]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M22Sh-1a63RA2lH1-00u1d2; Sun, 31 Jan 2016 17:03:39
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <20160131000144.GA10117@dcvr.yhbt.net>
X-Provags-ID: V03:K0:2s+JMD9IJl2LJKemxTi7JGt0BOvOUjKLo90wxX7R7KdOefJoalt
 ia5mqmlG5bNZm3PNe8FC5bL6PSEHq1WavpjMSZK1ibDdwqo3DRk5zynQugF69Xm/qVs5g4w
 dlVXMvi3p+WrnwZyzNjHlTwX++fz25zUT6zF/mKz+OtTJQ1VOEX2XXFNZEKYbFDcLg9GqXI
 LCZB53pr3REAnzZpcHobw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FcoK2kWgJgE=:pdbvY2xB1gfAnJuJsF5y8m
 dNZ+mihWSA/dfG4A4a2AclNY3tYnUmov74E1IZd3gHDlKMjqg3mqTpVoKxRCREKIpFqhreO38
 FcGqBx6rCUtF0NSUJFcCYvPvceOCutuHVrmEyzLrTMcpzwyRrMBeMI1qOGcyJMNmZturJ4vX9
 5F+rIq8Wr7tIWOmgN7YCfOQJzFIvu7g+IywRj19rXZELuxAsIRqd1ZYIXPvIESjv88DO7x+5e
 71/pPb5/Xb9i/ccjZP64PQEzF1lRcgzxK0BUqjAjZOIqS77Bwu/X0PkgeYSVjIsFsWCmKYcZ5
 cFQtjMVp2fz9b3LFbUHu2aGnITYXhFJVBQWlOTwxBi5jVmq1mdPsTd7EmG4THccoJGcBsKsnN
 ba1n7jwuY39DtUV3cJdZj858ZD4ZbTMR6kkqoX5GiGyuuPKZicDzd0crniSKArz0asgfpCTvw
 q27An0zVfZJUxf9hJ1nU2QSksFItCfaOcSamOB0GegFC+E04bvDBOFw53ih7ZZ+Kak01NDIlf
 yGWo47Dw+jJBr2gKgSlgJUhFZnnCu2fGX8rX/U9QYRkgKnJ9Ys+jZOCYRvNPteu7YgrdwWWsH
 gwY/qQXuDxksdhla8Sn9sjPltkvnpat9AiknrIF3ZncMEtavGqdS3u+FahnVzavgBGoRz3JA1
 +JjF8G+N15Czers4bgVLPaobS82Pfx1O2Gopz6MlOoR7IRA5FLuwsglIfeupKccwiMu2dIJLT
 qxinnXQfgZlmM0jvNUv3XnMHz9rmbgkeIJ87F8OqRwZx5evcRxyPzZb3iDF3mLL4NofcIZNA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285154>

On 2016-01-31 01.01, Eric Wong wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>> On 2016-01-30 14.13, Eric Wong wrote:
>>> The ssh(1) command has an equivalent switches which we may
>>> pass when we run them.
>=20
>> Should we mention that putty and tortoiseplink don't have these opti=
ons ?
>> At least in the commit message ?

I may need to take that back;
Just did a test with putty (under Debian)

And both -4 and -6 are supported, nice.

I couldn't find it first, but here seems to be the latest documentation=
,
which mentions -4 and -6.
http://the.earth.li/~sgtatham/putty/0.66/puttydoc.txt

And even plink acceptes -4 and -6 (again under Debian)

Sorry for the noise.
