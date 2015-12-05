From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 8/8] update-index: make core.untrackedCache a bool
Date: Sat, 5 Dec 2015 13:44:28 +0100
Message-ID: <5662DC2C.8030009@web.de>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
 <1449001899-18956-9-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 13:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5CCz-0000Tq-MA
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 13:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbbLEMoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Dec 2015 07:44:55 -0500
Received: from mout.web.de ([212.227.15.14]:60826 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbbLEMoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 07:44:54 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MQ63n-1a9J4732PL-005HkZ; Sat, 05 Dec 2015 13:44:32
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1449001899-18956-9-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:mQBuxnynQO8UTZlh5JjO2xOQToA6DFg/dFf45KuoonKPyqjoDSR
 c9zS9F30fk0WRS0qbGCMhYJcrihnJAEIAh9zVExAyyZtVJPQ35W948jgw97YT58kI+wqsHJ
 8OqIbl1WwhitFcCbJnwuf20wo4o5zcSjBoElXRmary4FLHKXu8P3zGCXR+DnKnl/XYPbmol
 rxCqxc8XpbXTYWtcpDb1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fs3wvV1imD0=:iG7gLBlsyDxshEzYx1DHAW
 AKtoWOcgSqu7sHwxENK+7+/B3xNHeoO+fsIrKly7wG5kU/NKaVwZRzkDf+kcurqLPlUh27na4
 hG77I7ZrpBaug8bl4kdy2TP7CIPNFHqLjoMAt1e3B0u9X/HVrhFfLZHOxmYB3dtsat5aZhxrj
 g7QPQsrc2vjKzntEjiPQjkk0NEe2OYpjf6xfejrEQ6tGq9bF0qROTfEwxkn6QiR18yxFCQv9Z
 bhrjrbHB9UoxU/wYCtNrfpclwROk8BWG0wwJyfFoCpjjeCw3VVxewtWebaNEYiuLyaNiIhgAU
 dOhJF7gzmBS+BeowA4ZhCsNSlfKvyevYqBXE9pjeMlGYDePLwS8o+N9Hh6lV/KAH1wFxGZjwt
 kNO3L5X8O8LgCmy7qRd/PuIoM8rgcrhQ2BoMSMXGx7U0m/kAHibYUGsJvZGbSlQpRKOqwd0Fz
 Oi6F6FYipmDNtace0TLkqdp0/2Y319XZwYWk4WUF80T+CbrY7vABhk7TyyYKOdy61yfeWZtRm
 YYxD1e3exPvvDw1w5DFWFlKVJCkeYQ73156AHJdkJzcG3EfyRafuC6Q6yZ8PLDpUTvEP2ABJI
 FsamwhZvQrthH5JJr6KoRaIAwVB/Uh4ppTt6ePtXAGNGprmfy7egnMieMMiJFSewU4W6r/kBf
 Jy24AsShcqwxsy5xvcnGaaHk7yDtcCE3TO0hK7Uclk+2HRmuqMG6Y+j7MOJdlct1hjRPtXfT1
 JO50vDeQiRvq7NAKmRqwojZu6bHcts64E5UXAnHjRogoUVRjXrGfat2g6FWzMjBNSXHYJ63p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282034>

On 01.12.15 21:31, Christian Couder wrote:
> Most features in Git can be enabled or disabled using a simple
> bool config variable and it would be nice if untracked cache
> behaved the same way.
>=20
> This makes --[no-|force-]untracked-cache change the value of
> core.untrackedCache in the repo config file, to avoid making
> those options useless and because this avoids the untracked
> cache being disabled by a kernel change or a directory
> change. Of course this breaks some backward compatibility,
> but the simplification and increased useability is worth it.

Some loose thinking, how the core.untrackedcache and the
command line can work together:

core.untrackedcache =3D unset
  everything is as today
  if --test-untracked-cache is used on command line,
  the test is run, additionally the result is stored
  in the config variable core.untrackedcache

core.untrackedcache =3D true
  same as --force-untracked-cache
  if --no-untracked-cache is given on command line,
  this has higher priority

core.untrackedcache =3D false
  same as --no-untracked-cache
  if --force-untracked-cache is given on command line,
  this has higher priority

Does this support the workflow described by =C6var ?
