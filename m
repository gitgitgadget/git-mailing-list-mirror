From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Wed, 4 May 2016 06:07:21 +0200
Message-ID: <57297579.6060805@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461942126-16296-1-git-send-email-tboegi@web.de>
 <xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
 <a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
 <xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
 <xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
 <55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de>
 <xmqqbn4nngci.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 04 06:07:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axo6G-0007B3-9r
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 06:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbcEDEHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 00:07:41 -0400
Received: from mout.web.de ([212.227.17.11]:50912 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcEDEHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 00:07:40 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MLgZ5-1ay5D91lLv-000qPy; Wed, 04 May 2016 06:07:28
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqbn4nngci.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:QtLLsxm0gZGr2uSBIISnmueHAEULOLFNJfU7YrV2X5wwHDyYwF8
 0JFXB8MHNgzwmCmZzUdzNtVWA9jJNlnUES+46hNm5VMclh8QYXX3LeBfGgrnX/X9Pv0FOFE
 GD2r1aVwcuo9joVED86DLNFeOTp5zN8WI8F0HlLDEpjlDBLtgT+mRsbLQewbuDrA2CXWbyK
 RsE1sFJaGibC9A+TbwfHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L/319yR9lkI=:x5Kxdlm43Hq2uzr0V2LFuf
 PYRwcZF5Y+J6Gnm8FVvjdDAbLE1bu8lqT2R0rC6vGzp6OwyImLC1jy3CUZL7E9Ttp5OEiPZ84
 /OnyqcyI1C6Jax6fCdmFThFGx7KLD/HZmgVgLySW/AVLYQzjyVY26zvduMp2XCK8q80l8xII5
 4vdErJwmyaMojZ+eeuPXOai8HB/QB4Q5lRb3PNddzyIkBWamMjXTOssDHcWv1Ignwj2GaF4Fi
 fOGM6d9saVc6Wm/qx1qdf4LNtyl4ks+30PcSmkDo8iTw4v9k65sI4s3NOJjw6j80BPJ3+IiDh
 z87h5dJvBrsYPfXKbC/0RNcSThpfWcKMCDQKX2anoN+CA0ctTmBXFnBGNBT9FyDcxDk2v8IUU
 M6Mo+m47A9O3h+kX0lF2z2aSUg1vNX6UAT7HKvZv2+vWXcx5jUhOYZfaSA4NpKGGl9M7snhG9
 1A7LH0zmyFg4JeVuVIilBDWXpDyqtUSiqEvYip9Xd0f8iyX/qZijrj9ysOwGIRGm7EEP4bmGw
 mhRL4XJ4LfRbGF+Wo2xO8jXOJRBB39/ypV9YBVSvT4jVmihaLXb/9mLS6bXjUaGUJ3e/59H8u
 Wfeb5tnzgj0qQvCZTkE2E6yvdbjHFqTMS1rLuL2l9bj/4grtPMUSx4mQG2ExUzH/KwzTOFBok
 alHJEdGOM9Br1607t0/gR1G6QY/WpacShCAGMDrFapwBdYbH3IQ7xf2qvh3jBOfh8Zb7dJ/fb
 VH1pjQpflFcQs4CzFSflfcAericmR+K2xuHbCXQt16hGj6ohg8N5BDe75B0WYfwOrXoaASgF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293486>

On 05/03/2016 08:31 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> This will probably take some time, so that's why I asked if 1/10..4/=
10 could
>> proceed as is ?
> Sure, I wasn't saying 1-4 looked wrong at all.  I was wondering why
> the ones in the middle, especially 7, shouldn't be moved forward
> together with them.
The main reason is, that 7 breaks t6038 under Windows.
(And I discovered that too late :-(
And as Windows is the platform being most interested in CRLF handling,
I need to re-do some work.
