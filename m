From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Tue, 01 Dec 2015 06:57:05 +0100
Message-ID: <565D36B1.9050104@web.de>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>	<CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>	<CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>	<CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com>	<CACsJy8CNRbvsDY+ucFZGcO4+tE9Ud_QNr1k4D=+utawSCrc+Sg@mail.gmail.com>	<CACBZZX4jJ_b-5sbor6YibXGASeOa0gx8nEBiv8=54yoHfWL8Fw@mail.gmail.com> <xmqq610j8fzt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBC?= =?UTF-8?B?amFybWFzb24=?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 06:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3dxP-0006Fo-W6
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 06:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbbLAF61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 00:58:27 -0500
Received: from mout.web.de ([212.227.15.4]:57744 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbbLAF60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 00:58:26 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Me6Va-1Zewqr1eFa-00PtLP; Tue, 01 Dec 2015 06:57:47
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq610j8fzt.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:nK9auXW7QOMR9k96jxkuSdqXi+ZQzBUePqaIceGv5IQgry5OVHh
 fL/GxDu2ag3NRjjbE/W3xB2rXx/Rz5feQ/JAhAb9RzVCrqfFJTDvQL7ul6Yi2oERNU5XrjI
 WMEoIRbAy7fRLwqStdQ5QMVSrc2vNQwdaxXKqUUIrGa/6K8PHS5yLgippgARJlbebaAbOh9
 PQSAl9LPeCwQkr20LSsOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qF3r+EaNuBM=:nR1VwaoWX3OMoTPImUBc2X
 GmynKE3l0JJ2F5PXsGrA0wpwGYccjPExnYw3VOXLYlpP/iIn7LOA4EPp4H4RDUek0fZoiMZux
 af3dXMsAGmDHe0JhbAeNyAJVU8eIKImfM96LkZsc7dT7vLBUycIOMBnBNVUd0IAFhd5VfMRKs
 KMYC7zoiHEp99AB/pLKA6iHMUCk5D8T8AI1dmeqJBBzhoWnsk6w8x1IAjN9IEzKarPhvCbZN5
 LAlR29ChEluKeZ7H9gZv7JF2Ln6IuAPTrF8QXZuDX1+NSk8Pq149jBuQhZMggYtsyY57n7I1C
 A+8TTM8NHcazuVN5J45ASsB+Y3sk/33jmxoV0IXcsv6PLZVQ79SJ9vY8mZpe8W0mmcR9z5uCa
 Pd3lgu62v+w+w8NXKlZAhhfJIO/w+lIQ+xoaB1eVCKbQg95mhSkxpWS6lgb4qWRmCTyexb/3V
 x/lmAFlwh2VSANmYE0IPYXul4S4UvApUc9582sNhwpDI0wcTzu/dq+fFX2xOX4wtv33hnTxOV
 k3THSCzv+2ISiqElQGPq0i+jJ127b1MSLDciFzUoo+EwhZeMO4MwDHl20DDFpFXZNopSf2R1U
 l2ySm83+/bCC15TJb/OKogrNQdC468MxCpzNVLf1bPiBOTtmG9q+WklPwgpFhLLjc8YMM4la3
 bqQEt0T7QqqTAUhIauSJWBKQ7aETXKWdj/YEDlJcxIN/207WF+Cii0LKVHG2NJTTaUxI6MgyP
 52AZC5qC3JsTB9m1MUDZ2YuxIaXUSct+BfdTCir4WUZqCjpte3UESf+Vi2yo51chiKFeDxUd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281831>

On 11/30/2015 08:05 PM, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Maybe I'm missing some really common breakage with st_mtime on some
>> system, but having a feature the user explicitly enables turn itself
>> off and doing FS-testing that takes 10 seconds when it's enabled see=
ms
>> like the wrong default to me.
>>
>> We don't do it with core.fileMode, core.ignorecase or core.trustctim=
e
>> or core.symlinks. Do we really need to be treating this differently?
> I share the exact thought.  I was looking the other way when
> untracked-cache was done originally ;-), and I would also want to
> know the answers to the above questions.
Maybe somewhat off topic, but:

Create a repo under Linux:
Linux will probe the FS and will set
core.filemode true
core.ignorecase false.

Export it using SAMBA to Windows or Mac OS X.
In some magical way the mounted repo becomes case-insensitive under
both Mac and Windows, even if core.ignorecase is true in the config fil=
e.

Same for filemode:
(Git for Windows doesn't see the execute bit at all, but relies on=20
core.filemode anyway)
Depending how the repo is mounted on the Mac, the execute bits may work=
,=20
be always 0 or always 1.

Relying on this kind of config files is not ideal in a networked=20
environment.
It is not ideal when different implementations of Git access the same r=
epo,
(Git for Windows vs cygwin vs Egit/Jgit)

So I think that the original patch could make Git unreliable under some=
=20
circumstances.

And some day I may send a patch which does a quick auto-probe for=20
filemode and ignorecase,
to adjust Git to what the underlying "local OS - network - remote OS -=20
remote FS" really achieves.
