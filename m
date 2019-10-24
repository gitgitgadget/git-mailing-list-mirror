Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8BED1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfJXXIl (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:08:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:59205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfJXXIk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571958512;
        bh=IiWJLLO/Hld6WFGuKKnuzjiCu+dRNEDR1KpUcv69kyk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EGHtsll+BopAu6R/kporLdO6UzKbtTo9t/hbkGW0qy1OJ0IYKwBvhv1YNOuTvQrvM
         SRVrtiDB9YoORI289W/pYgSYKnPizk+QnngljaeiDh0MdlYGwRLvQU704SlnhAbiKK
         DyKDe+MqzKoEcU0NL87Cux92YFcWbAlo9XcosIPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1iWt0L0rIn-00QkRN; Fri, 25
 Oct 2019 01:08:32 +0200
Date:   Fri, 25 Oct 2019 01:08:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [git-for-windows] Git for Windows v2.24.0-rc0, was Re: [ANNOUNCE]
 Git v2.24.0-rc0
In-Reply-To: <74f50326-e613-8545-2c69-65cd29dd3cfb@iee.email>
Message-ID: <nycvar.QRO.7.76.6.1910250052350.46@tvgsbejvaqbjf.bet>
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet> <74f50326-e613-8545-2c69-65cd29dd3cfb@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1818417834-1571958513=:46"
X-Provags-ID: V03:K1:KKcKzCjyMbvn0jl+Dqk4p5UxwBw6yo9V3uLKZY8lrWU2Sk0in5g
 0agNhd2nUPuSC1AR+g15ruOCPO4vGBAAwZjspI8YmPjGPpIUcLX80tHtcJMdb4rb4rstZ11
 6407fzrX1NcYi9ie9dmw68i6I1MH7R1krBjlVK3hwwJTNQBMydNK/65aaU+GhO4Q/PPPZU3
 merbBtKL03RAy0eLDQHIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:npoUF+i94Z8=:u4SoYd9TzOJVcHUQ54btzg
 N8rJdxJF3TCg2qjH1cUcdoHx8GLSY3wvXIVEc1AS95IWKjDiGivvdaDc84QfdmFlbrmaEdY1a
 goy0IuDMro8aBGzeB0nib41UiaQxo56vONVA0AXNCXve0l+fTE5chjNEUsQb8zEPqOqL2SKsi
 jSQkIAx0vkiXra8TDoda1ufrziXm1i6Gs1gn2WmhvYydSJBORvIpCa+TOrc4nYS/jl6NFo+rV
 3/dGCE5PwIRw6/+Mpdxn2KMlVoeESg4Ir2HqbZH2U/tZ9go2lZvIA+xe0QMvlVMBlzpGACUSM
 QO4Spy2gRoysw0hoXZp4Pk38+O86BTpx1clL2rf35+N9Pr1V82A07hCRje26q0CFODti16Rde
 pk07LInWnFx6MwyrlNoLIY86p7N3fIkAmx3F87dSyYTFeCIAeZUwXaXHuIfO3q81raOsMtbdn
 znRAuQhKxK/4BawsSZ4ucKkIdfOEX8gE0j73wFsBdXkTfID76Zjx8b4aYgBJPtuRGwROLABsV
 SsVwIspG/gpSw5SwZGVFHfHnCXwIdYh223OW3zEssamfQOC+EB/53GTk6kYjmWkxjo9Nnaco9
 ZRpEtsempOC/CvBMxlqgBYZMkRwCkoU8h/zpbZAfxynUYDg/JnNUDH5iaatc7c5DkkqeEZAke
 xCMPxvyBoCZu6BbXV1LGYBzlku1UC1h7vPlwWlYfvwqh/SVUAucZKZUOSKr1Juf/smDKueAcq
 Tv7of4X3BQiiVvex/WqNbXdavl9JJCUT4LydKYlafL6sx3CSwrc76wsLitIMLOqdnNXxYotP5
 8EMDTMwrxJA7zToq2a5ivGxqwByC2gjN3Dz22pZGingxa3Z8UbCep8DR0LeszqiKqRpoF13Qx
 otCNRdsuQSwdHJ6ZmCz//tOy3WRGPV0ngwInHa2Z0s16iCt4gi4fbTvxs5Vyaa/pr+DrAXfzY
 3kPi2dCQH50eU1Z4FpNmD+PQeamCrbz3vX+bXir9y84ABXozllssePofTAD7qd+TCTTRgK243
 8fRHy4G8PQi6HoIf78oZDmNIHj+DAYXQVCkMuh/898CdbbFl4VrB9tWXG+d9ELzkH+XWRBlJP
 uxEhBag2EBnVffmku3iJ8A9rbqcGJGgFv0pAYINf0BnZVYvXFwjxe9s9Y6ZPjL4fLNKD6gOIJ
 zaANoNvQ+E0Rw6NYDU/kCZdDhwakk2fzo8y/GSvEu+WHaFvmWyzXNAntTtW6lMe2Cewyc2hsD
 pF4qo/HdwR5pMkXudeyX7BDo9hWNsU7sOq6VRJM/TmzYpr4/zaKuigSqHuMQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1818417834-1571958513=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Tue, 22 Oct 2019, Philip Oakley wrote:

> The minor pedant did notice that the new location is listed slightly
> differently from the release notes.
> `file:C:/Program Files/Git/mingw64/../etc/gitconfig`=C2=A0 --system,
> while the release notes simplify the path to C:/Program
> Files/Git/etc/gitconfig

That's a good point. I guess that it would make sense to normalize the
location of the system gitconfig:

=2D- snip --
Subject: [PATCH] config: normalize the path of the system gitconfig

Git for Windows is compiled with a runtime prefix, and that runtime
prefix is typically `C:/Program Files/Git/mingw64`. As we want the
system gitconfig to live in the sibling directory `etc`, we define the
relative path as `../etc/gitconfig`.

However, as reported by Philip Oakley, the output of `git config
=2D-show-origin --system -l` looks rather ugly, as it shows the path as
`file:C:/Program Files/Git/mingw64/../etc/gitconfig`, i.e. with the
`mingw64/../` part.

By normalizing the path, we get a prettier path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index e7052b39773..8e2f4748c49 100644
=2D-- a/config.c
+++ b/config.c
@@ -1658,8 +1658,10 @@ static int git_config_from_blob_ref(config_fn_t fn,
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
-	if (!system_wide)
+	if (!system_wide) {
 		system_wide =3D system_path(ETC_GITCONFIG);
+		normalize_path_copy((char *)system_wide, system_wide);
+	}
 	return system_wide;
 }

=2D-
2.24.0.rc1.windows.1
=2D- snap --

See also https://github.com/git-for-windows/git/pull/2370

Ciao,
Dscho

--8323328-1818417834-1571958513=:46--
