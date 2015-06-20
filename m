From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 20 Jun 2015 20:13:48 +0200
Message-ID: <20150620181348.GA28776@leeloo.kyriasis.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
 <1434147436-21272-1-git-send-email-johannes@kyriasis.com>
 <20150612223223.GA22677@leeloo.kyriasis.com>
 <xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
 <20150620142705.GA23163@leeloo.kyriasis.com>
 <xmqqr3p6jltx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 20:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6NHP-0004p0-4m
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 20:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbbFTSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 14:13:54 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:41571 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbFTSNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 14:13:52 -0400
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id b80c91c6;
	for <git@vger.kernel.org>;
	Sat, 20 Jun 2015 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=pAZw3gSRZ2XQl2Jl3exLQPBtRFg=; b=G3AhY7
	LKG3RlrXWM/STHt7pJAUa0ueDf0xn75BXMpOEM6z8kOU+raCEolunO8yMp2o2R8t
	HFabzN+BebYPKZqGxDn19cVK6hCmbV9DcxY1/t9zSRKPcIidSg6LrxsGKPw4Jw8N
	TBCrvUPCgCBHw0t0jSsymEVP2m+cFhlG3CP3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=TlYWH1qHN683OGyksamqvbRT1+QNofmx
	suw1MZRBgCB/a783NuLJZ4xplmWZrbxenywJnTPNI3GiPd4LARZlFy+pgSNy5fLT
	hPV+0bRUEvuQLNLvvebCVCgCJ5CBLO2y9KLLK4KzOqdn8vIAe6L7hNzYnJgeHSNf
	iljAOqWLPUk=
Received: from leeloo.kyriasis.com (h45n5-tb-a13.ias.bredband.telia.com [81.234.145.45]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id d5f0d82e;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sat, 20 Jun 2015 18:13:50 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqr3p6jltx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272238>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20/06, Junio C Hamano wrote:
>Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:
>
>> On 15/06, Junio C Hamano wrote:
>>>You would probably want new tests, but more importantly did you make
>>>sure this passes existing tests?  It seems to break 5509 (there
>>>could be others) at least for me.
>>>
>>
>> It breaks 5509 currently yeah, though I've already fixed it locally.
>>
>> Anyway,
>>
>> You create a namespace by pushing to it,...
>
>You keep repeating that, but I do not think we agreed that it is the
>supported or correct procedure to set up a new namespace in the
>first place.

Whether it's 'correct' I can't say, but it's the only currently=20
supported way.

>Doesn't the server side need a lot more than just
>setting up HEAD symref (like running upload/receive-pack with the
>path to the hierarchy exported as GIT_NAMESPACE environment)?

All it needs to do is use the refs under the ref namespace, and that it=20
has already done for a long time. (Since 2011 in fact.)

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVha1ZAAoJEJAcHDIOsNRdnRgf/2h1Bd509o00leU0Ihuh770V
elXKxaETM7FE0V92Hh1TMzMDfTnmWlLs/TjVfesS9hU8YbnWbh2mQQG9oAbxyEIr
lD+DtztnV8X5HjCDWncC3Pp3+ZbzXEXg7/al/6/GnXgwVoJRy9vT1W4xfTpXdh0E
EwCByhKRsE2OPfjbI3AWQ6xPB8+H0z8VC5hzPwhlVzCM8NpOQtBczzSEt9zUZpYz
GxnxE24pB16zIhL6/r3K6BoeaGOkvHrMGMS7TGv+LHIgQXdPR13OPWhxa9IOX5zk
lLb636gOTLcEDEbSCOJVIYH01peqpvcAfssIgWd6iP+RY9wlj8AQc07dVic/AqtG
q/QmQGdHxRue1vNHd0QDAAMDA7I2YOR9bjNFdrTCRDXOnxmNgspwlCWZuqvDOL8/
P865+9kofcBk2xgBantXQas47YV0zQMqmlUX1FSOfQdkWjt9Ngu9nOrPxk9L66hS
LcQP9Y9mcx71RllSxwzWSmW18Eo2EaHzlWtqsQtBS/Gy3qkV8YNXI7YsKABM7DWm
2P2kiKUAkaDRCxdipRCpK+Vt66yehGbffK6SiBvfDpM+GTSZt1pjAhFxhe3WbU5V
DrNrGNcjnOG7D1HjUmjvWXO0QY/NWP/aHOLBYMiwn0NoyIpMDPeDrrVZX10QRR2k
+nA34kkHxOANOVk+2wt/tOpZXVYDPVOUqTi2CHVW6LZMWcsv/4GtpCUiliWs2/07
3RGl4b82vesjzvP3gMLrzUN2FRAs4i1wa+3/1Ae/FZbcj/2P1ssPcZG8Ho4lt2/W
Mk2O13XgpIlbejRiCFw6fBEfc/qkmXF+eXxTir3rTZpt89LW2Jg6L421pfcAQRNf
/0IeJ+5yZ91EYMGvrRMXXGcumZvKyvvUsaEdjABFVn/9xOpwGiNvffC05f4qdaQ5
Xoiq9A6yanGggkEwoTWPhNL9k9zgpH/YF7O5n2yed5U0Cxv+Q5RQtfPgqIOxhBwk
cwYV2R93cAmKzwFH2weEXtlq+AI7yZRFsOs12A/xkpniP9kVk2wuGGpCEAYC9lSQ
JkiZA5EJDbt1eIvf/tCwj5obmgn9VfQH1Wbxn9iVT58jsL106naPqQZaaOKEJ0Ah
doVfbXm4drWRc/a4+nnLGLOiO4zxN1QIp7TUGZdy+IsdAJMXW8DsIVZCLsOVwJg/
TkhighDgLdaDvlwUlhton7kQ0hw/7aFcz/uQN7u8cx2kgTiW6VvnKSoGkj6ljGTe
yBhraA52Vp7WjyGyV844D9uHLFsbyA6tfXcN96ehtL1dj8MFVmaXKVn9QzO10n/s
/p5ldDhcF1hrlHYhGMvI1qI2wvx45PPAgEbnVQqDOt6aFg0L8ORnYEf+tow+EHg=
=CWTJ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
