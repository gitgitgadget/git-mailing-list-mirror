Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F5C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 10:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiCMKnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiCMKnq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 06:43:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E528724089
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1647168151;
        bh=vJC2ICr7FyNiSJPCu2QDlqg8CNX4Tc45CDhw2VEIxlA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cbLr9sKHldEPwNTpUzpjsZ2vW1N5+q1nkfgkdbk0uQu8TOjmGTwyrzNIldaq+PW/C
         ezszhEjAR9Z+9NYV/UYqSAtaghXgqtj1JyP5qtgbcEaZyy0uGr5Kavy+INASJGv8Q1
         1n8lL1JUNca0cs/izo/bB3ieQzjJ1Dgm02yxKV90=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1ncO7Z3vN5-00QzUP; Sun, 13
 Mar 2022 11:42:31 +0100
Date:   Sun, 13 Mar 2022 11:42:30 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        ??var Arnfj??r?? Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/27] Builtin FSMonitor Part 3
Message-ID: <20220313104230.ctwbskywcq5jxv36@tb-raspi4>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:jx7YLcr78AqKR1FCayq+0AG34TvY3Gf6how4xv58JJRbTxmWZpz
 PnM6yO6BBGhuba0/EveLZjSXMBG71qhI1P0c/9CVws4/5DcEeum+19kTb8Y2/SpEebzRTyL
 G2Zv2IeoIFAK0olrrllxL3miBDUiRuLFJ/xAv4gSvItVlTTKE8xVJpzuCknV711NXSeDinB
 ZltHI2afOJ/801jOQT8ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0VsS/tzvn+4=:MdHtZzwH0eVCQKVDfcAqH6
 /nvS7ahsz3IJlZwHC57l9KAhU+UPWEG/DglQAdaqXMu9FPXQMsp+2vgVlVMMe/YhkjhVMzxAx
 QBSXhtSQyu3CPO/5ryHzdf/UbIf24dklpKniG9Z8mt0b0UnajAUmM+G1uYHK5RPOBE9mYbAv3
 K63YqQzMBhsVv2AFsGrEk/spa7k6XOtfGGikV9cYSeQjuaZfdCYn56HDHyf002RfHh2H8Xbsw
 e254w0XidjvtHH8EwNMVAnZf4Z+hI6WZziRJdT1eNSErRQNVAKThAIjhjEuP05VDMQcG5Znsu
 xmKtxWwJsYZjChocd5yysMFE+w2qIIS/kmzS6UC0pEp7STQe5X6V9Ww9/7t72gNA1DSFFklJX
 hiSndk32sFP73jzUFySkwwY2CJqnVYjkZi00Shf1fPnIXSEDXo5rUNpueUmMMSxgDkgtjWCBc
 1YUphC7+hRtWjHvNwVmBIfmiMdcvFcx5MEgUF/RgMCwQlfmMIaNVBo701FQiET4MMQHWHaQkA
 4dgOtzBPLYEeVxvq+M8mnEFAeDnl34idMeTIw+m3XyJR510Zyc6HEkJiTCl79wCVgGFUb7iuP
 HCAvX1y64FEeguAhm+Z96YUuBITuIq6aW+z+CIn6Opk+uK4rlfZcnW0FgyzWdppS+/e5ox+Uc
 sxrgW/AzOQBwA/aVbNPhW96/kWVckKLDAnnis8GCZw0Vtf6u3ihjucWg/1MWQkG07vXPRUHqw
 3lWJN9LuMYBxkudg2HNWJJRTI4Ji7haBFFlrKkeUXdgES3hU0nazFkq07mGvlPS/Dx5E5bYGC
 SuUBjDFJg9gzHo8/Eh5WPWWArHJGQzz8o8+wUsDHXTKX/YYQhmsBxksH4h/ogOADEdhivnyX7
 Buonpl+QpNK5G9eZ1OzlnPakLSYd+cQJHjuketF+RR4+QmrCZr+oyyglswYISmSkLBiuC/awM
 3Plm3yzrR7GQY0rnkwUMAG+rT3p5M0hrAL/eVC4R0rdiL1OVNuQ0J+DvuEtL1CYXgZK5muBEa
 +fYz71yWn07fSfWvZrzEhgFxdOA9/YQA1SPYH2ZRE+KkIys8f4nB61qMcc5E/fH65w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej Jeff,

I tried your patch on both a newer Mac and an older machine (with HFS+)
The older machine doesn't have
kFSEventStreamEventFlagItemCloned
As it is an enum, and not a #define, I ended up here:

  diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm=
-listen-darwin.c
  index 3332d3b779..fa172a05c4 100644
  --- a/compat/fsmonitor/fsm-listen-darwin.c
  +++ b/compat/fsmonitor/fsm-listen-darwin.c
  @@ -169,8 +169,6 @@ static void log_flags_set(const char *path, const FS=
EventStreamEventFlags flag)
                  strbuf_addstr(&msg, "ItemXattrMod|");
          if (flag & kFSEventStreamEventFlagOwnEvent)
                  strbuf_addstr(&msg, "OwnEvent|");
  -       if (flag & kFSEventStreamEventFlagItemCloned)
  -               strbuf_addstr(&msg, "ItemCloned|");

          trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=3D0x%x =
%s",
                           path, flag, msg.buf);
  @@ -221,8 +219,7 @@ static int ef_ignore_xattr(const FSEventStreamEventF=
lags ef)
                  kFSEventStreamEventFlagItemModified |
                  kFSEventStreamEventFlagItemRemoved |
                  kFSEventStreamEventFlagItemRenamed |
  -               kFSEventStreamEventFlagItemXattrMod |
  -               kFSEventStreamEventFlagItemCloned;
  +               kFSEventStreamEventFlagItemXattrMod ;

One other thing, I just add it here:
There is a new file, t/lib-unicode-nfc-nfd.sh, which helps us with this co=
de:
test_lazy_prereq UNICODE_NFC_PRESERVED

The existing code uses a construct called
UTF8_NFD_TO_NFC

And now I have 2 questions:
- Do we need the UNICODE_NFC_PRESERVED at all ?
- And should the UTF8_NFD_TO_NFC better be called UTF8_NFC_TO_NFD,
  because that is what it checks.
- Do we need the UNICODE_NFD_PRESERVED at all ?

As there are no non-UNICODE_NFD_PRESERVED filesystems, as far as I know.
And the current code does no tests, just debug prints.
I dunno.

On Tue, Mar 08, 2022 at 10:15:00PM +0000, Jeff Hostetler via GitGitGadget =
wrote:
> Here is V2 of part 3 of my builtin FSMonitor series.

> [] I updated the daemon on MacOS to report both the NFC and NFD spelling=
s of
> a pathname when appropriate. This is a little more general than the
> "core.precomposeUnicode" setting, since the daemon does not know how the
> client has (or will have) it set when they make a query.
>
> [] I replaced my Unicode NFC/NFD test for MacOS to focus exclusively on
> Unicode composition/decomposition sensitivity and to not confuse that wi=
th
> case sensitivity.

That is a good thing.

[snip]
