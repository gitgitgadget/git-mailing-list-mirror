From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3] remote-hg: do not fail on invalid bookmarks
Date: Sat, 22 Mar 2014 17:41:37 +0100
Message-ID: <532DBD41.6080008@web.de>
References: <A4F451CA-D1DE-43A9-A4DA-23594C08C4DD@quendi.de>	<532CA557.20007@web.de>	<10F8010F-96E2-45E0-B6D4-C3709AED3C28@quendi.de> <xmqq7g7nrxmv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>, Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 17:42:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WROzg-0005lV-Ml
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 17:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbaCVQlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2014 12:41:55 -0400
Received: from mout.web.de ([212.227.15.14]:49727 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbaCVQly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 12:41:54 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MLgZ5-1WRg6X3yTb-000rml; Sat, 22 Mar 2014 17:41:43
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq7g7nrxmv.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:QsJVYqjFDzqPaKkUc+ic6EBUwxIJfTYZKGatSyI9IGatvJYNTFn
 aS+2mafKbOfZcL7RuaCL5UvNbyM+EpTSaLOFE9KENm9afKJTi3lFmY4BPOYIoA6yvO3rImQ
 1Eejbo1awVOYE7ZsBedQ+G75dU11K3P+wRGre/iO3nuc6gT7RPIyjp6ZhvP+/HMr574J1Xh
 0I7Rp3wcAJPVw677omvtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244771>

On 2014-03-21 23.32, Junio C Hamano wrote:
> Max Horn <max@quendi.de> writes:
>=20
>> Hi Torsten,
>>
>> On 21.03.2014, at 21:47, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>>
>>> On 2014-03-21 12.36, Max Horn wrote:
>>> All tests passed :-),
>>
>> Excellent.
>>
>>> thanks from my side.
>>> comments inline, some are debatable
>>
>> Thanks for having a close look and for the constructive feedback!
>> Unfortunately, I won't have time to look into this for the next 7 da=
ys
>> or so. I wouldn't mind if the patch gets queued with the changes you
>> suggest; but of course that might be a tad too much to ask for, so I=
'll
>> also be happy to do a "proper" re-roll, but then it has to wait a bi=
t.
>=20
> In the meantime, I'll pile this on top as "SQUASH???".

Test OK under Linux and Mac,
(so this is a little ACK).
