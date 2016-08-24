Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC011F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755689AbcHXPlx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:41:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:52163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbcHXPlw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:41:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Ma2Lr-1brD9u0jAl-00LrHX; Wed, 24 Aug 2016 17:34:05
 +0200
Date:   Wed, 24 Aug 2016 17:34:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Arif Khokar <arif_khokar@hotmail.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1608241509200.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2144075108-1472052845=:4924"
X-Provags-ID: V03:K0:WBeb2wYPps9mpasleUqx/AztYu8F7CmwTiBD5ECcZ+TMoG6GzjT
 lJcg8CS2lHMbCmb8zyypVWKClJq45jUrq7ryNtZDL/CorrQFJjvZb9DZ7ruG8rZe0qbYHo2
 KcDIJpgoVac77n7KPIWg6q1xO5stUVeNrPo0HM2a6V7IRgaMbioD9bxeNPQ4/GI4bJ7wVmA
 m3tyAGNbJfDxbtceBq8uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LY2lMdOWJL4=:iAaS9CFuzBnqjB73Adti54
 uA7u5gZ/2+cZsemPoEAyv3H+VNEb2sKBMwQfz9f4YVs23iauH8ky51yG/M6+MqvilCDso2nKl
 1FilImQOZqc+N9nhK/vTbRSFsSwj6sAQzcagiD8gV7q0b9+WTLVSRzjpkBr+JUdqwz7vxS+lT
 M5Gy95BwuyGqEu3aOHaLwk8MS8ZiDfUD8jr8AHcyzyok2MPshuCK7CDb+QdWw3OJSMlCGPK93
 kyc1KOcM9GcNwKOL4mVYeGp6nn6uy7oFkSU5k4Vtspg8+U6DCLNqZq6KqqGBkDrhps2xyAI/F
 BAtSIqDKLYkuZnU1uQpSCV4zo41dOqEaKkYtFsFcRRzGI2ZX2IAXeNYQ+0UqNnN8oaGJqU4E0
 oa7+XqX2IPiv/wwsXe540a2pAfh0gJaaQTUiCrGg1Cqyd5ql4OoI6/hFBVwe7zVmjCPAkjMwm
 31U8A0qNKx8cGMP6jCefOgocYrwvaRG1gHYPS6IuQIyICRhgv+sNEzmWUFpncKg9xtBcn6a9n
 9A2hiA9kzIe2m0V9DL2jt1fPABI7FZoO0lQNSbX/FCR+fCo/EBAQtdZ9bNHL3Wb7GSSJjlpfE
 dDg5AauzeVYXDgRV965NK/QoLoCj7H6sy10D0SplCVpMgHKcz6YaU7BHWP+xXCz+fMvPLDIrg
 ahSRhlfcHtzlC9gwLbPvkRRwsDBOxc+kzOK3qHgI8SC4sTlNyhPZonM/lxjFgFtxjvaUvWWzD
 KPl9M8/lOxszUU33p4gpqUVZTKG60tMfejdJ90qYgVnFjh5gPLk0qrU9zEn+TgGCCXxBEsDyQ
 lPXdnYF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2144075108-1472052845=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Arif,

On Tue, 23 Aug 2016, Arif Khokar wrote:

> On 08/20/2016 03:57 PM, Jakub Nar=C4=99bski wrote:
>=20
> > But perhaps the problem is current lack of tooling in the opposite
> > direction, namely getting patches from mailing list and applying them
> > to GitHub repo, or Bitbucket, or GitLab.  Though with working Git, it
> > is something easier than sending patches via email; it is enough that
> > email client can save email to a file (or better, whole sub-thread to
> > file or files).
>=20
> Given that public-inbox provides an NNTP interface, couldn't the ARTICLE
> <message-id> NNTP command be used to easily retrieve the messages in a
> given patch series (at least compared to POP or IMAP).  Perhaps
> git-send-email could be modified to include the message-id value of each
> patch in the series that it sends to the mailing list and include it in
> the cover letter.

I am no expert in the NNTP protocol (I abandoned News long ago), but if
you go from HTML, you can automate the process without requiring changes
in format-patch.

> Then a script could be written (i.e., git-download-patch) which could
> parse the cover letter message (specified using its message-id), and
> download all the patches in series, which can then be applied using
> git-am.  This would in fact take the email client out of the equation in
> terms of saving patches.

I recently adapted an old script I had to apply an entire patch series
given the GMane link to its cover letter:

https://github.com/git-for-windows/build-extra/blob/master/apply-from-gmane=
=2Esh

Maybe you find it in you to adapt that to work with public-inbox.org?

Ciao,
Johannes
--8323329-2144075108-1472052845=:4924--
