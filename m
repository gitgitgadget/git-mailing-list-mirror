From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Tue, 5 Apr 2016 21:27:34 +0200
Message-ID: <570411A6.6060208@web.de>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
 <1459802325-22056-2-git-send-email-alex@fournova.com>
 <xmqqzit80yov.fsf@gitster.mtv.corp.google.com> <57040EE0.40503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:27:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anWdo-0006Ra-LU
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 21:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbcDET1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 15:27:52 -0400
Received: from mout.web.de ([212.227.15.14]:62618 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbcDET1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 15:27:51 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Maazp-1b7fx10nMn-00KAc7; Tue, 05 Apr 2016 21:27:42
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <57040EE0.40503@kdbg.org>
X-Provags-ID: V03:K0:hT28g+kEnFhfr7t7DbGYT68ETbuYSJCdKvwfjwiOCXVwxmJz9NF
 p1M9fAXrqqFMQFuFIoXaWrZ6drkpDlKAvvy+x9diSkUu8TmZeD/6f5B3pCSHYk1tGApe6/q
 CXUJuyFePyP6wRHdmpMxXy0Xgt2vK9+pxIqw/mslMTo3GHhrwPkaHWqEIhV6EPNTdrJD+bc
 2LmWyjzXb4wMDjynh/K/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ocDbWSMhG40=:4nb3PAoyNhf54rqxSGO3b7
 oEtP9SAVnxmG7SvSf3/QqALlBCATjSgZgwLqyc1FyntH5ydFTHtV94Im5AUD05BpBmL6e1QqS
 HEL/NZO+GUBRmPQUVId2PzrsZK2nJJKI6bdXtvqR2C+01Js/8kppsS7n98684BqfqzfOKkNIo
 Lu37s7gg3P8BJwiVFi8LsESqa31Ejiyo9OA3OvtjvXF2uOLQiIVScy9wA7aDE8TyXbfACLvc0
 ffJwyQxeC1LI2Ty7RugBBpYKPEM4aO0HQNlOcukK3fVXeqTSPFxt9U6MkI5mBij6rUheBHIdH
 G+p2q/OdNUm6a4FZvIJQXgfwmEDw9umC9ki8kyQe4cln8aCy+Awe2/zPHHZyfPYo0jgU5cLxP
 LHKg6bzBbJHXJC4UUtAMsw0SRIgg/uEId8LpvEhQC1bpQ9Q0YYXEQB5t06zO3rNCN+A3vmuF0
 GStn9IUyjDJqx0J/0h0RnkHvc0WttSmPpd31xzAI8SZv9SjNWKtV4HouAAxFZDsskukfsAFDC
 nWzDU44j+c/1xU+zdrE70iwVlIJjPkQOYcsOYID2fZTBhLRp1SrBfc01y0C3p1Df3V7eYbLki
 obihX8R8MT9EzaKX7kCfbN2FDhrcZBB0MRsZjZVPpliFurHANBtf1UBNu4K9jUFbcszE0svVB
 jtrVYKz+gH7W8leJD30g2rkMTJVwgXVb+fB3MLYPyMfyPs98D5ITCnsMqzOBG3/ivU5w4Tkhr
 jkbqVwu5ct1JZW6pVb6gc3hRJDvOYLTHy/eBjsmX622qi6seUK+QAxJN3xsd0E3VKkz7Qo48 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290804>

On 05.04.16 21:15, Johannes Sixt wrote:
> Am 05.04.2016 um 19:09 schrieb Junio C Hamano:
>>> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
>=20
> I sense NFD disease: The combining diaresis should combine with the o=
, not the g. Here is a correct line to copy-and-paste if you like:
>=20
> Thanks-to: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> -- Hannes

Good eyes.

And thanks to Alexander for doing this patch
