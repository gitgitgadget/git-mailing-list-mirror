Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B28203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 13:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbcGZNDE (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 09:03:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:64944 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbcGZNDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 09:03:03 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LaFmY-1b2L763I22-00m2uu; Tue, 26 Jul 2016 15:02:58
 +0200
Date:	Tue, 26 Jul 2016 15:02:50 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Orgad Shaneh <orgads@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] merge: Run commit-msg hook
In-Reply-To: <1469519323-11420-1-git-send-email-orgad.shaneh@audiocodes.com>
Message-ID: <alpine.DEB.2.20.1607261456480.14111@virtualbox>
References: <1469519323-11420-1-git-send-email-orgad.shaneh@audiocodes.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uP2EakzBR7v2ORVE8kLhcY6UZiUXjlVnA8BKhqFF9rTQ+/gaVqx
 sJ0VGW7e1cuYFhxKrf2MaCZmDiHJoEO5NXEPpyyelbgOG2Si6LKPjWt7K9YDp4WY5sKhDXS
 q+WXigJ6RNcF7YQkbbEH9fCP5LKs4+PMd48JUZ54c7pZ44zOUQnid6J1dlmYh5IIpTss8IC
 d/9lHtNdAWY3lyZDK4WBw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zj1KvTl3Jc4=:D6SXDUnv7kFwm99OiP8p2t
 fmZBYKzIDoSvzO238EtcJwXEH9zlQDNZmN3JnO1sfoKhaZWxCXyO0W47VekL91Cbr0q+MLkZO
 /eAL+LN1o9rVJ/be5DyV53iAzZew4PRly4VJ+UFwGeKFj+p1ZKhrc6Gj1gxfkmPUot9ZIrgSN
 xgQ2+fKU4tfv01zBztwMD/+RiBUybGNnvpcyRX++CWSttz9qVpSbsTmPgIcldfeI9l8IgqcU1
 5hJ4m/Cq5SRgbNc01MnkeF4VvB+V58vSdiPb3Pp16Ung3woBbxEKU0LoCBXiXLQY/bxTuNVJY
 C+JHDH84n74Y+beeN9BEwAIvtM61aG8/5MxL64oAMovtOfBgstnj0BgdYk/1AfjxPzokU9gab
 UeBC+NByDCA9bExTvzmVmk+RgKDjVd3cZG44zUfPkXvFjPx9t6VvsJqLR1U7XIlyY1ltHBdTS
 Ge0AYROuza/OMuqgvyZHQhmt1LY5dKsjhlwaRf4YVtmkCBDUHBNchgmw0j97L4uimisRdymIs
 qLf78zssOdQ3so5JMWkfbJsUSuWnXJxh8z9xVzkewLtEd/HEM6LabQqzS0XgrASDmCO/RIERn
 SbeUxbw+gk6ay6dA25LdqXJSu6bPhxhkoIaIj7G7FMvL1OzdE3J17yP+ASEHkU9z+ZUktTuhu
 3uMISu4n6MxChELGLVFJWINlOrjGAEUX5tlxK3jzYlNJP9E+BFyz6BtZ9ktPtqbVdV2BU4XN2
 INsBB5dZCCwFqZ95P6ghKH6Nl+eZ6EWoStu0NmC0ICFo3QlLKN7enMPkTOLXDkaXyTeTLjA1K
 WiPg8TR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Orgad,

On Tue, 26 Jul 2016, Orgad Shaneh wrote:

> From: Orgad Shaneh <orgads@gmail.com>

Again, this is unnecessary if you already send the mail from the same
address.

> commit-msg is needed to either validate the commit message or edit it.
> Gerrit for instance uses this hook to append its Change-Id footer.
> 
> This is relevant to merge commit just like any other commit.

Hmm. This is not very convincing to me, as

- if you call commit-msg in `git merge` now, why not `prepare-commit-msg`?

- a merge is a different beast from a simple commit. That is why we have
  two different commands for them. A hook to edit the merge message may
  need to know the *second* parent commit, too, for example to generate
  a diffstat, or to add information about changes in an "evil commit".

- if Gerrit is the intended user, would it not make more sense to
  introduce a new hook, e.g. `merge-msg` (and `prepare-merge-msg`), as you
  have to teach Gerrit a new trick anyway?

- if Gerrit is the intended user, why does it not simply edit the merge
  message itself? After all, it executes it, and probably crafts a merge
  message mentioning that this is an automatic merge, anyway, so why not
  add the Change-Id *then*?

Ciao,
Dscho
