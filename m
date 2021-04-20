Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F409C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F480613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhDTPzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 11:55:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:37481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233041AbhDTPzt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 11:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618934107;
        bh=1b28UI0VZVZmMBw/COPftwSxR9jVsFNP9Oxo6l2Ccu0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F9accmj+/6ZwbiG0Zt7D5RShRc7Z9V4QOF+LiMbGUX7V6xkVkGy4b78MyObWO1Gez
         pu6kEvjj5PVMRMWDDpYKhRChkK9pgoihaiV9j3cF2Bqtyz+zTrFst6OZPVxOnNTk4H
         ZnF9TKeaAA8DvbeUmBS7CRKGjO3nNUTZ8V9kner0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.215.94]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1l9DcK141P-00QAFb; Tue, 20
 Apr 2021 17:55:07 +0200
Date:   Tue, 20 Apr 2021 17:55:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
In-Reply-To: <e4ed4046-6aa0-608f-896e-1c70715b81f3@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2104201751200.54@tvgsbejvaqbjf.bet>
References: <xmqqmttt7q8f.fsf@gitster.g> <e4ed4046-6aa0-608f-896e-1c70715b81f3@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hIzlLDXIWxbb44v5W50YiIWXwSLWz1/hBKoB6Gmf4AsLEQ6L6VH
 0w3HscIHsQJEFB2MHFU9+HMnynqrA/vzIau7mj/8Rff/S5u9RnKwNwJCn9Sahw79p/pPL8H
 jZHuMzWUeNtbfeDbMeUltrgtrDURd47YKCmFAweRu3EOjFZA82AG2tkoLXctmh9bvTmqrkf
 a6K7kfw6JuWXBPPQxkRNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cAwdCsGt+AQ=:qgyAevja8W2GJSWDiR4F/r
 vrKeGJtWsN3sDSjLRaI1dUi70pNImT4HZY1bUHp53zTBYjT9wzhwSyClnNFl1ta7z2sIHWeKD
 pyijUQMw86zsH2PoDg9I5OWQpwEDpMoiRAjvu+zH4x0ZugqrDa83R3Q6kMrnDDHLYJGdrWfXR
 y1cNtByyHsnsd7O8lXp0j6fMFs6JQizxZmTmd3YeZPBmuTFSIvcGNU5+NHvr3wqmfBs6y4LLF
 d7uLXi8f33rMJrioZLX+HY01fGbFEcWS9ZE7JQTrHb+mOp4RDQiKBMRkTHzBJP6K9oTPT7309
 mk9GtaV8UtJ4PAxKenm4qat4XwD+/XRqCZmqzD2uJmmzrx8HnQVcR8aK+wuEwmKXlnHdUd8aS
 07qJEI7XquKrgcVoJsoOUJsyKq6XhUIe493PLUnAFMWlFQU2yjje3QfrBMUgwqXYIdPNU2Io+
 vTpA9KyR8sox9+byhWT+0h0AJGziMXrKFQDu4bsZ2b5yLzUW3bq55K6xGbOjkk63ZLt7lhp5j
 2QX+402pxbYQbdPdyHoac/WVI5D68qZy7m9LRk67OcDkdyvi7dmojsL8drsGv4pLsGtBGLzm2
 ULo7cxynsIdCTKM2JUj+Z9dH7hczifLhx4orKGFxFYVz0Jxl3vUQ9/2Jj92Iih2iqhwnURSRp
 SZBBKxRA/5tAlH2ciFwGNBoS3wrAeIOCvk/wMq7OLmDeLNROpJqdWbag7yaNnVDEYFxmTwtRm
 OcT2S3mq97kcrBjXSKlL/Fz0eSRbKpV4+DhSCVntRX8jIFwW/d2Y9I8OUFCx/dq7JBZ5qmC7e
 8R+FIsIYUe3LiaJRCvohMQT9fFzeDM2vmN/AD4lZOyUD6TGxA1KIoVsWEJuO1NQEABTqtP3o3
 KQTmppmIUArg6jUgSEmzIN85b6O78chqA30MMleUsQkucRrU9GQ1YKwmbdXBrAV62Plp36oVf
 nV/WO+qgq9903xslz4hwqcROcgNey1KOUM591+5+UAe0NwI5plAGRej+v+0vvzufXOYIJhxAv
 klp0KmfIlmSmDmVY7JkN1W/7LUMsTvnXugeNqsaB0KWhdW4Z0NBtRlouyqrk0zNxp7cXOzXnd
 p0G9tmbUgYey/wwi/BGScCrDJtDLM19PfcFwIg/GeiaQG/QrxKYd8xvA6HwttHD2ue1C0YKiL
 6YQn3uF2G3YMCydvcKY//rRdrdabQpOSt6D3vxQ2VpxDZ0UIfjVrk6HxkSbtDqR0uq8S4/loE
 LSvP9rpr+0sk8wyQd
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Tue, 20 Apr 2021, Bagas Sanjaya wrote:

> On 20/04/21 07.29, Junio C Hamano wrote:
> > I was browsing https://github.com/git/git/actions and noticed that
> > there are many "workflows", even though what we have in our source
> > tree in .github/workflows/ define only two of them (which I consider
> > "officially sanctioned ones").
> >
> > I suspect that these other ones come from "pull requests" random
> > people threw at us that never hit our tree, with changes to the
> > .github/workflows/ directory in these PR.
>
> They are Actions jobs triggered by GitGitGadget PRs.

No, they are not. From GitGitGadget's own home page at
https://gitgitgadget.github.io/:


	But... what is GitGitGadget?

	GitGitGadget itself is a GitHub App that is backed by an Azure
	Function written in pure Javascript which in turn triggers an
	Azure Pipeline written in Typescript (which is really easy to
	understand and write for everybody who knows even just a little
	Javascript), maintained at
	https://github.com/gitgitgadget/gitgitgadget.

In other words, GitGitGadget uses Azure Pipelines, not GitHub Actions.

> For example, job [1] corresponds to patchset [2].
>
> [1]: https://github.com/git/git/actions/runs/763138085

This has nothing to do with GitGitGadget, it is the regular
`check-whitespace.yml` check from our very own
`.github/workflows/check-whitespace.yml`.

Ciao,
Johannes

> [2]:
> https://lore.kernel.org/git/pull.847.v7.git.git.1618832276.gitgitgadget@=
gmail.com/

