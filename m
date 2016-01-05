From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Add a test for subtree rebase that loses commits
Date: Tue, 5 Jan 2016 12:18:08 +0100
Message-ID: <568BA670.6070104@web.de>
References: <1451968805-6948-1-git-send-email-greened@obbligato.org>
 <1451968805-6948-2-git-send-email-greened@obbligato.org>
 <568B833B.4060001@web.de> <1451987857.2668.5.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 12:18:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGPd3-0007lO-9f
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 12:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbcAELSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 06:18:14 -0500
Received: from mout.web.de ([212.227.17.12]:50510 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbcAELSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 06:18:12 -0500
Received: from macce.local ([79.223.105.199]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lr2Zb-1ZkfVS3mnD-00ecbS; Tue, 05 Jan 2016 12:18:10
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <1451987857.2668.5.camel@kaarsemaker.net>
X-Provags-ID: V03:K0:GQ4PdmxnFI2NgUz0ED2jyFLE5iJ+AKr0cNfhbtaX/CojhQujZc4
 ND/doy8sXCFzM9OAoa8hAW4e7v3utq1kcO1JFdEZXbkIUll2pXtnh72frCslLQAtw1Iberu
 +oZyD4woffaCj/TpY9XgGVU+8Q98K9XbGiGOntP3tk02yzIWAUStLdZm5eIDL68ls9XajPj
 diljpfanQmGyLd9EThAbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+UQauzbwUeI=:xW9ZjWxERWDjiFznPlKCBG
 WxiHmtG66nNhqY3rtlcxBzmQ6a5n9nXvrSNqZAQKPl1AbmsE6UUqhQWtY5mlZHVB29bgZPhSr
 PYgeYJ/d3wy5U8LSgkRRVwEeYeaayq43WL7nyZT+JhFvFuwlH7URLQxtwLP7UpSJ163U67Iju
 fD/2KxiKlppV/JsFadu6zasLFLAEc5CJIi20tn1+YUhmNi2flGVdVMaALY2C3OibOASXeNhvv
 0PFkAXLn+F8GCq0+mJ2FQnIRgZveikowtH+fQW0BkFewJCq3yuoM6nwZ6IiEOc1VBPVj7nVfR
 BQqIe3xVc2/vx/aKP6xADzPFewIBdHSd501I1/QhkdtSszavd2ay2G5lcG+sEftIbV8IW4oZs
 PfNmy8TuHwb2dCcJWgqBhrSzqX+SJF/9M04/h2Ic5aLWGTxIoAMRWhKaGB7J7u3IakuIa/eJN
 xpV9ygjhtOW+h8HUuOBWEcbqmbsaZeJqyRXwCOk7TxHUYqyBK6M3d/oUn7AXAD3F/NVoWJML+
 hAqC4VVEDtLszPxie4o2ZFSfFWo8MUPwRPFjUnA3ASvcySkTnXB/1LKeXpBrq2QcaeAax65ld
 w+wZ7oaab+vPsGglF3q6ovRCcdzsJyS1Y59W8hjkwOUzS8bUe5myTcAqiNYgoKQVdI1BEn8wm
 ae7CToy4xe0bKYSdMfzb1C2X2oWAEpu723aMnZmYOnWuUpxJtnq9uoQmBe8Qcn4SFb9bjAx5g
 Km3IoLod6gZQgOw25yCFuBRnocu3aDv3aQcIG6fsypC91wlWgjV/og1ALJy584fxDaoIFk9n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283371>


On 2016-01-05 10.57, Dennis Kaarsemaker wrote:
> On di, 2016-01-05 at 09:47 +0100, Torsten B=C3=B6gershausen wrote:
>> Need to drop
>> David Greene <greened@obbligato.org>
>> from List, no MX record
>=20
> seahawk:~$ dig MX obbligato.org
> obbligato.org.		1800	IN	MX	10
> mail.obbligato.org.
> seahawk:~$ dig mail.obbligato.org
> mail.obbligato.org.	1800	IN	CNAME	obbligato
> .org.
> obbligato.org.		1800	IN	A	173.255.19
> 9.253
>=20
> So it has an MX record, it's just incorrect: MX records must not poin=
t
> to things that are CNAMEs.
>=20
This may be a problem from web.de:

An error occurred while sending mail. The mail server responded:
Requested action not taken: mailbox unavailable
invalid DNS MX or A/AAAA resource record.
Please check the message recipient "greened@obbligato.org" and try agai=
n.
