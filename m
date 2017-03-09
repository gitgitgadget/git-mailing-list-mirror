Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D8A1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 11:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbdCILLm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 06:11:42 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:58758 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbdCILL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 06:11:28 -0500
Date:   Thu, 09 Mar 2017 12:01:39 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <hpulcgxossrwvfbbcvcl@zndn>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1489057300;
        bh=a/IahyxvsmyOyT8tZV9WUrwT+NkFGPiOh8wOgHSokxE=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=aqHEE+DE6FS9IFrHlWFhGYXAFQEB+PXoPLCSG9KvWowNXR2ycg8AgXMTRpIPt6+kJ
         IwOTP2YDojyc/gZJJqr2PMQ3u9L/kSC+rfIdKY6p0qTJ1k+LFvf4pZnknIRH/DFTLm
         uqKDBoDLdwQrgahJcGTvxhb8UpqdmbwQTO1pDbjM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, I printed euids inside function calling getcwd().=20
Every single EUID is the same and have expected value. The same as any othe=
r local application run by this user. Permissions of every directory in the=
 path are OK.=20

/bin/pwd -P inside directory returned exact path and exited with exit statu=
s 0.





Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 18:38 =C5=9Aroda 2017-03-08
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 06.03.2017 um 17:10 schrieb Zenobiusz Kunegunda:
>> OS: FreeBSD 10.3-STABLE
>>
>> Story: I was trying to install openproject using this manual
>> https://www.openproject.org/open-source/download/manual-installation-gui=
de/
>>
>>  Everything was fine till command $ bundle install --deployment
>> --without postgres sqlite development test therubyracer docker
>>
>> works witg git version: 1.9.5 ( branch from repo ) does not work with
>> git version: 2.10 ( branch from from repo ) 2.11 ( both from FreeBSD
>> and from git repository) 2.12 ( branch from repo )
>>
>> On another server that passed but there was npm problem.
>>
>> This is error for $ bundle install --deployment --without postgres
>> sqlite development test therubyracer docker
>=20
> I suspect you might get better responses from the makers of bundler=20
> (http://bundler.io/, http://groups.google.com/group/ruby-bundler).
>=20
>> Fetching dependency metadata from https://rubygems.org/. fatal: Could
>> not get current working directory: Permission denied
>>
>> Retrying `git fetch --force --quiet --tags
>> "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/a=
wesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"`
>> due to error (2/4): Bundler::Source::Git::GitCommandError Git error:
>> command `git fetch --force --quiet --tags
>> "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/a=
wesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"`
>> in directory
>> /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome=
_nested_set-7bd473e845e2
>> has failed. If this error persists you could try removing the cache
>> directory
>> '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/a=
wesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7'fatal:
>> Could not get current working directory: Permission denied
>=20
> These long and repetitive messages make me feel dizzy.  So git fetch was=20
> executed in=20
> "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome=
_nested_set-7bd473e845e2"=20
> and reported that it was not allowed to get the current working=20
> directory, right?  That's odd.
>=20
> I suspect that older versions of git ignored the error, used an empty=20
> string and went with that instead of an absolute path, but that's just a=20
> guess.
>=20
> Was git perhaps started by bundler under a different user ID?  You could=20
> check that e.g. by printing the return value of geteuid(2).
>=20
> "/bin/pwd -P" executed in the same directory under the same user ID as=20
> git should error out and report "Permission denied" as well.  Are the=20
> permissions bits and ACLs for that directory and its parents OK?
>=20
> Thanks,
> Ren=C3=A9
>=20
>=20
=
