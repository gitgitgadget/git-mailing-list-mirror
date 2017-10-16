Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1018C1FF32
	for <e@80x24.org>; Mon, 16 Oct 2017 11:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdJPLdV (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 07:33:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:62625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdJPLdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 07:33:19 -0400
Received: from virtualbox ([95.208.59.135]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt2BW-1d7Aab3jHm-012W7s; Mon, 16
 Oct 2017 13:33:12 +0200
Date:   Mon, 16 Oct 2017 13:32:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer.c: fix and unify error messages in
 rearrange_squash()
In-Reply-To: <xmqqfuajuae8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710161331290.40514@virtualbox>
References: <20171013175157.13634-1-ralf.thielow@gmail.com> <20171015170742.8395-1-ralf.thielow@gmail.com> <xmqqfuajuae8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SDphTRBo6ZTs6XgCANYTccjjj7DSIGQCeJiWXsfdJO+NcXaqGGj
 z7bB8tIyLQXBAPvUkpIduWFbnZauV97tGJofO3Rp6oQVLOO40rU+gR7xgSXI7vdejvG3m4O
 zsnJldkdex8XifqoQEu7tB111FXQtQgFV/kpVLA35xZhHcqiLUMHqYsfZP22MOegPswGNzO
 LP4hILOpucUW3Ba3Wsnlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5xb+N+hAGSk=:K92Dv4sn0Clz2C2z63cZVJ
 LJepevXq+pDRn0qgLpoteA2MHjSrLdRnK2idtElApkYAnjFOquG1nQks8dLIB1mZ/OC8LZI65
 leLGxTE5fDiGF5PGd6+M0mhfB9xTPhA5yom3QlhsaAIQzSxEj5RN8adkWlkMpLy3K62uldru+
 G5eDUdKzDUZ9LX2slRkSPSWVQ8Oy26Gq37HM4byZ2lQnCL5kVvQiHSMVWBnqE1Fts3033Rje0
 xxHlSu+DbrwdLLRlmlf1R97bRJSpJNKIBjYWigorAzwsroy8JGSjptXf7s+Qd5iXKh750FKxp
 SFMGlHldTR2G9F+JHmZiBr0hvQKNP/IDZUAhqaFhnOOi4Uu1QR6zVmtGJFq8ZPMe7pEsZ2dHx
 vrueRf7JHbH0rplVQHPbf13Et6pOGFjxjyQJ3Q6eJt+a5aufI4cQAeam2bENHph35Zwkr2oN2
 G/FUWvDhGazqABbs0AgVkPF/q/ekVa8YLuc0KBNZZzafsgX/AiqCvEK/Wwki0lO/xs0eHZpoB
 0CikJWp6XMD015VBm8FyeaWn4GbDup90rjCNcjfoLKcNEdrSkjpa9yl103sRLwtZW+5mwJds9
 33fwMJlk/24Re45XYtjEKw7K5ouPj/Ls7L966rS1hVZz4mEePkSflrhd+Pu7i7tcQl4OdV+9V
 Tig1YLBkiKZ7HBOblSbwettHj7I9ULlgAgG4htH8AuDUA0FjmGgOK9iwQhqk1ONCG/eXV5Nd2
 oKnLL9kljXqp86YHWklKuWVkkQRVHicdo2w7Kz8o5GSi7CX72AeD78JIBF/Ok4H1ultesULmC
 ro+7jL8wXvZr+/n3o1F0+DCcMesLUWYZzslA2p/OAD5+6/dZUA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Oct 2017, Junio C Hamano wrote:

> Ralf Thielow <ralf.thielow@gmail.com> writes:
> 
> > When the write opertion fails, we write that we could
> > not read. Change the error message to match the operation
> > and remove the full stop at the end.
> >
> > When ftruncate() fails, we write that we couldn't finish
> > the operation on the todo file. It is more accurate to write
> > that we couldn't truncate as we do in other calls of ftruncate().
> 
> Wouldn't it be more accurate to say we couldn't ftruncate, though?

This is an end-user facing error message, right? Should we not let users
who are happily oblivious of POSIX nomenclature remain happily oblivious?

In other words, I would be finer with "truncate" than with "ftruncate...
wait, huh? Is that even English?"

Ciao,
Dscho
