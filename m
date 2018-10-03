Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32901F453
	for <e@80x24.org>; Wed,  3 Oct 2018 22:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJDFWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 01:22:41 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42930 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeJDFWl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 01:22:41 -0400
Received: by mail-ot1-f47.google.com with SMTP id h26-v6so7232476otl.9
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 15:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBTDtg3l3+PLa0gjtmtlnqXI1ucR5nO5DgWN4/j91f4=;
        b=LAG++yJc7i4RQ4LwXes9p4qxgYwhnCb9oFRt/JgNTwEbbZghUry2bBE4C42XFELU57
         HnORNlqCAfMR+Jq0NC4i/dd1yN/njJ+tsUodTvJoOONFwxVIuy7J28K/xKZBwwbrCQEZ
         jMBwuWj7fjnNRojdt3erPlfU0qwqvQEvVwZyUgZpUBGl4jnIkXAliJ0jjt61pQ39QUlB
         Z9nxnUDHgjZoWj1t8rmvJVyqIbVyNgVACK0NRNWNw1EjDNgfj2ckY1OyTr3BpaD6RnXW
         KzHDrfo7r/4Ybt4PVSgGu9a6AikaQzmMCyamerw1o2xdx22Vy7JprRJGu2NgQHiQNBdt
         bW6Q==
X-Gm-Message-State: ABuFfogKO9qXZeyH6njpucCKPrkYmAUV6OD3AA3sG0S+5YrDKYkLzaBJ
        o4PCrboIf2qFxwJlMzdsS5vwaM4JnMEpMj+qG6dVuSDa
X-Google-Smtp-Source: ACcGV63pjDU7MdaAQpaDFSJ9Xy107pCyAnHhcc82C56yxXbwkeCMy++7tjfMn6WFrtMpbFLmO76BKEGMZqA2cRbbqU0=
X-Received: by 2002:a9d:7a7:: with SMTP id 36mr2273132oto.72.1538605940566;
 Wed, 03 Oct 2018 15:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20160517195136.GB11289@sigill.intra.peff.net> <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net> <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net> <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
 <20180908161316.GA326@sigill.intra.peff.net> <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
 <20181003042437.GA27034@sigill.intra.peff.net>
In-Reply-To: <20181003042437.GA27034@sigill.intra.peff.net>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Wed, 3 Oct 2018 18:32:06 -0400
Message-ID: <CAM-tV-88J3ZAALwZeEqTuvKXRwLzb848G0AET2Ec6ic85=7o8Q@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000898f2505775a9c34"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000898f2505775a9c34
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Oct 2018 at 00:24, Jeff King <peff@peff.net> wrote:

> Yeah, I really like your explanations/diagrams in the comments. It makes
> the logic very clear.

Ok good, I did have the feeling that the logic became actually clearer
to me after I wrestled with the test code, so I think this means I
didn't just imagine that. :)

> (there's also only one caller of this
> function, so it could be inlined; note that it's OK to use "return" in a
> test_expect block).

Oh, I think had run into some trouble with the test runner complaining
about a broken &&-chain, but it seems to work fine now (perhaps I
missing the && somewhere else that I fixed later).

> Why do we need the tag name to be different?

Otherwise the 'git checkout' command complains about an ambiguous ref
(added that to the comment).

> >       git checkout 1 -b merge &&
>
> This is assuming we just made a branch called "1", but that's one of the
> arguments. Probably this should be "$1" (or the whole thing should just
> be inlined so it is clear that what the set of parameters we expect is).

Oops, right. I've inlined it.

> It might actually be worth setting up the uncolored expect file as part
> of this, since it so neatly diagrams the graph you're trying to produce.
>
> I.e., something like (completely untested; note that the leading
> indentation is all tabs, which will be removed by the "<<-" operator):

Yup, works (I again had run into some problems with &&-chaining
earlier, but now it works fine)

> > * left
> > <RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
[...]
>
> Yikes. :) This one is pretty hard to read. I'm not sure if there's a
> good alternative. If you pipe the output of test_decode through
> this:
>
>   sed '
>         s/<RED>.<RESET>/R/g;
[...]
> you get this:
>
>   * left
>   R *BBMM   octopus-merge
>   R RY B M
[...]
> which is admittedly pretty horrible, too, but at least resembles a
> graph. I dunno.

Yeah, but it's lossy, so it doesn't seem usable for the test. Maybe
doubling up some characters?

