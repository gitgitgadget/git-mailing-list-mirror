From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t5551: do not use unportable sed '\+'
Date: Mon, 13 May 2013 20:24:44 +0200
Message-ID: <51912FEC.6020909@web.de>
References: <201305111525.53130.tboegi@web.de> <7vwqr5wdqm.fsf@alter.siamese.dyndns.org> <7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de> <7v8v3lwa5p.fsf@alter.siamese.dyndns.org> <518EAB7C.3010508@web.de> <7vsj1svqi7.fsf@alter.siamese.dyndns.org> <7vr4hbu818.fsf_-_@alter.siamese.dyndns.org> <51910418.2070904@web.de> <7vtxm6n8pj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 20:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbxQb-0003PO-RH
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab3EMSYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 14:24:50 -0400
Received: from mout.web.de ([212.227.17.12]:55031 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab3EMSYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:24:49 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MXYjm-1UzePL0bzS-00Wjv3; Mon, 13 May 2013 20:24:45
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vtxm6n8pj.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:p+mdJGXyQDdtt873QtuPqbhTYVqc1oPT19a3dgH5c/K
 egS8uCMtEaYoxa+ZeIiUGSp4+n1ZnVnAVCDeCtK+AVkR/XlBda
 5LitIsjLvArGaTByIf771Dc8h4w4uXGE9UgxgvV4UAKcSoO+Up
 E/qSCacYRy4vzvI+JNGK89+tSVA4rnCkKl9nElaBwnfTy5iB6H
 i3Fih7F9mzsb4BXignHTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224185>

On 2013-05-13 18.30, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> On 2013-05-13 00.50, Junio C Hamano wrote:
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>  t/t5551-http-fetch.sh | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>> Thanks, works like a charm, tested on Mac OS.
>> /torsten
>=20
> Thanks; I take it that you reverted the "sed fix" part and saw the
> updated "clone" check fail with the platform "sed"?
In my first test with the fix the test case passed.
Then the sed expression was only manipulated to verify that the TC fail=
es.
And now I took even the original expression and have verfied it is fail=
ing.

The short version: Yes
