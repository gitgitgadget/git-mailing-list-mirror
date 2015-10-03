From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Sat, 3 Oct 2015 23:12:13 +0200
Message-ID: <561044AD.8010803@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net> <560F6E98.8030305@web.de>
 <xmqqtwq73nbj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 03 23:12:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiU6S-0007HH-UP
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 23:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbbJCVMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2015 17:12:21 -0400
Received: from mout.web.de ([212.227.15.4]:52362 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbbJCVMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 17:12:20 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MVGow-1a8K2b2uB4-00Yeir; Sat, 03 Oct 2015 23:12:15
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <xmqqtwq73nbj.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:OXel9b5mlPy3tcwNpx/fNarLQNfz3SDzUxSH0pUAxtcS0Yc3fRf
 2S2wMtYI3QAsNloUikv3nIOZvyJXmHFfUQFOMjbkQg6G/fty/Hp1KUtp38PfBzAVRZSbnFy
 eo4j934gZ3fFmpC+OFcTX2O8YLGlnefAdhqVbMxMixY4TwDAati9C0WZrz3Bv8jzKFaPy5k
 rvc/m4VBMGeMtEBBM4wHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tXLkiKfl8Jo=:eBd0THcCVfQjdddDPvzcoJ
 5sOdct5MTU8QSKjnyNcVZD4ZJzDrwqT4kX4/QFc2Y+jj/xZ1lHKEcr01GsQLYwD2n5jYJEdxg
 bSaGJuPygZtxvsexxUnLrivILbhomjCiuy72cs3pT0VKIvASf6pQa5Gzaa5tatiz8T/N/u584
 ssql/uFOaeMVi3HUWvue7tgUkmzKo9arWKr52G2t3QinQM0puJDSWFnY7YeEcD086lKqZ0nrc
 eHklrO46PfYR5TruMV20dBSWvkEDLM4vs4RI9eDG/6EKNd6RXT1GCi9QEO5BoXv9VCivkf14x
 2YeqV3NwJuIjAjz6l+2GcfEoAYQqkZMI2cGRjSHPmnUJAfgxQKFqwpHgrntYGTX/ADjbSu0tV
 T9NpAwxRh/sPqJP9aCu7nKiFv4k9Abwtet3UACO6/QnJBEws2KdWsGffDBX1aFph9wIhCdCqT
 IyRszMifMDNXQUdX6BIAE4WjDWhue3DicTQkAIIuXCwFuZlj7h76Db7oRcc44jCwtHWFKUFEX
 hgN2f2qJSwzidgIlEeHPkmtB7DTGomqpTjC0TbkzsocSs7icMpUr/GPzSw5GxfrG25LiQtNDc
 KEXV88hRjNWyYNERxdduEtpuSKjeC/S7oPPpTh6mYfefBtUM2uq/IsWqy9PGIsMUZC75Fnt2y
 umO09ArVBU0XDUCYDiTNo1uADPEHKcObYuuGpq6jqnu+S1y31+jmhK1/S4bDa9QOpVZiWrMVp
 wXmHoFQTWZXaoitYxZB3JRfI9A3W4UEXaZxQh1iGuiJZhe1eEgQXMfi6Fq0C2X27qUVPTrfY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278986>

On 03.10.15 18:54, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> On 30.09.15 02:23, Jeff King wrote:
>>> On Tue, Sep 29, 2015 at 04:50:39PM -0700, Michael Blume wrote:
>>>
>>>> I see compile errors on my mac:
>>>>
>>
>> This is my attempt, passing the test, but not fully polished.
>=20
> Thanks.
>=20
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 89f2c05..60b559c 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -276,7 +276,9 @@ static int create_default_files(const char *temp=
late_path)
>>  		path =3D git_path_buf(&buf, "CoNfIg");
>>  		if (!access(path, F_OK))
>>  			git_config_set("core.ignorecase", "true");
>> -		probe_utf8_pathname_composition(path);
>> +		/* Probe utf-8 normalization withou mangling CoNfIG */
>> +		path =3D git_path_buf(&buf, "config");
>> +		probe_utf8_pathname_composition(path, strlen(path));
>=20
> Hmph, Peff's quick-fix passed the original "CoNfIg" in &buf directly
> to probe_utf8_pathname_composition() without changing its signature.
True, ( I was thinking that the test did only work on case insensitive =
=46S).
We can skip that change.

Beside that, I later realized, that a better signature could be:
+void probe_utf8_pathname_composition(const char *path, size_t len)

I can send a proper patch the next days.