**  left
R|  **B-B-M-M.      octopus-merge
R|  R|Y\  B\  M\
R|R/  Y/  B/  M/
R|  Y|  B|  **  4
R|  Y|  **  M|  3
R|  Y|  M|M/
R|  **  M|  2
R|  M|M/
**  M|  1
M|M/
**  initial

> I'm also not thrilled that we depend on the exact sequence of default
> colors, but I suspect it's not the first time. And it wouldn't be too
> hard to update it if that default changes.

Well, it's easy enough to set the colors explicitly. After doing this
I noticed that green seems to be skipped. Not sure if that's a bug or
not.

> Try not to put "git" on the left-hand side of a pipe, since it means
> we'll miss its exit code

Ok.

> Leftover "debug" cruft?
>
> The same pipe comment applies as above.
>
> > test_done
> > test_done
>
> Two dones; we exit after the first one (so everything after this is
> ignored).

Oops, yeah, this script was still a bit of a rough draft.

> I think it's OK to have a dedicated script for even these two tests, if
> it makes things easier to read. However, would we also want to test the
> octopus without the problematic graph here? I think if we just omit
> "left" we get that, don't we?

t4202-log.sh already does test a "normal" octopus merge (starting
around line 615, search for "octopus-a"). But that is only a 3-parent
merge. And adding another test is easy enough.

--000000000000898f2505775a9c34
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="v5-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Disposition: attachment; 
	filename="v5-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jmtq3s8u0>
X-Attachment-Id: f_jmtq3s8u0

