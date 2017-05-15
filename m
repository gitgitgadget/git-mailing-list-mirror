Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F57201A7
	for <e@80x24.org>; Mon, 15 May 2017 12:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbdEOMOt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:14:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:63637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbdEOMOs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:14:48 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnxVE-1dcfoh1pJw-00g2jt; Mon, 15
 May 2017 14:14:11 +0200
Date:   Mon, 15 May 2017 14:14:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     arnold@skeeve.com
cc:     gitster@pobox.com, stefano.lattarini@gmail.com,
        ramsay@ramsayjones.plus.com, neleai@seznam.cz, j6t@kdbg.org,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance
 guide
In-Reply-To: <201705141914.v4EJETGf029570@freefriends.org>
Message-ID: <alpine.DEB.2.21.1.1705151358590.146734@virtualbox>
References: <20170504220043.25702-1-avarab@gmail.com> <20170504220043.25702-2-avarab@gmail.com> <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705121214470.146734@virtualbox> <xmqqbmqx6bbh.fsf@gitster.mtv.corp.google.com>
 <201705141914.v4EJETGf029570@freefriends.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-932008662-1494850451=:146734"
X-Provags-ID: V03:K0:wV7I99xHElP4C6FuqcrSwhpIxGv3/DHzB6gIXMgz2ldRcFEx9Nn
 wgD7PlIh5S8gQQezxQWkmPlRy3P9niP6rxyEOiwPtS9jZ5BC/e5G4DLBJ+r1mpV1EzK/Zpa
 HpTUWj3W4suyTuzBPDl64QkhXFo8v5ilARfly3LTM2JnJK+Lsbh75UFaxxpi7ZQcfw4pgA+
 7wIrnHpyVcnpgY3JdmggQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O6tsaubhA/Q=:+M236vrgQfgkNzguxrDaP5
 lXfOkXxh90ZNbyt7FA7nvraYWGsTwxPbgKufAL6AuoSw2TZvupin0W/vFNMdjjS3Ai/Ne+EWo
 b5/q2Wgb9N5wgTOwGx7gp/NPDYNJeXdOZ2jmCc6t78w48VIaduMcPElbrFhYN+V1D6ozrphL9
 Xw/civKYt/OaKWwVuoKtnH0Qie5Y3rGqICWPamzyK2nbCAUTRn6jJ7+93IfQ/Tz/mhW0SC7lQ
 KLS8B1QBIb1RUE/vFr0k2Lo5HdSB88CZvMzQ4wiWb7eQXNeyfsBkYyiuXGhFjMSgovrH/zoP4
 E3zMyDPhduYDJucu0pxTJoyBohK/rmCPbaF+LhZrluLxLkguSgr4yHkuK8MhlTBC9WuR11iZn
 V8O1v3WfnUaZKpiBn1tjHm4h0IWtLcEIFxFvcqGouBKquzHClIVtheR/uID3HwP95PwBmAxbI
 7f5+pdW/a+BfEHyPo2Fpg3KcJn83s/Lme3y4aiByJQ8m+o3Cm+QN9J4TQuzjVUNaXwK1xe3lA
 zABwgCJsk8012V2MHhuTuwMvutsGFJhXjNK6czLCPQhDyZMvy4zVeM3FwhN+acba+PGZGPtlG
 1Hu5YAv1rOxkNNVC5aZnUD2YuEPQCcu5bP4iaNFmXtMZzdkDUkcSup8++rY83YUrFMa41QEJn
 4Zpo+aMd38Zar2vAcd3kj2oDJIX7gVxcke+xa7V46PvKYAnvZjaWJUBYTnQZ8YaV+f5zeRCUv
 9WTwHO5wVK+7gAOjE5U4D+STx2wR5uOJ2uZvT/dAJNnF+QD8h3GDKvYCgpP2IT8LWCnMyYM3k
 Y4II/LG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-932008662-1494850451=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Arnold,

On Sun, 14 May 2017, arnold@skeeve.com wrote:

> With respect to bug fixes that may have happened downstream, please do
> let me know of any.  But I do request it as a bug report to
> bug-gawk@gnu.org and not just a pull request with no commentary.

I dabbled with updating our compat/regex/ myself, a while ago, and just
found my notes. Note: at least some of these notes should help with the
next iteration of =C3=86var's patch series.

First of all, our original import could have been accompanied by better
documentation what was done. Granted, back then gawk was still maintained
in CVS, so things would have been a little tougher with regard to, say,
specifying which gawk revision was imported. In the meantime, gawk uses a
Git repository, though: http://git.savannah.gnu.org/r/gawk.git. Therefore,
we can say pretty precisely that gawk's 40b3741f (Bring in development
gawk changes., 2010-11-12)) was imported into Git as per d18f76dccf
(compat/regex: use the regex engine from gawk for compat, 2010-08-17).

My approach of updating compat/regex/ differed from =C3=86var's in that I
checked out that Git commit, applied the interdiff to gawk's newest
commit, and rebased that onto the current commit of Git. But I think =C3=86=
var
& Junio's approach (replace compat/regex/ wholesale by the newest gawk
revision's files, then re-apply clean patches of our `git log 40b3741f..
-- compat/regex/` on top, as individual commits) is saner, as it will make
future updates substantially easier.

With my approach, I still had 16 merge conflicts, pointing in large part
to changes we do *not* want to contribute back: gawk's code style differs
from ours, and we adjusted the files in compat/regex/ to ours (which I
think was a mistake).

I also reinstated support for compiling with NO_MBSUPPORT, which included
a new guard of the btowc() definition.

I also had to reintroduce explicit #defines of bool, true and false, as
gawk's source code split those out into their own header file.

I apparently also "skipped a guarded #include <stddef.h> that was not
actually necessary, but simply a late fixup to a997bf423d (compat/regex:
get the gawk regex engine to compile within git, 2010-08-17)", but I do
not remember what that was about.

In summary, I do not think that any of our patches should go "upstream"
into gawk's source code, as they are pretty specific to Git's needs.

Ciao,
Johannes
--8323329-932008662-1494850451=:146734--
