From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t9902 fails
Date: Sat, 19 Jan 2013 06:38:54 +0100
Message-ID: <50FA316E.8060807@web.de>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <7v8v7qsagd.fsf@alter.siamese.dyndns.org> <7vmww6qmck.fsf@alter.siamese.dyndns.org> <201301182323.55378.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQQ==?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 06:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwRAq-0004R6-Pv
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 06:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab3ASFjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 00:39:24 -0500
Received: from mout.web.de ([212.227.17.12]:64804 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab3ASFjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 00:39:23 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MOSAP-1TtOjy3oxR-006SWS; Sat, 19 Jan 2013 06:38:56
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <201301182323.55378.avila.jn@gmail.com>
X-Provags-ID: V02:K0:zb1lIF91CAevBH/96tql4r+33ykXjgIZ1ksPop2harQ
 vJBtjCw0FlR13a7gmXw2GkpFYn3TIGj1XpqFdhdA8S3mV7Y/x+
 dEmnASzZtpxFQxctIdxO9vIPwf3LA1kU9ifKOVOBGvOEuOoezv
 6ato8lzFhNvBirtdqdcGo5r3DjB7+3EI7LO47dzS6JtFAewVEc
 TNWSHIzwLCTXFAj7+yPXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213954>

On 18.01.13 23:23, Jean-No=C3=ABl AVILA wrote:
> Le vendredi 18 janvier 2013 21:15:23, Junio C Hamano a =C3=A9crit :
>> Junio C Hamano <gitster@pobox.com> writes:
>>> How about doing something like this and set that variable in the
>>> test instead?  If STD_ONLY is not set, you will get everything, but
>>> when STD_ONLY is set, we will stop reading from "help -a" when it
>>> starts listing additional stuff.
>=20
> I tried both of your propositions but none made test 10 of t9902 pass=
=2E
>=20
> Am I supposed to run "make install" before running the test?

No. The test suite could (and should) be run before you make install.
So a typical sequence could be:
Run test suite, and if that passes, install the binaries on my system.
This could look like this on the command line:
make test && sudo make install

Jean-No=C3=ABl,
would it be possible to run
"git status"
and share the result with us?

And did you try Jonathans patch?

/Torsten
