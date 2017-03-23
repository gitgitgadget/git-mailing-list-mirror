Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C800B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 14:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdCWOlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 10:41:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:62974 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdCWOlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 10:41:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9JYE-1d2dBW1TaA-00CfxL; Thu, 23
 Mar 2017 15:41:12 +0100
Date:   Thu, 23 Mar 2017 15:41:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls
 commit-msg
In-Reply-To: <xmqqinn1kwo6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703231539410.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de> <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
 <xmqqinn1kwo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JSXpxLuwE6bb1ZmZk6W/c7SORuyGTZ1040Vxvz20hcPIMVp0GQV
 zxxD5gk9Qkm81rrbhp/43UJ3bAJ0vHUnbFTjcRgBmnU0ExnAw65TitaMRpEVTPLjuYPuy/n
 AdCEoTiyfoAE7mjFglQQPm4gzGW7lG+INHcu59MEiYhGT2hDbYKx5pkrfPZM+HVuHMJ2VdU
 cUl27XDeY5+iA+zaa4OBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KM8yjeJNXYE=:tIkTDU18LQYj6T2kS/h+02
 6hZaEwh+2iH92thU4AkeAA2SRnhJz/DYgb7+pPkuLkTKzpw1ixnr7FVBdnaPfcPrjb/JsAct0
 kIhVBs9kErpbq7Tqo6SCNlp4I9m7wZTNDUEwv8fJVt1PwThKNIbITHwLLX/S2ezqTMvBapKXR
 UAU8xgzNOGvz47nbcfQDXK5qXWhj06AZnpeFBRPPQXLM59rbEzRVyilDxNBKwES1iFYnIDnI4
 aq8SJGfjFj/G09CAlsyWXL4A3o6z19EFnlnERG6wtSBMcMk7kA87fwyQr2c86URDp5XkPjH51
 +sirhMBTBBHuHC2EHKAf649zQxgi5oxlVxbA6AFH0jmxxSrDwgxzulNDkljI5oQfiyn9dhmfC
 njsFkH2nZNkq9SPB8K7wGyd2FiH1fHE2/3TzOYp3VYlByN9xqhwtGzf8JmsNWgcA7Oak3LWrj
 Nnl8YtsjrdDxogpi+E8ca3ErdffdLcyhgN8AyUhpWpQofW+ym/8tXiK6/QxFxjbJEOe5CsAe3
 1w/1roZq4Y39Vo9AqpxYRPMbLlg3Utnq2rdbtJj3t6CWPLpGTz4hOXxdwVKyoBQYz4BKbR9i9
 t7sWtxHIB/XEdyIDdUEFMCdHCci6WlwYnYsWj/7tshdR+sClXhXZR7zRBb5qvHYZtn7oRdyTu
 ZTHrU9Ts4lxBMXCIc06OTdt5aHJcNjh10/qcUetarvwD0x+cHxmV1pfPLJcwQM+1JC/3VqQ6A
 twWXYskEzGtecQaWIwPRnpUAJhLR4y5wVB5O6I81hOr8zkJhxEcyMofaHL1XJf05hJ7X4zucZ
 9qYfraADzD4ScSC6EU3XpwrILO1Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Mar 2017, Junio C Hamano wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > On Wed, Mar 22, 2017 at 4:01 PM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> >
> >> Noticed by Sebastian Schuberth.
> >
> > Thanks for working on the fix.
> >
> >> +# set up fake editor to replace `pick` by `reword`
> >> +cat > reword-editor <<'EOF'
> >> +#!/bin/sh
> >> +mv "$1" "$1".bup &&
> >> +sed 's/^pick/reword/' <"$1".bup >"$1"
> >> +EOF
> >
> > Maybe use
> >
> > sed -i 's/^pick/reword/' "$1"
> >
> > here to avoid renaming the input file? Not sure how portable -i for
> > sed is, though. Otherwise, maybe remove the file "$1".bup afterwards
> > to be clean?
> 
> "-i" is GNUism and it is a good idea to avoid it, but cleaning after
> itself may be worth doing to avoid contaminating the working tree.

This script is only used as *sequence* editor, i.e. for
.git/merge-rebase/git-rebase-todo. As such, I find it valuable to have the
original version in the same directory, and the file is cleaned up upon
success by the `git rebase -i` command anyway.

In that light, I am sure you agree that the current code is fine.

Ciao,
Dscho
