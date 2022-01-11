Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09878C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbiAKSff (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:35:35 -0500
Received: from mout.web.de ([212.227.15.3]:53549 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345401AbiAKSff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:35:35 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 13:35:34 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641926133;
        bh=XnoFfcT3fFbCxPs4/M1vD6n8BL0zsa4UMOlSTFK1oT4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jhQ8/zaiNbDphKXY1deyYedjzoIaHEJGNQXkIxCF6uY2HHZt9zBwAVINQ+yGjXBZc
         vzc6nsflVC5RoT1y45szKZutjs3HoFn+gIDEDWKhpI5guyYw9N+JujrivBgCE8+6gj
         LTh6+A0rK3j6DgTW0j1cKLFrvoLUqdp5fjDJDLW0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO9E-1mY15Z3brk-00ZYrr; Tue, 11
 Jan 2022 19:30:05 +0100
Date:   Tue, 11 Jan 2022 19:30:03 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] docs: correct documentation about eol attribute
Message-ID: <20220111183003.g4fch5d2f47it2hg@tb-raspi4>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220111021507.531736-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111021507.531736-3-sandals@crustytoothpaste.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:u9alP0oaC6uBvYmAKLf6STi7lrFlMav0IAq9Bf8EvG9S9NZIH0b
 5OM/MJD629RZ0k/fTofOn+yV+gCX/IyGavl1OHTzgvD2gJVOUxvEefztiMvDxNKU/bpiw1M
 Rf95IRzELRdy+xy3znmsW6yg/F+T7P8ETIZG/r3SAtkoZXWj/ofJVlQJBOstp0aGdw4Zv3n
 5LXDXR2DSVFBcikKt1aAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yOtEQ6oY+c4=:0x5aUhrSLMmewV4lK0RpyK
 jQS+Ajy5lU/yI3dhWsWXFOfUbbsIaDmJ/ZVE6N4BXK2QS5sfbd1/cqfYpQrhVogKgxP+lCbP9
 V0+M0xgsxpUnjZJVLXpLRj/2mtriApY0oC+GjZyJRspBYiezW7yF++0x/EikFXTetNm/iQQDG
 //H0f53lCpciCLFn5aQbSgQTgGzpX5kI3sqlbya7wpsFusIvWbWxKBbC5HT+8pbPOKGvaJ5iL
 yNqtmchFRMqFQ3eB/Et+wivDWMtM2ZMfLpr7QuHDMsT2117cbrLp+2nfFzhWaW1BRSe/atWsU
 G2o+wQ0x+jfY/ebOxOQVmwuuKc4OyFA/EjPI1clDAJmDzwZQOLZh9jxKmiAQ1NBt+rgWH2HYB
 NzFH21IARP7tWj1wiOgd3FqW9K/wMTZrEOy/NqMXutSu6jCTaSkJiYSPVXdxb1RLw0rfhwfGc
 j8mMpLJenabVQg4TzfSCIFQld/4qfZ3AOaC2dLi/9vp/qYnq0Us1ezxukLgZOGCPVP6SgitGb
 LI5bc7+7EKFLlU8J9KhvRU1Ibd6LvEAp1mwSEFlv67Ymge99WpOz4dANOaN3dxiOR5nS+2GXH
 xN6JTO+NzCu58pyZwlPChb/xzlhppj5WsfpbehVDZUlbk94Lw7lOWdzhl8I2DRD7C42AOj4l3
 TWnV7eLceUNDCSi65gtmLQ1bUb+Vg82HD1rkS3B2AtJ7fiiC6Vh5lnleMVJEmJkweIiZ8v+h1
 KfJamx8Zb7OMNTTGqK5evYMX0X8ro48H10WyRylN5vpcazxkNJzL2Y3aCvfxOX9kK1zC01F1Y
 UbURS/fnWq4TcOlzJ9WTcuO/wCydXqnRMzMJZqdlSzjkW4HJq0jMEQzOqN5UO+crXgcJOTfHD
 8suu8wmSCq2Lz29twQ1Y4jpyR2FHc+XtQlCnn9vzuFkC9dJDQki/KI/eJoonz6pRJka+ku4Em
 BbPvZVVI2SW8DaO+ReQqxzbRTAaoo2FCCTPS/qiQW3Y0w1HQY/9jmzXP4A2Lw0vAOPFKLcucI
 BKQ1vxEY6G+icb3fV45MBuDKqUOapyp/FaCnyGma0M9h0VgOTs24f6oa0QoYLYbeAw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej Brian,
thanks for digging into this.

Could you be so kind to send the stackoverflow issue ?
(You can send it to me only)

I have some comments/questions, out of my head.

On Tue, Jan 11, 2022 at 02:15:07AM +0000, brian m. carlson wrote:
> The documentation for the eol attribute states that it is "effectively
> setting the text attribute".
> Let's avoid confusing users (and the present author when trying to
> describe Git's behavior to others) by clearly documenting in which
> cases the "eol" attribute has effect.
>
> Specifically, the attribute always has an effect unless the file is
> explicitly set as -text, or the file is set as text=3Dauto and the file =
is
> detected as binary.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitattributes.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
> index 83fd4e19a4..60984a4682 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -160,11 +160,12 @@ unspecified.
>  ^^^^^
>
>  This attribute sets a specific line-ending style to be used in the
> -working directory.  It enables end-of-line conversion without any
> -content checks, effectively setting the `text` attribute.  Note that
> -setting this attribute on paths which are in the index with CRLF line
> -endings may make the paths to be considered dirty.  Adding the path to
> -the index again will normalize the line endings in the index.
> +working directory.  This attribute has effect only if the `text`
> +attribute is set or unspecified, or if it is set to `auto` and the file
> +is detected as text.



>  Note that setting this attribute on paths which
> +are in the index with CRLF line endings may make the paths to be
> +considered dirty. Adding the path to the index again will normalize the
> +line endings in the index.

I think that this can be loosened as well. And, beside this, the "dirty"
warning about setting attributes could be written as part of the "text"
attribute as well. I dunno. Here is a possible suggestion:


  Note that setting this attribute on paths which are in the index with CR=
LF
  line endings may make the paths to be considered dirty - unless "text=3D=
auto"
  is set. `git ls-files --eol` can be used to check the "line ending statu=
s".
  Adding the path to the index again will normalize the line endings in th=
e index.

>
>  Set to string value "crlf"::
>
