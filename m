Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1772047F
	for <e@80x24.org>; Thu, 28 Sep 2017 05:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdI1FEB (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 01:04:01 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:48632 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdI1FD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 01:03:59 -0400
Received: by mail-wr0-f175.google.com with SMTP id 108so572125wra.5
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=HRpNTlfUjHVU1aV1+xkeHrEM1t9rjaxouCA1BnHwhSk=;
        b=d2hJySYhBTBPndoeIVKaR1Bp2GSGYSrIE+7Ot+5x1+80dgRiNc3N5StXUmzUqmLiQM
         FH+uWOYTDkJ3JMZP9685wmE1CP9nIqq6HBwI4eupunkUfHYILZ+SGHXMGhI2ouYLYf/+
         pIULaoKyL1IoVAxZu8cmHenv2UwrC3xIZeknoYfjMBk3J/6nHC/FLceUgFj/Uqo+pl2i
         Af1q8EbT0wLUBjPTMRLKGj39DANZJ+GxOGk7QBVrMY4MvazklGRXpFqgUyq5w6LW6m+w
         Ej6wvw+ytMO8hhwebv4ChQ72ono6CpGD6ATS0Y5SHe7ws3UoZ2RtYPflOpIssSHy+RZq
         Bhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=HRpNTlfUjHVU1aV1+xkeHrEM1t9rjaxouCA1BnHwhSk=;
        b=L5DH+c33uYK/ilksPmd9uxEL8PdYJ3FAkPQWo+I1dgVb6yxKotx1HAjZ85WbCbz4OF
         ylnvAjYVdiSMIub47qCbbUNfZZHgcekcvSa+exw8P046qaXXsCEUGInoPOODH5hmuhlE
         bR50C8xrlsQVdX3LN3f7Qc5O13XZvYY7N2pFv0rEW5KnBdCYnaZ2xpXk5JDyrWHYxNCx
         phtCWad6n5Hes/Kqjq8oYb/QK5MpqDzw3fpgNp3AnZgLOQeIFlQCa+NR2qqV4kiHDiN6
         kuV2/rYGXtOvAgenXJslj6c8UVvuHCbw854GHm6pTqSDRUC1UKb3Zs3TIPeQ0yOoKsVz
         5nGQ==
X-Gm-Message-State: AHPjjUiNYQBbFKp7tLwSt9/clHESwavjNPOLj4B5F/4f+g1w8Xla9UsU
        oR1Obe83KIImdN9sCSDL09lcx1d7
X-Google-Smtp-Source: AOwi7QA/XpnDkqGBIkI021QIYjdWlKrcuT4+1YYaJGFMi+7EAGQILKYKnhb+aHOSMprbaFF5FdWo6Q==
X-Received: by 10.223.161.194 with SMTP id v2mr3254834wrv.45.1506575038197;
        Wed, 27 Sep 2017 22:03:58 -0700 (PDT)
Received: from [192.168.1.100] (p57bfaa82.dip0.t-ipconnect.de. [87.191.170.130])
        by smtp.gmail.com with ESMTPSA id w2sm759255wrb.67.2017.09.27.22.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 22:03:57 -0700 (PDT)
From:   Toni Uebernickel <tuebernickel@gmail.com>
Message-Id: <21387D23-F581-4179-969E-823FEF82C405@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7ECC67FB-1E89-43D6-8375-ADFEB27E4A11";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Date:   Thu, 28 Sep 2017 07:03:55 +0200
In-Reply-To: <20170927195310.GF19555@aiede.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
 <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
 <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
 <20170927195159.GE19555@aiede.mtv.corp.google.com>
 <20170927195310.GF19555@aiede.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_7ECC67FB-1E89-43D6-8375-ADFEB27E4A11
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Jonathan,

my configuration reads as follows, I only removed private tokens =
content.
I will try to get more details on which version exactly breaks the =
command.

Kind Regards,
Toni

core.excludesfile=3D/usr/local/etc/gitignore
=
core.whitespace=3Dtrailing-space,space-before-tab,-indent-with-non-tab,tab=
-in-indent,tabwidth=3D2
core.autocrlf=3Dinput
core.ignorecase=3Dtrue
gpg.program=3Dgpg2
credential.helper=3Dosxkeychain
diff.patience=3Dtrue
diff.algorithm=3Dpatience
diff.compactionheuristic=3Dtrue
notes.displayref=3Drefs/notes/*
advice.detachedhead=3Dfalse
pull.rebase=3Dpreserve
push.default=3Dupstream
merge.ff=3Dfalse
merge.summary=3Dtrue
merge.log=3Dfalse
rerere.enabled=3Dtrue
rebase.autosquash=3Dtrue
rebase.autostash=3Dtrue
stash.showpatch=3Dtrue
branch.autosetuprebase=3Dalways
color.ui=3Dalways
color.branch.current=3Dyellow reverse
color.branch.local=3Dyellow
color.branch.remote=3Dgreen
color.diff.meta=3Dyellow
color.diff.func=3Dcyan bold
color.diff.frag=3Dmagenta
color.diff.old=3Dred
color.diff.new=3Dgreen
color.diff.whitespace=3Dred reverse
color.status.added=3Dgreen
color.status.changed=3Dyellow
color.status.untracked=3Dcyan
color.status.nobranch=3Dred
pretty.changelog=3Dformat:* %h %s
pretty.public-changelog=3Dformat:* %s
pretty.pretty-history=3Dformat:%Cred%h%Creset -%C(yellow)%d%Creset %s =
%Cgreen(%cr) %C(bold blue)<%an>%Creset
gitflow.multi-hotfix=3Dtrue
gitflow.prefix.feature=3Dfeature/
gitflow.prefix.release=3Drelease/
gitflow.prefix.bugfix=3Dbugfix/
gitflow.prefix.hotfix=3Dhotfix/
gitflow.prefix.support=3Dsupport/
gitflow.prefix.versiontag=3Dv
gitflow.feature.finish.rebase=3Dtrue
gitflow.feature.finish.no-ff=3Dtrue
gitflow.feature.finish.keepremote=3Dtrue
gitflow.feature.finish.keeplocal=3Dfalse
gitflow.release.finish.keepremote=3Dtrue
gitflow.release.finish.keeplocal=3Dfalse
gitflow.hotfix.finish.keepremote=3Dtrue
gitflow.hotfix.finish.keeplocal=3Dfalse
alias.st=3Dstatus
alias.co=3Dcheckout
alias.di=3Ddiff
alias.ci=3Dcommit
alias.ci-rm=3D!git commit && git notes --ref=3Dredmine add
alias.ci-gh=3D!git commit && git notes --ref=3Dgithub.issues add
alias.ci-n=3D!git commit && git notes add
alias.amend=3Dcommit --amend
alias.update=3Dadd -u
alias.up-head=3D!f() { git diff-tree --no-commit-id --name-only =
--diff-filter=3DACMR -r HEAD; }; git add -p `f`
alias.staged=3Ddiff --cached
alias.ls-staged=3Ddiff-index --cached --name-only HEAD
alias.di-staged=3D!git diff-index --cached --name-only =
--diff-filter=3DACMR HEAD | xargs git di
alias.co-staged=3D!git diff-index --cached --name-only =
--diff-filter=3DACMR HEAD | xargs git co
alias.up-staged=3D!f() { git ls-staged; }; git add -p `f`
alias.coding-standards=3D!php-cs-fixer fix
alias.cs=3D!f() { git diff-tree --no-commit-id --name-only =
--diff-filter=3DACMR -r "$1" | xargs -n1 git coding-standards; }; f
alias.cs-staged=3D!git diff-index --cached --name-only =
--diff-filter=3DACMR HEAD | xargs -n1 git coding-standards
alias.cs-head=3D!git diff-tree --no-commit-id --name-only =
--diff-filter=3DACMR -r HEAD | xargs -n1 git coding-standards
alias.cs-tree=3D!f() { git ls-tree -r --name-only HEAD "$1" | xargs -n1 =
git coding-standards; }; f
alias.ph=3Dlog --graph --pretty=3Dpretty-history --abbrev-commit =
--date=3Drelative
alias.cl=3Dlog --pretty=3Dchangelog  --no-merges --cherry =
--abbrev-commit --date-order
alias.sl=3Dlog --oneline --reverse --no-merges --stat
alias.rv=3Dremote -v
alias.fa=3Dfetch --all -v
alias.ff=3Dpull --ff-only
alias.wu=3Dbranch -a --no-merged
alias.latest-version=3D!git tag --sort=3Dv:refname | tail -n1
alias.pt=3Dpush --tags origin master:master develop:develop
git-up.fetch.prune=3Dtrue
git-up.fetch.all=3Dtrue
filter.lfs.clean=3Dgit-lfs clean %f
filter.lfs.smudge=3Dgit-lfs smudge %f
filter.lfs.required=3Dtrue
user.name=3DToni Uebernickel
user.email=3Dtuebernickel@gmail.com
user.signingkey=3DF6035C7A
core.editor=3Dmate -w -l 1
commit.gpgsign=3Dtrue
github.user=3Dhavvg
github.token=3DPRIVATE_CREDENTIALS_REMOVED
travis.user=3Dtuebernickel@gmail.com
travis.token=3DPRIVATE_CREDENTIALS_REMOVED
alias.review=3D!f() { git ph --author=3D"$1" ; }; f
alias.rf=3D!f() { git flow feature track "$1" && git co feature/"$1" && =
git ff && git flow finish; }; f
alias.upstream=3D!git merge --ff-only upstream/`git branch --list =
--no-color | grep -e '^\*' | cut -d" " -f2
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
core.ignorecase=3Dtrue
core.precomposeunicode=3Dtrue
remote.origin.url=3Dgit@gitlab.tarifhaus.ag:tarifhaus/thengine.git
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
branch.develop.remote=3Dorigin
branch.develop.merge=3Drefs/heads/develop
branch.develop.rebase=3Dtrue
commit.gpgsign=3Dfalse
branch.master.remote=3Dorigin
branch.master.merge=3Drefs/heads/master
branch.master.rebase=3Dtrue
gitflow.branch.master=3Dmaster
gitflow.branch.develop=3Ddevelop
=
gitflow.path.hooks=3D/Users/toni.uebernickel/Development/Tarifhaus/reposit=
ories/thengine/.git/hooks
user.email=3Dtoni.uebernickel@tarifhaus.ag
gitflow.branch.feature/ITTPL-36-coupon-token-email-limit.base=3Ddevelop
gitflow.branch.feature/ITTPL-49-command-locking.base=3Ddevelop
gitflow.branch.release/2.5.0.base=3Ddevelop
gitflow.branch.feature/ITTHE-243-landingpage-content-tags.base=3Ddevelop
gitflow.branch.release/2.6.0.base=3Ddevelop
gitflow.branch.feature/ITTHE-246-json-web-token.base=3Ddevelop
gitflow.branch.release/2.7.0.base=3Ddevelop
gitflow.branch.feature/ITTHE-249-post-request-daten.base=3Ddevelop
gitflow.branch.feature/ITTHE-248-users-api.base=3Ddevelop
gitflow.branch.release/2.8.0.base=3Ddevelop
gitflow.branch.feature/ITTPL-92-url-shortener.base=3Ddevelop
gitflow.branch.release/2.9.0.base=3Ddevelop
gitflow.branch.feature/ITTHE-255-basic-orders-api.base=3Ddevelop
gitflow.branch.feature/ITTHE-260-migrate-databases-helper.base=3Ddevelop
gitflow.branch.feature/ITTHE-257-signup.base=3Ddevelop
gitflow.branch.feature/ITTHE-256-api-profile.base=3Ddevelop
gitflow.branch.feature/ITTHE-267-convert-to-testdox.base=3Ddevelop
gitflow.branch.release/2.10.0.base=3Ddevelop
gitflow.branch.feature/ITTPL-137-besser-mobile-portal.base=3Ddevelop
gitflow.branch.feature/ITTHE-251-HTTP-500-api-problem.base=3Ddevelop
gitflow.branch.feature/ITTHE-272-message-queue.base=3Ddevelop
gitflow.branch.feature/ITTBO-7-einfache-faq-verwaltung.base=3Dhotfix/2.9.2=

gitflow.branch.feature/Tarifporfolio-V3.base=3Dmaster
gitflow.branch.release/2.11.0.base=3Ddevelop
gitflow.branch.release/2.12.0.base=3Ddevelop
branch.support/ITTHE-262.remote=3Dorigin
branch.support/ITTHE-262.merge=3Drefs/heads/support/ITTHE-262
branch.support/ITTHE-262.rebase=3Dtrue
gitflow.branch.feature/ITTHE-277-change-password.base=3Ddevelop
gitflow.branch.feature/ITTHE-280-TEF-MyPay.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-292-msisdn-on-contract-activation.base=3Drele=
ase/2.14.0
=
gitflow.branch.feature/ITTHE-280-mypay-vouchercode-transactions.base=3Drel=
ease/2.14.0
branch.feature/ITTHE-280-mypay-vouchercode-transactions.remote=3Dorigin
=
branch.feature/ITTHE-280-mypay-vouchercode-transactions.merge=3Drefs/heads=
/feature/ITTHE-280-mypay-vouchercode-transactions
branch.feature/ITTHE-280-mypay-vouchercode-transactions.rebase=3Dtrue
=
gitflow.branch.feature/ITTHE-293-translate-security-error-messages.base=3D=
develop
=
gitflow.branch.feature/ITTHE-295-combined-contract-endpoint.base=3Drelease=
/2.14.0
gitflow.branch.feature/ITTHE-294-simcard-activation.base=3Drelease/2.14.0
branch.support/json-rpc-form-type.remote=3Dorigin
=
branch.support/json-rpc-form-type.merge=3Drefs/heads/support/json-rpc-form=
-type
branch.support/json-rpc-form-type.rebase=3Dtrue
=
gitflow.branch.feature/ITTHE-310-user-profile-for-existing-users.base=3Dde=
velop
=
gitflow.branch.feature/ITTHE-312-refactor-obtaining-vouchers.base=3Ddevelo=
p
gitflow.branch.feature/ITTHE-298-vouchers-for-user-subset.base=3Ddevelop
gitflow.branch.feature/ITTHE-313-send-signup-message.base=3Ddevelop
gitflow.branch.release/2.16.0.base=3Ddevelop
gitflow.branch.release/2.17.0.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-315-explicit-persist-attribute-value.base=3Dd=
evelop
gitflow.branch.release/2.18.0.base=3Ddevelop
gitflow.branch.feature/ITTPL-350-bcc-club-email-to-lbe.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-321-promotion-voucher-on-contract-basis.base=3D=
develop
=
gitflow.branch.feature/ITTHE-325-lock-voucher-when-obtaining.base=3Ddevelo=
p
gitflow.branch.release/2.19.0.base=3Ddevelop
gitflow.branch.hotfix/2.19.1.base=3Dmaster
gitflow.branch.feature/ITTHE-339-api-access-control.base=3Ddevelop
gitflow.branch.release/2.20.0.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-334-promotion-for-all-customers.base=3Ddevelo=
p
gitflow.branch.feature/ITTHE-331-behat-context-api-problem.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-336-canonical-user-email-address.base=3Ddevel=
op
=
gitflow.branch.feature/ITTHE-138-address-validation-setup-wrapper.base=3Dd=
evelop
=
lfs.https://gitlab.tarifhaus.ag/tarifhaus/thengine.git/info/lfs.locksverif=
y=3Dfalse
=
gitflow.branch.feature/ITTHE-351-behat-assert-response-content.base=3Ddeve=
lop
gitflow.branch.release/2.21.0.base=3Ddevelop
gitflow.branch.feature/ITTHE-355-refactor-chat-api.base=3Ddevelop
gitflow.branch.feature/ITADM-48-feature-deployments.base=3Ddevelop
gitflow.branch.release/2.22.0.base=3Ddevelop
gitflow.branch.feature/ITTHE-360-media-service.base=3Ddevelop
branch.feature/ITTHE-360-media-service.remote=3Dorigin
=
branch.feature/ITTHE-360-media-service.merge=3Drefs/heads/feature/ITTHE-36=
0-media-service
branch.feature/ITTHE-360-media-service.rebase=3Dtrue
gitflow.branch.feature/tarifhaus-club-support.base=3Ddevelop
gitflow.branch.feature/ITTHE-370-open-promotions-not-listed.base=3Ddevelop=

=
gitflow.branch.feature/ITTHE-371-support-registration-vouchers.base=3Ddeve=
lop
gitflow.branch.release/2.23.0.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-375-support-promotion-participants.base=3Ddev=
elop
=
gitflow.branch.feature/ITTHE-288-aboalarm-bank-account-check.base=3Ddevelo=
p
gitflow.branch.release/2.25.0.base=3Ddevelop
=
branch.feature/ITTHE-384-products-and-attributes-new-portal-strategy.remot=
e=3Dorigin
=
branch.feature/ITTHE-384-products-and-attributes-new-portal-strategy.merge=
=3Drefs/heads/feature/ITTHE-384-products-and-attributes-new-portal-strateg=
y
=
branch.feature/ITTHE-384-products-and-attributes-new-portal-strategy.rebas=
e=3Dtrue
gitflow.branch.feature/ITTHE-388-json-rpc.base=3Ddevelop
=
gitflow.branch.feature/ITTHE-382-anonymise-order-notification.base=3Ddevel=
op
branch.feature/ITTHE-388-json-rpc.remote=3Dorigin
=
branch.feature/ITTHE-388-json-rpc.merge=3Drefs/heads/feature/ITTHE-388-jso=
n-rpc
branch.feature/ITTHE-388-json-rpc.rebase=3Dtrue
gitflow.branch.feature/ITTHE-372-vouchers-on-monthly-basis.base=3Ddevelop
branch.feature/ITTHE-385-timeline.remote=3Dorigin
=
branch.feature/ITTHE-385-timeline.merge=3Drefs/heads/feature/ITTHE-385-tim=
eline
branch.feature/ITTHE-385-timeline.rebase=3Dtrue
gitflow.branch.release/2.26.0.base=3Ddevelop
branch.release/2.26.0.remote=3Dorigin
branch.release/2.26.0.merge=3Drefs/heads/release/2.26.0
branch.release/2.26.0.rebase=3Dtrue
branch.feature/ITTHE-386-member-connections.remote=3Dorigin
=
branch.feature/ITTHE-386-member-connections.merge=3Drefs/heads/feature/ITT=
HE-386-member-connections
branch.feature/ITTHE-386-member-connections.rebase=3Dtrue

--
Toni Uebernickel

tuebernickel@gmail.com - https://keybase.io/havvg
https://github.com/havvg - https://www.xing.com/profile/Toni_Uebernickel

> On 27. Sep 2017, at 21:53, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> Jonathan Nieder wrote:
>> Jeff King wrote:
>=20
>>> There aren't a lot of changes to the script between v2.13.2 and =
v2.14.2.
>>> The most plausible culprit is d5addcf522 (add--interactive: handle =
EOF
>>> in prompt_yesno, 2017-06-21), but I'm scratching my head over how =
that
>>> could cause what you're seeing.
>>>=20
>>> Are you able to build Git from source and bisect the problem? It =
would
>>> help to know which commit introduced the problem.
>>=20
>> How about this change?
>>=20
>> commit 136c8c8b8fa39f1315713248473dececf20f8fe7
>> Author: Jeff King <peff@peff.net>
>> Date:   Thu Jul 13 11:07:03 2017 -0400
>>=20
>>     color: check color.ui in git_default_config()
>=20
> Uh, I think I was thinking of another thread when I wrote this.  Sorry
> for the nonsense.
>=20
>> Toni, what is the output of "git config -l"?
>=20
> I'm still curious about this.
>=20
> Thanks,
> Jonathan


--Apple-Mail=_7ECC67FB-1E89-43D6-8375-ADFEB27E4A11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqtw0WfnqbGj2qtYvvngIZvYDXHoFAlnMgrsACgkQvngIZvYD
XHqXZg//XIsWxeK5r+TjHFBszOl0ecpo47wcu54VqURsPftvxnO5cLjpo3MdA7dN
j5CuY2+WRzgYFvbwhvqamfyq0KMWuNqz8F2lPN44n4Kv7Xxvr95LywBG3kEExaX1
TpsKX4ouZ/zriJxMt6ugxF1niEpOPin1f1ovn16aa9R1Jnx5tfKuUMpnG/UbKohV
ctTUXobFzdSG8AXD7+AE9HCISy8l5ZFU9n3tbt7yZyqg+m+XOhgUIOQE6i41nllB
Wv6XXLrAmQrtwaJ+cGBlzeqJ7nT3Gt0yPYyTBeR2iyJsy7fZQueT7W+OXsBvYHuM
BeR8sJ1iA+f3Q0bHn6h7FzYXmVP3BbrcCtuxYIZO60L+5mF/mYCSdklCDnLpt6L3
2+fE9P4dhzSbYTdLtAJFM9xPKwGi2lnF1j16om7s+rZ3XDpmOvFvWvI9LCSpzEoW
t7apqbc5NTEEqMaDx2vl6YIeMiKXy8gTYJJy+PTBaHx/+FQn6lNyGnLdavtFhoI/
rsaywP8fbSLhRe6BiBdXn9848Qcvt+/ExRX02nQtBDI3TXUr6CPNjz9nxM/1kkYZ
LWxVk8aJLQ6leQrwUPWABZuNqZ4EvtZKET0mB+hzzTwiv6D6lnVdR72/Nj2dV5zQ
luC4vmVQwfa0Z8hsEkc2ii3tdWFv9ssW29Qn+ix3lDxa3haGEp8=
=MnIH
-----END PGP SIGNATURE-----

--Apple-Mail=_7ECC67FB-1E89-43D6-8375-ADFEB27E4A11--
