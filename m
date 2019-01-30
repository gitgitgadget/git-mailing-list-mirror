Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB311F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbfA3Tcw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:32:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:56599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3Tcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:32:51 -0500
Received: from MININT-6BKU6QN ([62.119.166.9]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiTrM-1hRHcb2PgC-00cdRE; Wed, 30
 Jan 2019 20:32:42 +0100
Date:   Wed, 30 Jan 2019 20:32:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
In-Reply-To: <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-13-jeremyhu@apple.com> <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com> <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WvFoedK3vyqUjmJiwE7K3ITwMXn2BUIkkXgDdYSU4RVT6vh15iy
 EfukpSBPImruvOLeyZWiz8boxfJa6q38510OWow6HwcguLAifB7ENL5Qfok2SebcCm7PuhO
 BorVPfOjA6tO47h0qY2nL+RXY3DnWVAK1SPUvc2k8EVF6eF+HQudeetMfuRJ4lHOVR+2E8X
 Grl1ndg8g5XLCiRHpeKtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ajJVPw6uFZE=:IypXDZUFSQx5ECnfO+WPbt
 riID/HkM53M5ENypGZg7DGdQWErkk1YRikbbkOAEIbK8gXmw4egk3HsrgYHcom2sKTv1CzmsD
 8ynFPFN6HybStWiO7rzhSaHvSVIYBZOi0NL8WjVb5kI+Y3HLTTdqS+rt1tyzKaUdqjO/+XaPD
 v8tLziz/37m7BIu1lJ+oJjsucY4O/aOXxNGRjunRrk+u/FXp7xFpucnaUNdO0Gj38Ifm7Fc6N
 H/1T+MQv4S5LMYYAI5gdF2KKQMEYBWtH42FEgwiXz9/fARZAtsZAi6wAcK+szutfFGy2qIz1X
 fmOCfNS5o/BkgkUsf4oGC3JY/wmQla5Bqc4eGt+dqjwWvX7qPGrAMBL1YiqFXnY7Pq4LM7dPQ
 QC6NyczriVxCkiL4GjA/NMlLtPPWyAYATDEUNoGPyJr8G4S53LKzv6C7Llj/YMuyIZ7j2Yq5q
 o7E9OW8DZfk5xK2sUixkkV8gRKQPluGnHFka2Wa6RPUNc1hDyFm2QIEYgSQHysu4i3suGZBZd
 PLWcOX2qabnuCA1umo7i1fjOxYgw6HjEhU2AwuV+yro1TLaOI9KJyhuVyCYPthvyuPdOD4igU
 UBCcArlkVkjFYOPvfbwqZ1KfkmgWan39jwsUU44uVBa5caqQ/jOYKzTlDwamIaoPn4QJ65n3e
 dGgaD9BH5PkHs4fiRZhUevazB1cEg9XCLQcePcImFmx6pssdmERWAl+l1TixehWQYO4EJ8k46
 XbL2sr6Uc0Z5kbvDxxmlFMlieDP2TEjxlFUCOCE6CdUovNVFf7X8vB5UOzrWLp6w7sxWkfDX7
 LyMKH5PGK6ngYAATFghA+kTXj68xmkSNqBOZZlZsGFUZ5X9Pqa5DfBn8QS+ELTdFNlodBYZsa
 x5JqM14raqrgfbi+oS2ckwIJqJEcEn6JplqTjC7dxwlEsFqJEv9WWC2j/3rfQI0ra+5BU5PeQ
 WseJDfbkIzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> > On Jan 29, 2019, at 3:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> > 
> >> Useful for setting up osxkeychain in Xcode.app's gitconfig
> >> 
> >> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> >> ---
> > 
> > A concern shared with 13/13 is this.
> > 
> > While it may not hurt too much to look at one extra location even on
> > non-Apple platform, it probably is a mistake to have this xcode
> > specific change in generic part of the system like config.c or
> > attr.c.  For that matter, would it make sense to force Apple uses to
> > look at one extra location in the first place?  In other words, we
> > already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
> > defined so system owners can give reasonable default to its users.
> > The value of not using that facility and instead adding yet another
> > place is dubious.
> 
> This allows for per-distribution configuration and could be useful for
> other applications as well that want customizations specific to their
> install of git.  For our specific use case, we do not want to munge the
> system policy when installing Xcode.  Prior to doing things this way, we
> were just changing the default in our distributed git binary, but this
> seems a bit more flexible.

I think you misunderstood Junio, thinking that he referred to
/etc/gitconfig. He did not. system_path(ETC_GITCONFIG) refers to
<prefix>/etc/gitconfig, where <prefix> is that runtime prefix when
compiled with RUNTIME_PREFIX.

So you can definitely have your own per-distribution configuration: it
lives in that very <prefix>/etc/gitconfig where the portable Git is
installed.

And since we have that nice facility, I agree with Junio that we probably
do not even need an extra config, certainly not one just introduced for
XCode.

Ciao,
Johannes

> 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >> config.c | 13 +++++++++++++
> >> config.h |  2 ++
> >> 2 files changed, 15 insertions(+)
> >> 
> >> diff --git a/config.c b/config.c
> >> index ff521eb27a..656bfef8ab 100644
> >> --- a/config.c
> >> +++ b/config.c
> >> @@ -1631,6 +1631,14 @@ const char *git_etc_gitconfig(void)
> >> 	return system_wide;
> >> }
> >> 
> >> +const char *git_xcode_gitconfig(void)
> >> +{
> >> +	static const char *xcode_config;
> >> +	if (!xcode_config)
> >> +		xcode_config = system_path("share/git-core/gitconfig");
> >> +	return xcode_config;
> >> +}
> >> +
> >> /*
> >>  * Parse environment variable 'k' as a boolean (in various
> >>  * possible spellings); if missing, use the default value 'def'.
> >> @@ -1673,6 +1681,11 @@ static int do_git_config_sequence(const struct config_options *opts,
> >> 	else
> >> 		repo_config = NULL;
> >> 
> >> +	current_parsing_scope = CONFIG_SCOPE_XCODE;
> >> +	if (git_config_system() && git_xcode_gitconfig() && !access_or_die(git_xcode_gitconfig(), R_OK, 0))
> >> +		ret += git_config_from_file(fn, git_xcode_gitconfig(),
> >> +					    data);
> >> +
> >> 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
> >> 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
> >> 		ret += git_config_from_file(fn, git_etc_gitconfig(),
> >> diff --git a/config.h b/config.h
> >> index ee5d3fa7b4..f848423d28 100644
> >> --- a/config.h
> >> +++ b/config.h
> >> @@ -115,6 +115,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
> >> extern int git_config_copy_section(const char *, const char *);
> >> extern int git_config_copy_section_in_file(const char *, const char *, const char *);
> >> extern const char *git_etc_gitconfig(void);
> >> +extern const char *git_xcode_gitconfig(void);
> >> extern int git_env_bool(const char *, int);
> >> extern unsigned long git_env_ulong(const char *, unsigned long);
> >> extern int git_config_system(void);
> >> @@ -131,6 +132,7 @@ enum config_scope {
> >> 	CONFIG_SCOPE_GLOBAL,
> >> 	CONFIG_SCOPE_REPO,
> >> 	CONFIG_SCOPE_CMDLINE,
> >> +	CONFIG_SCOPE_XCODE,
> >> };
> >> 
> >> extern enum config_scope current_config_scope(void);
> 
> 
