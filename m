Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92621F790
	for <e@80x24.org>; Mon,  1 May 2017 11:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423912AbdEALWP (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:22:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36790 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164085AbdEALWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:22:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so13532746wrc.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HvrMtYICP6OqO2hwm6PcWjvczTt80LTZ+4lV3wsJ2JY=;
        b=L//ckGck/Qg5ZsYEsULtRuFVBwAXVTqIANxea/uRDkzdSoBegl/fGK5WORqkpVtSF9
         VCkPqGiONpkMDJI88TGAAc+hqBbt22KEo3E6RS6k788BKOWfnsW/MALK0LH2zcFkhigW
         wNSGuWMLcdLvo/Lr5iMB7Basrj5aW0Lp5xbL2bj2SfSgwwHo1/ioiYn+P6cbEnB3vNqO
         K+YIfkDZMbeEv1326VUkSmaAOokJzEML40A6KKt2vZFJmoBDTUJO37E7nmjiKmBF3ZS7
         h9MGkJ5QTdgUShwHRRWrEEbsh3VHfCcRFmzkFiXnZhlAo/7euc2ZVXxn57m43JAbPBrD
         Tl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HvrMtYICP6OqO2hwm6PcWjvczTt80LTZ+4lV3wsJ2JY=;
        b=eqkKcNYNugZieziSzDkNQNWflRRnPBpksbIv5HW43mkDGTsE6favsuN9OnZyBkmUm9
         Kfy55hosW6JbVLDojUmM79cpOEnFmcxBdLhP98VTO1fzQ3sXQSIhXdyfbywQ8flktQmu
         BsV5eZxYS4X3X2c5Ms19QOkpWI3xGv1QyXeC5+x5QPhhGIAd/swumDCJ4SSTnkOwd5Ht
         x4dJtdA9dkzv4wK/CoOTtXDOL5fO/a9gU/0k2gYFvYzJ+VfTxbvmpFSpIfHkLbeG5t9U
         YKfa6iTd81Yva7gCtTxGgjBlwdxjMMujPxlzu5rA5qUUbWRvfmnp/0e+DESzcx3GAHyL
         A49A==
X-Gm-Message-State: AN3rC/6ZWFjeAvrbQoMG8yIGgVgMwwLt9YMWwO5Ly8qpOodix5DBzfS5
        TEAD8Tf5nWaYGg==
X-Received: by 10.223.133.182 with SMTP id 51mr1212202wrt.86.1493637731953;
        Mon, 01 May 2017 04:22:11 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4780.dip0.t-ipconnect.de. [93.219.71.128])
        by smtp.gmail.com with ESMTPSA id p187sm10548518wmd.24.2017.05.01.04.22.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 04:22:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Automating Coverity, was Re: [PATCH 00/26] Address a couple of issues identified by Coverity
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1704282205320.3480@virtualbox>
Date:   Mon, 1 May 2017 13:22:10 +0200
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73A81857-0083-4A70-88AE-FAA025B6A4B7@gmail.com>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com> <alpine.DEB.2.20.1704282205320.3480@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Apr 2017, at 22:29, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Stefan,
>=20
> On Fri, 28 Apr 2017, Stefan Beller wrote:
>=20
>> On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>=20
>>> I still have to find the time to figure out one more detail: how to
>>> download and extract the Coverity tool (the .zip archive has a
>>> variable name for the top-level directory), and doing that only =
every
>>> once in a while, say, only when there is no previously unpacked =
tool,
>>> or it is already 4 weeks old.
>>=20
>> That is an interesting problem, which I ignored as the older versions =
of
>> their tools still works once they release new versions. So I just
>> manually check every once in a while if they have new versions out
>> there.
>>=20
>> So if you find a nice solution to that problem, let me know, please.
>=20
> I think I have a working idea (jotting it down in the editor, =
untested):
>=20
> 	init_or_update_coverity_tool () {
> 		# check once per week whether there is a new version
> 		coverity_tool=3D.git/coverity-tool/
> 		test ! -d $coverity_tool ||
> 		test $(($(date +%s)-$(stat -c %Y $coverity_tool))) -gt
> 			$((7*24*60*60)) ||
> 		return
>=20
> 		curl --form "token=3D$(COVERITY.TOKEN)" \
> 			--form "project=3Dgit-for-windows" \
> 			--time-cond .git/coverity_tool.zip \
> 			-o .git/coverity_tool.zip.new \
> 			https://scan.coverity.com/download/win64 &&
> 		test -f .git/coverity_tool.zip.new || {
> 			# Try again in a week
> 			touch $coverity_tool
> 			return
> 		}
>=20
> 		mv -f .git/coverity_tool.zip.new .git/coverity_tool.zip =
||
> 		die "Could not overwrite coverity_tool.zip"
>=20
> 		mkdir $coverity_tool.new &&
> 		(cd $coverity_tool.new &&
> 		 unzip ../coverity_tool.zip) ||
> 		die "Could not unpack coverity_tool.zip"
>=20
> 		rm -rf $coverity_tool &&
> 		mv $coverity_tool.new $coverity_tool ||
> 		die "Could not switch to new Coverity tool version"
> 	}
>=20
> 	init_or_update_coverity_tool
> 	PATH=3D$(echo $coverity_tool/*/bin):$PATH
>=20
> I guess I will start from that snippet once I have time to work on =
that
> Coverity automation.
>=20
> BTW I stumbled over an interesting tidbit today: if you define =
FLEX_ARRAY
> outside of git-compat-util.h, it will not be overridden by Git. That =
is,
> if you want to use 64kB flex arrays by default, you can call
>=20
> 	make CPPFLAGS=3D-DFLEX_ARRAY=3D65536
>=20
> No need to patch the source code.

Looks like Coverity has TravisCI integration and I assume you wouldn't
need to worry about downloading the tool in that setup:
https://scan.coverity.com/travis_ci

I think we should be able to enable it without trouble for the 'master' =
branch?

Cheers,
Lars=
