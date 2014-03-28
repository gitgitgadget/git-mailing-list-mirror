From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Fri, 28 Mar 2014 17:57:50 +0100
Message-ID: <5335AA0E.7000001@web.de>
References: <20140328030556.GD25485@odin.tremily.us> <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us> <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com> <20140328035255.GF25485@odin.tremily.us> <20140328035827.GG25485@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:58:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTa6U-0008Qv-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 17:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbaC1Q56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2014 12:57:58 -0400
Received: from mout.web.de ([212.227.17.12]:64007 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbaC1Q55 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 12:57:57 -0400
Received: from [192.168.178.41] ([84.132.146.169]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MMIdp-1WQ1KX0Nqf-007zdZ; Fri, 28 Mar 2014 17:57:52
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140328035827.GG25485@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:zhC7qkfunfo/Kh3sUooLwzumXYiFzZftA2YXsP8TRddpMOPkUs1
 Y3kMej8zr/HmiXgPNRla9wl6GZd7yS6RCMZjRoZSjqwppzU6JM0KEAMnYdrHtUCxVal4i2b
 4PFGr3P7QQnjY1Z5zWZT2vMMiId/d55TH8H+hd4TXHE+T8U36u0Tt+HyFHNJqV/hOVEW8Tw
 GZUsKcZzQbmVflAt7lldA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245395>

Am 28.03.2014 04:58, schrieb W. Trevor King:
> On Thu, Mar 27, 2014 at 08:52:55PM -0700, W. Trevor King wrote:
>> On Thu, Mar 27, 2014 at 11:43:47PM -0400, Eric Sunshine wrote:
>>> On Thu, Mar 27, 2014 at 11:36 PM, W. Trevor King <wking@tremily.us>=
 wrote:
>>>>  submodule.<name>.branch::
>>>>         A remote branch name for tracking updates in the upstream =
submodule.
>>>> -       If the option is not specified, it defaults to 'master'.  =
See the
>>>> -       `--remote` documentation in linkgit:git-submodule[1] for d=
etails.
>>>> +       If the option is not specified, it defaults to the subproj=
ect's
>>>
>>> Did you mean s/subproject/submodule/ ?
>>>
>>>> +       HEAD.  See the `--remote` documentation in linkgit:git-sub=
module[1]
>>>> +       for details.
>>
>> No the remote branch is in the upstream subproject.  I suppose I mea=
nt
>> =E2=80=9Cthe submodule's remote-tracking branch following the upstre=
am
>> subproject's HEAD which we just fetched so it's fairly current=E2=80=
=9D ;).
>=20
> Hmm, maybe we should change the existing =E2=80=9Cupstream submodule=E2=
=80=9D to
> =E2=80=9Cupstream subproject=E2=80=9D for consistency?

=46or me it's still an "upstream submodule" ...
