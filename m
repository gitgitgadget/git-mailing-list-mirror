From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: 'eol' documentation confusion
Date: Thu, 25 Jun 2015 17:31:27 +0200
Message-ID: <558C1ECF.1030801@web.de>
References: <CAHd499CapqvC3pHszgmX2VexdmqiW4+N23YfkAP5jjXWDrbe0A@mail.gmail.com>
 <CAHd499Do_bpdOkL2TqdO+8L=pR53117pKR0GSwdgvFDwq_S4=w@mail.gmail.com>
 <5587AAB2.80305@web.de> <xmqqr3p3iuyc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 17:32:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z898Z-0007NV-RI
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 17:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbbFYPcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2015 11:32:19 -0400
Received: from mout.web.de ([212.227.17.12]:58474 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbbFYPbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 11:31:37 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MhDYL-1ZUTKP3J0T-00MM7H; Thu, 25 Jun 2015 17:31:32
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <xmqqr3p3iuyc.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:vApieHV6sslhGow7OX5nBauV5hy2SeAYIMxdWogsDQMZznm+Rq1
 xb9v2km6tfvbpUBhOqubu/Gkw8kMveWmmbAJfit9MVzLYR0YzIJRWq4Lsx5+h7LeBYBdRx1
 uW60SBFC+SA2A1LV9G6+C/XFRM7++gsRMxO95UYwKXtxj8I92n5bIvxczWaff71UriBmABD
 ezwYOoZvGVC22rqLT8Lvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oaJseNCA2e0=:ynknlrbP3wqpoBE4TAiLaA
 WkKfL4vMTQRbarpr6/wlRI+BQNSdrlnn+JV8Hj3L4g/ClU8viL+qZ0oTUd+rRvc1XVrPWFhng
 V4HgwSl85w4NVWqC7GZObO38AuOkyXxnT2eCcCaYSD7Yt/PXrqZgzBM434ReY4tBsjQ/egPGg
 DDoArpNQnU9FEefidSIV/2F5r0rfkI15/cFcc/6WDrYqmVzhv8aRgvjYLw9t1u6jCvCay18do
 ++aHvITCkI7K1/4K6LDWgbv9YcyaDcsA/gq0eJy7Vp4u6c/nDaqFPJz2fPHzwMDFcTP9h6UNy
 u2w4F4LSPQWP7ovZfK/PxC1rbzeiUekKufVQI5KXabDw7IqtQTjHTxyzdA2WtGEph0TUp4dxy
 5txyEoxYfL7YDpWzaA2d//ffYUP8NJGcesWelxx2AtfGzynY5lVhpR/F/i15yIPJoyWBnNz4N
 2He4vFojg4cawQScnK7Wk+aTNTQ35OxpnrvY/xBi/194liKO8taZVVo0w7XDFxOehmGkOwNWh
 iIn2O37Qg/6zu8KyufD1u/QXocoSce58xpYcGG3jhAoR60R32p6GE+roc2iG+pIdIw3f0LHA5
 UWM9oQ1iMqnjzA3za5H3r3teI0pQqKq1vtLSRqXMbaQ8OEybgecEExjpmiuSH8hs95TgxdG7m
 yrpdqetwpC2pSVvEzSSKD6SnMGeE0VQYk3qML59SCbGuWmFKckUdnX8itQhGYu+M5IDw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272688>

On 2015-06-22 18.11, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> eol=3Dlf or eol=3Dcrlf are the only useful settings.
>> Everything else is ignored because it does not make sense.
>>
>> See convert.c:
>> static enum eol git_path_check_eol()
>=20
> That makes me wonder...
>=20
> The original reasoning behind the current behaviour that we ignore
> unknown values given to configuration variables and attributes is so
> that people can use the same file that has values that are
> understood by newer versions of Git with older versions of Git.
>=20
> You may be trying the eol=3DcleverLF setting introduced in Git versio=
n
> 47-prerelease by adding it to .git/info/attributes, and may have
> found it useful.  But you may also have to use the same repository
> on another machine that you didn't install that future version of
> Git over the network filesystem.  Barfing and not proceeding when we
> see unknown eol=3DcleverLF does not sound like a nice thing to do,
> which is why we just ignore and behave as if the setting was not
> there.
>=20
> Ideally, however, I think we should ignore an unknown setting as
> long as it does not matter (i.e. we do not come to the codepath that
> wants to know eol settings for the path, e.g. running "git log" to
> show only the commit log messages and the topology of the history),
> but we should error out when the unknown setting possibly matters
> (i.e. we do need the eol setting for the path in order to correctly
> convert the contents to end-user's liking).
>=20
> Thoughts (and patches ;-)?
In short:
Good idea, patches follow within the next weeks/months
