From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: Three dot notion used inconsitent?
Date: Wed, 18 Nov 2015 12:02:13 +0100
Message-ID: <20151118110213.GA24055@zorg.kyriasis.com>
References: <1CDF2D38-B73A-4C49-BC10-1F3BA1873733@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 12:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz0Vg-0003Jz-6P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 12:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbbKRLCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 06:02:35 -0500
Received: from theos.kyriasis.com ([212.71.254.33]:51842 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbbKRLCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 06:02:16 -0500
Received: from theos.kyriasis.com (localhost [127.0.0.1])
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id f40ef087;
	Wed, 18 Nov 2015 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=crajkjJvYLg4dwdR34KapS31F/c=; b=sjGpr/
	rfvMM0j5WTUjZ1LLSHIoUd5cA0t+TaeXx2XR2gxlqLsk1A+KXYBRGj9CP1MAFyS6
	SMqR8EobIb6KTTXGfFHnx2ad6UFIk4rgvIhq+ui4pQtsrEXBrWtZCBE9yxygGohU
	M0yw+xs9in8FqmXKLQZzVNrKpbTEEI9i9LDRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=YPsfv1zBib5khqFqq14xFRrnlXUYgLAU
	Hx/MNIjIqkDmnaDnmEUP37lp2MipS/QHMo+7EFt1qHP5vWNXM+7/PLC6LpgxFmpt
	MqcaUfI3YAb6yVU2VU3pt49XWQN6LhWH/F/VmRlZTxdMeDonaSz4GGm0SJo375ub
	0fscfjNnrA4=
Received: from zorg.kyriasis.com (c80-217-51-233.bredband.comhem.se [80.217.51.233])
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 132ff06e
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Wed, 18 Nov 2015 11:02:14 +0000 (UTC)
Mail-Followup-To: Lars Schneider <larsxschneider@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1CDF2D38-B73A-4C49-BC10-1F3BA1873733@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281447>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18/11, Lars Schneider wrote:
>git diff branchA...branchB
>--> gives me the diff between (the common ancestor of A and B) and B. That=
 means I never see changes on branchA.
>
>git log branchA...branchB
>--> gives me the commits reachable from A and B. That includes changes fro=
m branchA.
>
>Is this because of a design decision that I do not (yet) understand or is =
this inconsistent for historical reasons?
>

The standard meaning of A...B is all the commits reachable from A or B,=20
but not from both. (See gitrevisions(7) for more info.)

git-diff has its own nonstandard definition, where A...B is defined as=20
all the commits from a comman ancestor of A and B, up to B.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQRQBAABCgA6BQJWTFqyMxSAAAAAABUAFXBrYS1hZGRyZXNzQGdudXBnLm9yZ2pv
aGFubmVzQGt5cmlhc2lzLmNvbQAKCRCQHBwyDrDUXa+uIACC7DxeeUs/Ym7tLCOB
inTCmNJMrRFmxMfinYWq5iMNcgjZlsIkPU2kAms2uHdvax8D05IYEMqJH0ktZrtX
uZ2tFiIPsIsnujtF5Xup1Ialoty8uyPKhgqifKt0153JgwydylWv5m2MfnNusru3
UbD44ecuZEt4uBa9xINlHqo5RTvLGUUaTnLoBn/3ImZ5V2HQvAmhmH+6qyFwHs/Q
FbBPzH7vaSKECCaGFqnn5nfbcMNXiP26ez5k/Q7BHJwrL7fcyii5hCdvwUS6PutI
24rbUwlBgmcEjj+OC10a9Bz6NC7wU5ZnRzvv5ZtP3Wgxa//vzeVgZz5wuspLmKmn
DWeE8n+9RpzrhVBuuX8yBeqxF1B0gTcX02h4DQvgvZp8ykBpL9WO/qP7J73dfgo9
4iC7keOPDj8q0P1kVLmNs0Dh2ncslo/d/4h7iiX0WpChhpkK/IZbxDOhR89yZWz7
pieMzMXgTWBDAQ7xvOzJOmR1yjV7W5T+AZxhN9XWj7naU9YS/zS4SLj8sJChJIFr
iqJ0sQrQameZxCIn0HWQvDpSLjqVPGm878NSqNtoCMXK2vkMTFUB9IJ/YJ49BT9F
EsiXCIB12yedOwLgYmeqh8VqOaLCMV48+gOiV4QXGZxvQIOortUyIsWsgKIxoKOX
y0QT/ZG0f314oszu+jXaNJM05W+NertSSsCUDQY46lAkVB5J7IwQwlZoUO7Yk4Ii
ldeldM437tPBFGgZv6lGYA9igmWll6uisPD4epW4Ui5LELF14Wzk3lgOEHE5/sgn
8CAkz7I/3na/pyj/8FrURjBuRlbs6eQ7ETNTIdzb8/e//qtH5RrGaCY1VYDouC8x
jmH5orirO368YSn3cjM88ieco1kk6EcJ9XhdGdtdpOc670hMeZqDRBOXZKqTnU8S
BhYkv8NgDZKEc3f3EnuPHGYloMWhzJNvXoZXLpH+IBBhfshtg5m/AmgCGPLJKH5v
byhGufphev7AqA47u75mPsWmSDlvcUTWRxUe4xcUAqnTxczUOaL3Db395+AHB0dQ
PcOQG0V5jiIMa04Wae43uu8XUGL3wk9w5pQOMUXfhI4JnhPPgytVeAXihEsHpYLO
JtWiRKQKLUf7YOdK1NkmKeuDPne1pNi024tf9FKi1QDjpMxFgHI0d35nzQZqjDIf
lXC5XxbBEhj3tFElDjohF3oVVufczduUaUJywZ8l7BGU5q68C9YirfHXMbXB1mVn
rgUoHHaXGFz68ZHClg6hr85urXlm0Qa81EWIyP4r7Rx98S6fDahPgfNFatgtDLfp
le0qNMeLp91HXNTZDPBPb3vs8lFjSd3Sk3V1/pO9dukZIdKc5KaydPSfVAGQZnji
Dv1j
=WItj
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
