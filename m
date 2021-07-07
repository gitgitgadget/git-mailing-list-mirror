Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC73C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D3861C44
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 13:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhGGNXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 09:23:03 -0400
Received: from mail02.x-net.at ([83.65.141.138]:39138 "EHLO mail02.x-net.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhGGNXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 09:23:03 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 09:23:02 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail02.x-net.at (Postfix) with ESMTP id 6D8B2380438
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 15:13:45 +0200 (CEST)
Received: from mail02.x-net.at ([127.0.0.1])
        by localhost (mail02.x-net.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uQS-2Fhwo7ET for <git@vger.kernel.org>;
        Wed,  7 Jul 2021 15:13:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail02.x-net.at (Postfix) with ESMTP id 06E52380443
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 15:13:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at x-t.at
Received: from mail02.x-net.at ([127.0.0.1])
        by localhost (mail02.x-net.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cKHKBX6NrFlg for <git@vger.kernel.org>;
        Wed,  7 Jul 2021 15:13:44 +0200 (CEST)
Received: from [127.0.0.1] (178.115.41.35.wireless.dyn.drei.com [178.115.41.35])
        by mail02.x-net.at (Postfix) with ESMTPSA id BECE5380440
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 15:13:44 +0200 (CEST)
Date:   Wed, 07 Jul 2021 15:13:46 +0200
From:   Mel Dafert <mel@dafert.at>
To:     git@vger.kernel.org
Subject: Bug with branches/merges in submodules
User-Agent: K-9 Mail for Android
Message-ID: <E9E32A45-DA88-47CB-B7F9-F01F9BEC394C@dafert.at>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary=----EQBX7VL05V8N5OHRUJE550BOOAQRXM
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------EQBX7VL05V8N5OHRUJE550BOOAQRXM
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I ran into a bug where commits are omitted from `git submodule summary`
and friends when the submodule contains merge commits=2E
Originally using 2=2E30=2E2, I can also reproduce this with a fresh build =
on the
`next` branch (see attached bugreport)=2E
I would assume that this is not intentional, however I cannot find any rel=
evant
information on this=2E
Feel free to contact me for extra details=2E
Best regards,
Mel
------EQBX7VL05V8N5OHRUJE550BOOAQRXM
Content-Type: text/plain;
 name=git-bugreport-2021-07-07-1419.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=git-bugreport-2021-07-07-1419.txt;
 size=2209

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpClNldCB1cCBhIHN1Ym1vZHVsZSB0aGF0IGhhcyBicmFuY2hlcy9t
ZXJnZSBjb21taXRzOgpgYGBiYXNoCiMgY3JlYXRlIHJlcG9zaXRvcnkgImNoaWxkIgpta2RpciBj
aGlsZC1yZXBvCmNkIGNoaWxkLXJlcG8KZ2l0IGluaXQKdG91Y2ggaW5pdGlhbC50eHQKZ2l0IGFk
ZCBpbml0aWFsLnR4dApnaXQgY29tbWl0IC1tICJpbml0aWFsIGNoaWxkIgpjZCAuLgojIGNyZWF0
ZSByZXBvc2l0b3J5ICJwYXJlbnQiCm1rZGlyIHBhcmVudApjZCBwYXJlbnQKZ2l0IGluaXQKIyBh
ZGQgc3VibW9kdWxlICJjaGlsZCIgdG8gcmVwb3NpdG9yeSAicGFyZW50IgpnaXQgc3VibW9kdWxl
IGFkZCAuLi9jaGlsZC1yZXBvLyBjaGlsZApnaXQgY29tbWl0IC1hbSAiaW5pdGlhbCBwYXJlbnQi
CmNkIGNoaWxkCiMgbWFrZSB0d28gY29tbWl0cyBpbiBzZXBhcmF0ZSBicmFuY2hlcyBpbiAiY2hp
bGQiCmdpdCBzd2l0Y2ggLWMgInNlY29uZGFyeSIKdG91Y2ggczEudHh0CmdpdCBhZGQgczEudHh0
CmdpdCBjb21taXQgLW0gInMxIgpnaXQgc3dpdGNoIG1hc3Rlcgp0b3VjaCBtMS50eHQKZ2l0IGFk
ZCBtMS50eHQKZ2l0IGNvbW1pdCAtbSAibTEiCiMgbWVyZ2UgYnJhbmNoICJzZWNvbmRhcnkiIGlu
dG8gIm1hc3RlciIgaW4gImNoaWxkIiAtIHRoaXMgY3JlYXRlcyBhIG1lcmdlIGNvbW1pdApnaXQg
bWVyZ2Ugc2Vjb25kYXJ5IC0tbm8tZWRpdApjZCAuLgpgYGAKUnVuIGBnaXQgZGlmZiAtLXN1Ym1v
ZHVsZT1sb2dgIGluc2lkZSB0aGUgInBhcmVudCIgcmVwb3NpdG9yeS4KCldoYXQgZGlkIHlvdSBl
eHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCmBnaXQgZGlmZiAtLXN1Ym1vZHVs
ZT1sb2dgIHNob3VsZCBzaG93IGFsbCB0aHJlZSBjb21taXRzIGFkZGVkIHRvIHRoZSAiY2hpbGQi
CnN1Ym1vZHVsZToKYGBgClN1Ym1vZHVsZSBjaGlsZCBYWFhYWFhYLi5ZWVlZWVlZCj4gTWVyZ2Ug
YnJhbmNoICdzZWNvbmRhcnknCj4gbTEKPiBzMQpgYGAKCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8g
KEFjdHVhbCBiZWhhdmlvcikKYGdpdCBkaWZmIC0tc3VibW9kdWxlPWxvZ2Agb25seSBzaG93cyBj
b21taXRzIGZyb20gb25lIGFuY2VzdG9yIG9mIHRoZSBtZXJnZQpjb21taXQ6CmBgYApTdWJtb2R1
bGUgY2hpbGQgWFhYWFhYWC4uWVlZWVlZWQo+IE1lcmdlIGJyYW5jaCAnc2Vjb25kYXJ5Jwo+IG0x
CmBgYAoKV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0
IGFjdHVhbGx5IGhhcHBlbmVkPwpBbGwgdGhlIGNvbW1pdHMgYWRkZWQgdG8gdGhlICJzZWNvbmRh
cnkiIGJyYW5jaCBhcmUgbWlzc2luZyBpbgpgZ2l0IGRpZmYgLS1zdWJtb2R1bGU9bG9nYC4KCkFu
eXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgpUaGUgY29tbWl0IHJhbmdlIHNob3duIGJ5IGBn
aXQgZGlmZiAtLXN1Ym1vZHVsZT1sb2dgIGlzIGNvcnJlY3Q6CmBjZCBjaGlsZDsgZ2l0IGxvZyBY
WFhYWFhYLi5ZWVlZWVlZYCBzaG93cyB0aGUgY29ycmVjdCBsaXN0IG9mIGNvbW1pdHMuCgpUaGlz
IGJ1ZyBhbHNvIGFmZmVjdHMgYGdpdCBzdWJtb2R1bGUgc3VtbWFyeWAsIGFuZCBgZ2l0IHNob3cg
LS1zdWJtb2R1bGU9bG9nYAphZnRlciB0aGUgY2hhbmdlcyBoYXZlIGJlZW4gY29tbWl0dGVkLgoK
CltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzIuMC4yNjIuZzhjNTgy
ZmNkNjQKY3B1OiB4ODZfNjQKYnVpbHQgZnJvbSBjb21taXQ6IDhjNTgyZmNkNjQzZDEyODAyZTBh
NmQ3ZTMwNzg5MGFhNWI2YjI2ZTEKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9mLXNpemVfdDogOApzaGVs
bC1wYXRoOiAvYmluL3NoCnVuYW1lOiBMaW51eCA1LjExLjAtMjItZ2VuZXJpYyAjMjMtVWJ1bnR1
IFNNUCBUaHUgSnVuIDE3IDAwOjM0OjIzIFVUQyAyMDIxIHg4Nl82NApjb21waWxlciBpbmZvOiBn
bnVjOiAxMC4zCmxpYmMgaW5mbzogZ2xpYmM6IDIuMzMKJFNIRUxMICh0eXBpY2FsbHksIGludGVy
YWN0aXZlIHNoZWxsKTogL2Jpbi9iYXNoCgoKW0VuYWJsZWQgSG9va3NdCg==

------EQBX7VL05V8N5OHRUJE550BOOAQRXM--