RnJvbSBjZDk0MTViNTI0MzU3YzJjOGI5YjIwYTYzMDMyYzk0ZTAxZDQ2YTE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBTYXQsIDEgU2VwIDIwMTggMjA6MDc6MTYgLTA0MDAKU3ViamVjdDog
W1BBVENIIHY1XSBsb2c6IEZpeCBjb2xvcmluZyBvZiBjZXJ0YWluIG9jdHVwdXMgbWVyZ2Ugc2hh
cGVzCgpGb3Igb2N0b3B1cyBtZXJnZXMgd2hlcmUgdGhlIGZpcnN0IHBhcmVudCBlZGdlIGltbWVk
aWF0ZWx5IG1lcmdlcyBpbnRvCnRoZSBuZXh0IGNvbHVtbiB0byB0aGUgbGVmdDoKCnwgKi0uCnwg
fFwgXAp8LyAvIC8KCnRoZW4gdGhlIG51bWJlciBvZiBjb2x1bW5zIHNob3VsZCBiZSBvbmUgbGVz
cyB0aGFuIHRoZSB1c3VhbCBjYXNlOgoKfCAqLS4KfCB8XCBcCnwgfCB8ICoKCkFsc28gcmVmYWN0
b3IgdGhlIGNvZGUgdG8gaXRlcmF0ZSBvdmVyIGNvbHVtbnMgcmF0aGVyIHRoYW4gZGFzaGVzLApi
dWlsZGluZyBmcm9tIGFuIGluaXRpYWwgcGF0Y2ggc3VnZ2VzdGlvbiBieSBKZWZmIEtpbmcuCgpT
aWduZWQtb2ZmLWJ5OiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNlZm9yZ2Uu
bmV0PgotLS0KIGdyYXBoLmMgICAgICAgICAgICAgICAgICAgICAgfCAgNTYgKysrKysrKysrKysr
KysrKystLS0tLS0tCiB0L3Q0MjE0LWxvZy1ncmFwaC1vY3RvcHVzLnNoIHwgMTAyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTQz
IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNzU1IHQvdDQy
MTQtbG9nLWdyYXBoLW9jdG9wdXMuc2gKCmRpZmYgLS1naXQgYS9ncmFwaC5jIGIvZ3JhcGguYwpp
bmRleCBlMWY2ZDNiZGQuLmEzMzY2ZjZkYSAxMDA2NDQKLS0tIGEvZ3JhcGguYworKysgYi9ncmFw
aC5jCkBAIC04NDIsMjcgKzg0Miw1MyBAQCBzdGF0aWMgdm9pZCBncmFwaF9vdXRwdXRfY29tbWl0
X2NoYXIoc3RydWN0IGdpdF9ncmFwaCAqZ3JhcGgsIHN0cnVjdCBzdHJidWYgKnNiKQogfQogCiAv
KgotICogRHJhdyBhbiBvY3RvcHVzIG1lcmdlIGFuZCByZXR1cm4gdGhlIG51bWJlciBvZiBjaGFy
YWN0ZXJzIHdyaXR0ZW4uCisgKiBEcmF3IHRoZSBob3Jpem9udGFsIGRhc2hlcyBvZiBhbiBvY3Rv
cHVzIG1lcmdlIGFuZCByZXR1cm4gdGhlIG51bWJlciBvZgorICogY2hhcmFjdGVycyB3cml0dGVu
LgogICovCiBzdGF0aWMgaW50IGdyYXBoX2RyYXdfb2N0b3B1c19tZXJnZShzdHJ1Y3QgZ2l0X2dy
YXBoICpncmFwaCwKIAkJCQkgICAgc3RydWN0IHN0cmJ1ZiAqc2IpCiB7CiAJLyoKLQkgKiBIZXJl
IGRhc2hsZXNzX2NvbW1pdHMgcmVwcmVzZW50cyB0aGUgbnVtYmVyIG9mIHBhcmVudHMKLQkgKiB3
aGljaCBkb24ndCBuZWVkIHRvIGhhdmUgZGFzaGVzIChiZWNhdXNlIHRoZWlyIGVkZ2VzIGZpdAot
CSAqIG5lYXRseSB1bmRlciB0aGUgY29tbWl0KS4KLQkgKi8KLQljb25zdCBpbnQgZGFzaGxlc3Nf
Y29tbWl0cyA9IDI7Ci0JaW50IGNvbF9udW0sIGk7Ci0JaW50IG51bV9kYXNoZXMgPQotCQkoKGdy
YXBoLT5udW1fcGFyZW50cyAtIGRhc2hsZXNzX2NvbW1pdHMpICogMikgLSAxOwotCWZvciAoaSA9
IDA7IGkgPCBudW1fZGFzaGVzOyBpKyspIHsKLQkJY29sX251bSA9IChpIC8gMikgKyBkYXNobGVz
c19jb21taXRzICsgZ3JhcGgtPmNvbW1pdF9pbmRleDsKLQkJc3RyYnVmX3dyaXRlX2NvbHVtbihz
YiwgJmdyYXBoLT5uZXdfY29sdW1uc1tjb2xfbnVtXSwgJy0nKTsKKwkgKiBIZXJlIGRhc2hsZXNz
X3BhcmVudHMgcmVwcmVzZW50cyB0aGUgbnVtYmVyIG9mIHBhcmVudHMgd2hpY2ggZG9uJ3QKKwkg
KiBuZWVkIHRvIGhhdmUgZGFzaGVzICh0aGUgZWRnZXMgbGFiZWxlZCAiMCIgYW5kICIxIikuICBB
bmQKKwkgKiBkYXNoZnVsX3BhcmVudHMgYXJlIHRoZSByZW1haW5pbmcgb25lcy4KKwkgKgorCSAq
IHwgKi0tLS4KKwkgKiB8IHxcIFwgXAorCSAqIHwgfCB8IHwgfAorCSAqIHggMCAxIDIgMworCSAq
CisJICovCisJY29uc3QgaW50IGRhc2hsZXNzX3BhcmVudHMgPSAyOworCWludCBkYXNoZnVsX3Bh
cmVudHMgPSBncmFwaC0+bnVtX3BhcmVudHMgLSBkYXNobGVzc19wYXJlbnRzOworCisJLyoKKwkg
KiBVc3VhbGx5LCBlYWNoIHBhcmVudCBnZXRzIGl0cyBvd24gY29sdW1uLCBsaWtlIHRoZSBkaWFn
cmFtIGFib3ZlLCBidXQKKwkgKiBzb21ldGltZXMgdGhlIGZpcnN0IHBhcmVudCBnb2VzIGludG8g
YW4gZXhpc3RpbmcgY29sdW1uLCBsaWtlIHRoaXM6CisJICoKKwkgKiB8ICotLS0uCisJICogfCB8
XCBcIFwKKwkgKiB8LyAvIC8gLworCSAqIHggMCAxIDIKKwkgKgorCSAqIEluIHdoaWNoIGNhc2Ug
dGhlcmUgd2lsbCBiZSBtb3JlIHBhcmVudHMgdGhhbiB0aGUgZGVsdGEgb2YgY29sdW1ucy4KKwkg
Ki8KKwlpbnQgZGVsdGFfY29scyA9IChncmFwaC0+bnVtX25ld19jb2x1bW5zIC0gZ3JhcGgtPm51
bV9jb2x1bW5zKTsKKwlpbnQgcGFyZW50X2luX29sZF9jb2xzID0gZ3JhcGgtPm51bV9wYXJlbnRz
IC0gZGVsdGFfY29sczsKKworCS8qCisJICogSW4gYm90aCBjYXNlcywgY29tbWl0X2luZGV4IGNv
cnJlc3BvbmRzIHRvIHRoZSBlZGdlIGxhYmVsZWQgIjAiLgorCSAqLworCWludCBmaXJzdF9jb2wg
PSBncmFwaC0+Y29tbWl0X2luZGV4ICsgZGFzaGxlc3NfcGFyZW50cworCSAgICAtIHBhcmVudF9p
bl9vbGRfY29sczsKKworCWludCBpOworCWZvciAoaSA9IDA7IGkgPCBkYXNoZnVsX3BhcmVudHM7
IGkrKykgeworCQlzdHJidWZfd3JpdGVfY29sdW1uKHNiLCAmZ3JhcGgtPm5ld19jb2x1bW5zW2kr
Zmlyc3RfY29sXSwgJy0nKTsKKwkJc3RyYnVmX3dyaXRlX2NvbHVtbihzYiwgJmdyYXBoLT5uZXdf
Y29sdW1uc1tpK2ZpcnN0X2NvbF0sCisJCQkJICAgIGkgPT0gZGFzaGZ1bF9wYXJlbnRzLTEgPyAn
LicgOiAnLScpOwogCX0KLQljb2xfbnVtID0gKGkgLyAyKSArIGRhc2hsZXNzX2NvbW1pdHMgKyBn
cmFwaC0+Y29tbWl0X2luZGV4OwotCXN0cmJ1Zl93cml0ZV9jb2x1bW4oc2IsICZncmFwaC0+bmV3
X2NvbHVtbnNbY29sX251bV0sICcuJyk7Ci0JcmV0dXJuIG51bV9kYXNoZXMgKyAxOworCXJldHVy
biAyICogZGFzaGZ1bF9wYXJlbnRzOwogfQogCiBzdGF0aWMgdm9pZCBncmFwaF9vdXRwdXRfY29t
bWl0X2xpbmUoc3RydWN0IGdpdF9ncmFwaCAqZ3JhcGgsIHN0cnVjdCBzdHJidWYgKnNiKQpkaWZm
IC0tZ2l0IGEvdC90NDIxNC1sb2ctZ3JhcGgtb2N0b3B1cy5zaCBiL3QvdDQyMTQtbG9nLWdyYXBo
LW9jdG9wdXMuc2gKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAwMDAwLi5kYWI5NmM4
OWEKLS0tIC9kZXYvbnVsbAorKysgYi90L3Q0MjE0LWxvZy1ncmFwaC1vY3RvcHVzLnNoCkBAIC0w
LDAgKzEsMTAyIEBACisjIS9iaW4vc2gKKwordGVzdF9kZXNjcmlwdGlvbj0nZ2l0IGxvZyAtLWdy
YXBoIG9mIHNrZXdlZCBsZWZ0IG9jdG9wdXMgbWVyZ2UuJworCisuIC4vdGVzdC1saWIuc2gKKwor
dGVzdF9leHBlY3Rfc3VjY2VzcyAnc2V0IHVwIG1lcmdlIGhpc3RvcnknICcKKwljYXQgPmV4cGVj
dC51bmNvbG9yZWQgPDwtXEVPRiAmJgorCSogbGVmdAorCXwgKi0tLS4gICBvY3RvcHVzLW1lcmdl
CisJfCB8XCBcIFwKKwl8LyAvIC8gLworCXwgfCB8ICogNAorCXwgfCAqIHwgMworCXwgfCB8Lwor
CXwgKiB8IDIKKwl8IHwvCisJKiB8IDEKKwl8LworCSogaW5pdGlhbAorCUVPRgorCWNhdCA+ZXhw
ZWN0LmNvbG9ycyA8PC1cRU9GICYmCisJKiBsZWZ0CisJPFJFRD58PFJFU0VUPiAqPEJMVUU+LTxS
RVNFVD48QkxVRT4tPFJFU0VUPjxNQUdFTlRBPi08UkVTRVQ+PE1BR0VOVEE+LjxSRVNFVD4gICBv
Y3RvcHVzLW1lcmdlCisJPFJFRD58PFJFU0VUPiA8UkVEPnw8UkVTRVQ+PFlFTExPVz5cPFJFU0VU
PiA8QkxVRT5cPFJFU0VUPiA8TUFHRU5UQT5cPFJFU0VUPgorCTxSRUQ+fDxSRVNFVD48UkVEPi88
UkVTRVQ+IDxZRUxMT1c+LzxSRVNFVD4gPEJMVUU+LzxSRVNFVD4gPE1BR0VOVEE+LzxSRVNFVD4K
Kwk8UkVEPnw8UkVTRVQ+IDxZRUxMT1c+fDxSRVNFVD4gPEJMVUU+fDxSRVNFVD4gKiA0CisJPFJF
RD58PFJFU0VUPiA8WUVMTE9XPnw8UkVTRVQ+ICogPE1BR0VOVEE+fDxSRVNFVD4gMworCTxSRUQ+
fDxSRVNFVD4gPFlFTExPVz58PFJFU0VUPiA8TUFHRU5UQT58PFJFU0VUPjxNQUdFTlRBPi88UkVT
RVQ+CisJPFJFRD58PFJFU0VUPiAqIDxNQUdFTlRBPnw8UkVTRVQ+IDIKKwk8UkVEPnw8UkVTRVQ+
IDxNQUdFTlRBPnw8UkVTRVQ+PE1BR0VOVEE+LzxSRVNFVD4KKwkqIDxNQUdFTlRBPnw8UkVTRVQ+
IDEKKwk8TUFHRU5UQT58PFJFU0VUPjxNQUdFTlRBPi88UkVTRVQ+CisJKiBpbml0aWFsCisJRU9G
CisJdGVzdF9jb21taXQgaW5pdGlhbCAmJgorCWZvciBpIGluIDEgMiAzIDQgOyBkbworCQlnaXQg
Y2hlY2tvdXQgbWFzdGVyIC1iICRpIHx8IHJldHVybiAkPworCQkjIE1ha2UgdGFnIG5hbWUgZGlm
ZmVyZW50IGZyb20gYnJhbmNoIG5hbWUsIHRvIGF2b2lkCisJCSMgYW1iaWd1aXR5IGVycm9yIHdo
ZW4gY2FsbGluZyBjaGVja291dC4KKwkJdGVzdF9jb21taXQgJGkgJGkgJGkgdGFnJGkgfHwgcmV0
dXJuICQ/CisJZG9uZSAmJgorCWdpdCBjaGVja291dCAxIC1iIG1lcmdlICYmCisJdGVzdF90aWNr
ICYmCisJZ2l0IG1lcmdlIC1tIG9jdG9wdXMtbWVyZ2UgMSAyIDMgNCAmJgorCWdpdCBjaGVja291
dCAxIC1iIEwgJiYKKwl0ZXN0X2NvbW1pdCBsZWZ0CisnCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3Mg
J2xvZyAtLWdyYXBoIHdpdGggdHJpY2t5IG9jdG9wdXMgbWVyZ2Ugd2l0aCBjb2xvcnMnICcKKwl0
ZXN0X2NvbmZpZyBsb2cuZ3JhcGhDb2xvcnMgcmVkLGdyZWVuLHllbGxvdyxibHVlLG1hZ2VudGEs
Y3lhbiAmJgorCWdpdCBsb2cgLS1jb2xvcj1hbHdheXMgLS1ncmFwaCAtLWRhdGUtb3JkZXIgLS1w
cmV0dHk9dGZvcm1hdDolcyAtLWFsbCA+YWN0dWFsLmNvbG9ycy5yYXcgJiYKKwl0ZXN0X2RlY29k
ZV9jb2xvciA8YWN0dWFsLmNvbG9ycy5yYXcgfCBzZWQgInMvICpcJC8vIiA+YWN0dWFsLmNvbG9y
cyAmJgorCXRlc3RfY21wIGV4cGVjdC5jb2xvcnMgYWN0dWFsLmNvbG9ycworJworCit0ZXN0X2V4
cGVjdF9zdWNjZXNzICdsb2cgLS1ncmFwaCB3aXRoIHRyaWNreSBvY3RvcHVzIG1lcmdlLCBubyBj
b2xvcicgJworCWdpdCBsb2cgLS1jb2xvcj1uZXZlciAtLWdyYXBoIC0tZGF0ZS1vcmRlciAtLXBy
ZXR0eT10Zm9ybWF0OiVzIC0tYWxsID5hY3R1YWwucmF3ICYmCisJc2VkICJzLyAqXCQvLyIgYWN0
dWFsLnJhdyA+YWN0dWFsICYmCisJdGVzdF9jbXAgZXhwZWN0LnVuY29sb3JlZCBhY3R1YWwKKycK
KworIyBSZXBlYXQgdGhlIHByZXZpb3VzIHR3byB0ZXN0cyB3aXRoICJub3JtYWwiIG9jdG9wdXMg
bWVyZ2UgKGkuZS4sCisjIHdpdGhvdXQgdGhlIGZpcnN0IHBhcmVudCBza2V3aW5nIHRvIHRoZSAi
bGVmdCIgYnJhbmNoIGNvbHVtbikuCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2xvZyAtLWdyYXBo
IHdpdGggbm9ybWFsIG9jdG9wdXMgbWVyZ2UsIG5vIGNvbG9yJyAnCisJY2F0ID5leHBlY3QudW5j
b2xvcmVkIDw8LVxFT0YgJiYKKwkqLS0tLiAgIG9jdG9wdXMtbWVyZ2UKKwl8XCBcIFwKKwl8IHwg
fCAqIDQKKwl8IHwgKiB8IDMKKwl8IHwgfC8KKwl8ICogfCAyCisJfCB8LworCSogfCAxCisJfC8K
KwkqIGluaXRpYWwKKwlFT0YKKwlnaXQgbG9nIC0tY29sb3I9bmV2ZXIgLS1ncmFwaCAtLWRhdGUt
b3JkZXIgLS1wcmV0dHk9dGZvcm1hdDolcyBtZXJnZSA+YWN0dWFsLnJhdyAmJgorCXNlZCAicy8g
KlwkLy8iIGFjdHVhbC5yYXcgPmFjdHVhbCAmJgorCXRlc3RfY21wIGV4cGVjdC51bmNvbG9yZWQg
YWN0dWFsCisnCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2xvZyAtLWdyYXBoIHdpdGggbm9ybWFs
IG9jdG9wdXMgbWVyZ2Ugd2l0aCBjb2xvcnMnICcKKwljYXQgPmV4cGVjdC5jb2xvcnMgPDwtXEVP
RiAmJgorCSo8WUVMTE9XPi08UkVTRVQ+PFlFTExPVz4tPFJFU0VUPjxCTFVFPi08UkVTRVQ+PEJM
VUU+LjxSRVNFVD4gICBvY3RvcHVzLW1lcmdlCisJPFJFRD58PFJFU0VUPjxHUkVFTj5cPFJFU0VU
PiA8WUVMTE9XPlw8UkVTRVQ+IDxCTFVFPlw8UkVTRVQ+CisJPFJFRD58PFJFU0VUPiA8R1JFRU4+
fDxSRVNFVD4gPFlFTExPVz58PFJFU0VUPiAqIDQKKwk8UkVEPnw8UkVTRVQ+IDxHUkVFTj58PFJF
U0VUPiAqIDxCTFVFPnw8UkVTRVQ+IDMKKwk8UkVEPnw8UkVTRVQ+IDxHUkVFTj58PFJFU0VUPiA8
QkxVRT58PFJFU0VUPjxCTFVFPi88UkVTRVQ+CisJPFJFRD58PFJFU0VUPiAqIDxCTFVFPnw8UkVT
RVQ+IDIKKwk8UkVEPnw8UkVTRVQ+IDxCTFVFPnw8UkVTRVQ+PEJMVUU+LzxSRVNFVD4KKwkqIDxC
TFVFPnw8UkVTRVQ+IDEKKwk8QkxVRT58PFJFU0VUPjxCTFVFPi88UkVTRVQ+CisJKiBpbml0aWFs
CisJRU9GCisJdGVzdF9jb25maWcgbG9nLmdyYXBoQ29sb3JzIHJlZCxncmVlbix5ZWxsb3csYmx1
ZSxtYWdlbnRhLGN5YW4gJiYKKwlnaXQgbG9nIC0tY29sb3I9YWx3YXlzIC0tZ3JhcGggLS1kYXRl
LW9yZGVyIC0tcHJldHR5PXRmb3JtYXQ6JXMgbWVyZ2UgPmFjdHVhbC5jb2xvcnMucmF3ICYmCisJ
dGVzdF9kZWNvZGVfY29sb3IgPGFjdHVhbC5jb2xvcnMucmF3IHwgc2VkICJzLyAqXCQvLyIgPmFj
dHVhbC5jb2xvcnMgJiYKKwl0ZXN0X2NtcCBleHBlY3QuY29sb3JzIGFjdHVhbC5jb2xvcnMKKycK
K3Rlc3RfZG9uZQotLSAKMi4xMS4wCgo=
--000000000000898f2505775a9c34--
