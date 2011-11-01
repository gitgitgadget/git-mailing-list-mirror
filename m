From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Tue, 01 Nov 2011 10:53:14 +0100
Message-ID: <4EAFC18A.1070502@atlas-elektronik.com>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org> <4EAEAE13.50101@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Nov 01 10:53:15 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLB1u-00054n-Fi
	for glk-linux-kernel-3@lo.gmane.org; Tue, 01 Nov 2011 10:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab1KAJxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 1 Nov 2011 05:53:05 -0400
Received: from mail96.atlas.de ([194.156.172.86]:29993 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab1KAJxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2011 05:53:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 6F93E100BF;
	Tue,  1 Nov 2011 10:53:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id 7X6j3VrG-AzW; Tue,  1 Nov 2011 10:53:01 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue,  1 Nov 2011 10:53:00 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id BD3932717B;
	Tue,  1 Nov 2011 10:53:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EAEAE13.50101@atlas-elektronik.com>
X-Enigmail-Version: 1.3.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184562>

Am 31.10.2011 15:17, schrieb Stefan N=C3=A4we:
> Am 31.10.2011 06:00, schrieb Junio C Hamano:
>> A release candidate Git 1.7.8.rc0 is available for testing.
>>
>> [...]
>>
>>
>> Git v1.7.8 Release Notes (draft)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Updates since v1.7.7
>> --------------------
>>
>> [...]
>>
>>  * HTTP transport did not use pushurl correctly, and also did not te=
ll
>>    what host it is trying to authenticate with when asking for
>>    credentials.
>>    (merge deba493 jk/http-auth later to maint).
>=20
> This seems to break pushing with https for me.
> It never uses values from my '~/.netrc'.
> I'll come up with a detailed scenario later.

Update:

git push prompts for the password but just pressing return succeeds.

Weird...


Stefan
--=20
----------------------------------------------------------------
/dev/random says: Budget: A method for going broke methodically.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
