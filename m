Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D7F202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 12:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdJYMUI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 08:20:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:54415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbdJYMUH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 08:20:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXDo1-1de23o1g7Z-00WG9D; Wed, 25
 Oct 2017 14:20:01 +0200
Date:   Wed, 25 Oct 2017 14:19:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: Consequences of CRLF in index?
In-Reply-To: <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com> <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O/CIxZRxGOv+tURwJnt+ItTt2aP/JNbuOWc3qswNxiC+yBwjUJf
 eh1IhxHb2dMBv7+z3QWMOEDhFCrL53EVTWDn9ABbeMSH0yTWEJhSvWj4GJHQtKecOhZzE0s
 j52/sOMjLznDRmaDulaO4PQll2atFI3G/fylX+ZL/FcD03mQNpUebUoNAgLzyQIBIM78NTM
 b11bDH3o+lUzBcSi4t4nA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O+iyIRGKBKM=:kqxfq3lJ91l2J/em8Tn6Nh
 6hihXQo1xbfBmaDGW1Zgw9isRiEDvnlWgGOvXGfjElt9+IsWozT+F/vGxv6fBg6c+nQoIcD3Y
 0WPWyQpSnYuRPBEIW0L2WLZl0+IziSGo1XPfHbj9QZt6nBo9IGg1GgqpOFvRImOYw+Xl2OvI6
 3hINlBgao0SctDLcAmQoh9kOFX0yDurKE7BYtuHHzUoyuK8KdCn9xclWqPJE+rmQrA9r8Za5K
 Y04uFRG1rklZhLkh7jlt1FsvL0dLBSXSPEPyYyFBdqauAyr4QntibxVhDjxz9Wi+H1qhyrGOq
 7Rzdak7e38uK+Wcq2dR+ryytzkCJowajERSWdssckQQjB/o47HxFSiqr1fmxL2HCfKUsSINbm
 G3DMQB5Q8cWK483EG3b592mROzHeDfVK8nTqCv76EVx2gEbJ0mDNdDLmpW95o6w8mxG1fGo8h
 GjKq7ksSLjwTDkF4XVsCWQl/Du7vyA/h5CIYq00I0ou4GxPwMyhN59Kb/EMNagH3ljXidlD4K
 6prMRCICXOquhl6KHRXlubWZly1Tk+89FZ5KhSr41If/Dlp7eG4oWLvOi6mDCs3LMW6kE5RiI
 KnYPk+cbL0xhpilIkTybAf5gP6/VgSlczgYaHS3KHEqX/gikJshHSOMjw6az6DEf1hkLlUTm4
 dlSRnRWt9/TliIEs9fGPR7w31FL1sFeoXki6Io1r+Py4jBK8lip4bQe9OG3/7//XgeTACBrQG
 a0SKMVaI9UKxWGzmu45oxKKc3Dj6TNRzzRMpRCCYh9TB8MXjITqqUkhp0/DPTGA4VVLxUEkO2
 rDo3Dc9Lmz49av+teFh7PTtRMQ4Fw6tm6mydoeC+FUY9rg+MyP/be+hG0Mlh2puIj1EKwxr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 24 Oct 2017, Johannes Sixt wrote:

> Am 24.10.2017 um 19:48 schrieb Lars Schneider:
> > I've migrated a large repo (110k+ files) with a lot of history (177k
> > commits)
> > and a lot of users (200+) to Git. Unfortunately, all text files in the index
> > of the repo have CRLF line endings. In general this seems not to be a
> > problem
> > as the project is developed exclusively on Windows.
> > 
> > However, I wonder if there are any "hidden consequences" of this setup?
> 
> I've been working on a project with CRLF in every source file for a decade
> now. It's C++ source, and it isn't even Windows-only: when checked out on
> Linux, there are CRs in the files, with no bad consequences so far. GCC is
> happy with them.

I envy you for the blessing of such a clean C++ source that you do not
have any, say, Unix shell script in it. Try this, and weep:

	$ printf 'echo \\\r\n\t123\r\n' >a1

	$ sh a1

	a1: 2: a1: 123: not found

For the same reason (Unix shell not handling CR/LF gracefull), I went
through that painful work that finally landed as 00ddc9d13ca (Fix build
with core.autocrlf=true, 2017-05-09).

Ciao,
Dscho
