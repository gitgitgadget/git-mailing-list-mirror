From: "Vincent B." <vb@luminar.eu.org>
Subject: Re: Unable to clone a repo over an IPv6 link local address: port
 got trimmed to 4 chars
Date: Tue, 24 Jun 2014 15:19:10 +0200
Message-ID: <53A97ACE.8040405@luminar.eu.org>
References: <53A9735E.8080604@luminar.eu.org> <53A97A08.2020304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 15:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzQd3-0001HS-0t
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 15:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaFXNTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2014 09:19:13 -0400
Received: from luminar.eu.org ([94.23.24.152]:34092 "EHLO luminar.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbaFXNTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 09:19:13 -0400
Received: from [192.168.1.105] (AMontsouris-652-1-53-131.w92-163.abo.wanadoo.fr [92.163.36.131])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by luminar.eu.org (Postfix) with ESMTPSA id 962066040C;
	Tue, 24 Jun 2014 15:19:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A97A08.2020304@web.de>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252408>

On 24/06/2014 15:15, Torsten B=C3=B6gershausen wrote:
> Which OS are you using ?
>=20
> what does
> git --version
> give?
>=20
> And what does this do ?
>=20
> GIT_CURL_VERBOSE=3D1 LANG=3DC git clone "http://[fe80::226:c6ff:fe50:=
efa0%wlan0]:33075/repo"
>=20

My mistake, actually:

As per RFC6874, IPv6 URI with zones have to be encoded [::%25zone] and =
not [::%zone]. It is working now.

Thanks,

Vincent
