Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2029201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 01:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbdBWBa1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 20:30:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33634 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbdBWBaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 20:30:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so130190wmv.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 17:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=ann9VcV8oK7HS5P2wKBd3attbSOXqS+zhru4/GGJd1k=;
        b=NIrHTyQLpFuKYhqjokVQqSoXRrmygpbrYIHGaRnn2hBVoPX4laMjI+N+A3N8vRydA1
         WXQ90J0tpDRK2X22fBrA9l96DhiCOP4Ji27BVJqgvFkACNgdkK/YPwUxWVuEll0hE3zi
         5rciexr3RlqOlox3GaT6choA00E6a6rWbmeB89xD+YpIIHuc6ExFXXIUdfraPGqpc8Ln
         dH0uZhsA/N5VWB6XgGzsACpWCvO48wTTgU2n43nGR3bw0GC9zbIl3/ZLEkGMeeOFK0xr
         73cbzV6Lq4xWmrq+COyIm63mzjEH4xKDd04qbB7J3uXMXT6buHVPj7QR798EreHORXUW
         onZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ann9VcV8oK7HS5P2wKBd3attbSOXqS+zhru4/GGJd1k=;
        b=gIqDpXzMQ4Tu5WxxHcF8dhMM2agkPA8xXwU34/S0mydXSDVpRlj8rtklzYlA/4feOZ
         EKNTP+JBzjulWlkZdSxKUnCSk10ITqKceWbAco4DXiDhf+8l9R0ILrPfIwcKtjnIqk3y
         XRK802ocNyotzymkiIINshoirLt9yUtBCZvXfQZFxDACcCSgYzOchs9yBtu65N1znlkP
         aDJ3k7bTxN9cweftsDHBW5RMLpaoYp8Alp7YNfYxiB6d89f1Pvo1pRP1DlVHrTXYncg0
         /0fa9KBh8rHzeKoTnTIcbkODbZp0Olh58DP/ZjoX4TgrnaaYo0rOo0IOWUOtqGPNhSh+
         3Sdw==
X-Gm-Message-State: AMke39n8tIe8FkFdeO1v31cAIKuxX6+ca2zh5P/c5ZiG1NaPZUBq6awsNXX7CzWsslcyBg==
X-Received: by 10.28.236.149 with SMTP id h21mr634602wmi.65.1487813403070;
        Wed, 22 Feb 2017 17:30:03 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.111])
        by smtp.gmail.com with ESMTPSA id 61sm3837747wrs.29.2017.02.22.17.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 17:30:02 -0800 (PST)
Subject: Re: feature request: user email config per domain
To:     Tushar Kapila <tgkprog@gmail.com>, git@vger.kernel.org
References: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Message-ID: <5e25e9d5-ca52-2b32-3701-4826599774ef@gmail.com>
Date:   Thu, 23 Feb 2017 02:30:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tushar,

On 22/02/2017 14:12, Tushar Kapila <tgkprog@gmail.com> wrote:
> So when remote URL has github.com push as tgkprog@search.com but for
> testing.abc.doman:8080 use tgkprog@test.xyz.com ?

I`m not sure if this is sensible, as authorship information is baked
into the commit at the time of committing, which (usually ;) happens
before you get to 'git push' to the other repo.

If possible, changing this info after the fact, on 'git push', would
influence the existing commit you`re trying to send over, so your
'git-push' would have a surprising consequence of not actually
pushing your desired commit at all, but creating a totally new commit
inside the other repo -- this new commit would be exactly the same
patch-wise (in regards to differences introduced), but because of the
changed user info it would be considered a different commit
nonetheless (different hash).

> ... I know I can over ride it per repository, but sometimes
> forget to do that. And even if I unset it, it inadvertantly gets set
> elsewhere when I make a repo and the site 'helps' me by showing me the
> commands to init and clone my new repo.

Otherwise, as you already stated that you find the current local (per
repo) user settings override logic inconvenient (error-prone), you
might be interested in approach described in this[1] Stack Overflow
post.

In short, it uses a template-injected 'post-checkout' hook (triggered
on 'git clone' as well) alongside '.gitconfig' (global) settings to
achieve what seems to be pretty similar to what you asked for (but
might be a bit more sensible), where you may fine-tune it further to
better suit your needs.

On 20/02/2017 21:12, Grant Humphries[2] wrote[1]:
> This answer is partially inspired by the post by @Saucier, but I was
> looking for an automated way to set user.name and user.email on a per
> repo basis, based on the remote, that was a little more light weight
> than the git-passport package that he developed. Also h/t to @John
> for the useConfigOnly setting. Here is my solution:
>
> .gitconfig changes:
>
> 	[github]
> 		name = <github username>
> 		email = <github email>
> 	[gitlab]
> 		name = <gitlab username>
> 		email = <gitlab email>
> 	[init]
> 		templatedir = ~/.git-templates
> 	[user]
> 		useConfigOnly = true
>
> post-checkout hook which should be saved to the following path:
> ~/.git-templates/hooks/post-checkout:
>
> 	#!/usr/bin/env bash
> 	
> 	# make regex matching below case insensitive
> 	shopt -s nocasematch
> 	
> 	# values in the services array should have a corresponding section in
> 	# .gitconfig where the 'name' and 'email' for that service are specified
> 	remote_url="$( git config --get --local remote.origin.url )"
> 	services=(
> 		'github'
> 		'gitlab'
> 	)
> 	
> 	set_local_user_config() {
> 		local service="${1}"
> 		local config="${2}"
> 		local service_config="$( git config --get ${service}.${config} )"
> 		local local_config="$( git config --get --local user.${config} )"
> 	
> 		if [[ "${local_config}" != "${service_config}" ]]; then
> 			git config --local "user.${config}" "${service_config}"
> 			echo "repo 'user.${config}' has been set to '${service_config}'"
> 		fi
> 	}
> 	
> 	# if remote_url doesn't contain the any of the values in the services
> 	# array the user name and email will remain unset and the
> 	# user.useConfigOnly = true setting in .gitconfig will prompt for those
> 	# credentials and prevent commits until they are defined
> 	for s in "${services[@]}"; do
> 		if [[ "${remote_url}" =~ "${s}" ]]; then
> 			set_local_user_config "${s}" 'name'
> 			set_local_user_config "${s}" 'email'
> 			break
> 		fi
> 	done
>
> I use different credentials for github and gitlab, but those
> references in the code above could be replaced or augmented with any
> service that you use. In order to have the post-checkout hook
> automatically set the user name and email locally for a repo after a
> checkout make sure the service name appears in the remote url, add it
> to the services array in the post-checkout script and create a
> section for it in your .gitconfig that contains your user name and
> email for that service.
>
> If none of the service names appear in the remote url or the repo
> doesn't have a remote the user name and email will not be set
> locally. In these cases the user.useConfigOnly setting will be in
> play which will not allow you to make commits until the user name and
> email are set at the repo level, and will prompt the user to
> configure that information.

Regards,
Buga

*P.S.* For the purpose of completeness and archiving I copied the
Stack Overflow post[1] here as well, but all the credits go to its
author[2] (you may upvote the linked post[1] if you find it helpful).
Please feel free let me know if this practice is otherwise to be
avoided.

[1] http://stackoverflow.com/a/42354282
[2] http://stackoverflow.com/users/2167004
