Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0EB32055E
	for <e@80x24.org>; Wed,  1 Nov 2017 21:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755373AbdKAV6Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:58:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:57463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753175AbdKAV6X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:58:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPGI-1dUvyN0Z4Q-00hden; Wed, 01
 Nov 2017 22:58:21 +0100
Date:   Wed, 1 Nov 2017 22:58:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Matthew Orres <matthew.orres@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
In-Reply-To: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711012254380.6482@virtualbox>
References: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pukuCdRIORVvUeuiUynZLl/sqOsdLYaCD6RIcYGoC/hnSlbREO1
 VAqaFoN1PzBVjJKE+r5agG6DMWrKp89h+8Fs+rYLpTgzcuTvRG4dutNOsBWDaQwdcAFDiLO
 eNZWW+FtDWEkW/HZpR+vUSoSONuvgQQveZiKUs/rsjV5ay0k4bW3cjGbW0g82fDVBrzMA8W
 9jt2GLEyocwTCVYVaOFAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/3/uK1m2zPo=:88TIrWW23an/B56ucgAR5C
 IROj4nfUpImq+RQMOaer21XmEVOcHBTR1Fve5Mi5NbEAVpF1exDk3DhHgpOQ7YCzVveCclEuM
 aC8wd5zv6ISnVBJfbQthmAgcBxZKtpUqTXF1bCFOK3ZWFE56+/0YqbSbM74FJtnJc8wbidSVh
 825h/ojVvazqDs+3Va3i6FgKqCBNI0mkK2ojnAhUZl415BoBDYMTJuUSyU/JMUYHR6l0QNu6V
 rSJcJuWuF+7DwepqHakqAjEsXYtuURHdDoW+/fgxhi3RsX20UnXxtoN8dGHT8UIHLz9nlMjw5
 TWromMeHhaZtfpIqGpYoqSjnANCAu7wFsw0NhRM9qxcdIAl9bxlYzOiDz6VaaLZy6losv8ouK
 NLhQX3E3KaTpO2Rmj047i77UnABQcwA/vgw9hsASdep7ed9nQl0z/tmfy/KuEQn5fXuJZlHT8
 f2bgNT5NB2oc3xH8beefycHNrfhDp4fOk9sEjS4z/AZU7tbHmnWDgygOVTIMxCdbfI6IaqG1o
 Q2GkAqCb4JnXfkcbCCrPpA6LD8BMlcy39cE5H46vSAv0FcyW3uPAgXInjf+sYnD0k83ARJJl9
 Vi4jHt3KDUNAym3Eq8MKbcpk4dMS5fJQe9EFnYoJJD3rW+DyzNbv8CE1YpGnBBlohUqKT37Pw
 wdimxRZME+9K7rAhj01XkTGVD0hpPPuHXa4qPYAXQ2509/nT+EBUtT5577VswlFs+t/9FDM6A
 eo3R/rps/DlE+GPok7vNxzirq9wnUx3iRu299EEpZ1pLf7au6jJfgXoNTjvWDvJXWB58VAR0D
 +ohHlsExZvYxuyicE9VG0R4x9Dqpg012O3ZOYuf0B/C/n7im1c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Wed, 1 Nov 2017, Matthew Orres wrote:

> Using 2.15.0 on OSX 10.12.6, when I open git gui, and then attempt to
> stage multiple files as such:
> 
> * Left click first file
> * CMD+Shift+Click last file to multi-select all files
> * CMT+T (shortcut for Stage to Commit)
> 
> Only the file I selected with the first Left Click is staged and my
> selection disappears.
> 
> I'd be happy to provide more system-level info if there's issues with
> reproducing this on other machines.

Maybe you'll be also happy to test things?

I believe that we carry a fix for this in Git for Windows:
https://github.com/git-for-windows/git/commit/3a5640fd3f0aa57edecc8dab455a97c5a15e6626

The easiest way to test this would be to simply build Git from the
`master` branch of https://github.com/git-for-windows/git (I try to keep
it building and passing the test suite at all times not only on Windows,
but also on Linux, it should also work on macOS).

Ciao,
Johannes

P.S.: If you test this, and can confirm that it fixes your issue, I'll get
this patch submitted properly to the Git mailing list (sadly, it seems
that the https://github.com/patthoyts/git-gui project is sleeping beauty
mode for a while now, otherwise I would add PRs there).
