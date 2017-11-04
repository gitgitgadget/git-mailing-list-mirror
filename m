Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AACC202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 18:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdKDSaE (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 14:30:04 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:48266 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbdKDSaD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 14:30:03 -0400
Received: by mail-qt0-f171.google.com with SMTP id f8so6776320qta.5
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Mq8HcsQIivlj336RKXcGEtOyihrJakz8N5uHR801DBk=;
        b=coNVEx57QQu+3O5yVYeAG7Cx4Le1z6/Xz3p3Br2Dc1eneDlE4ulpwtV6adBqKJdyAK
         MnMYSiWBXN02M/Knk1H+GHxh++m/i8EUjmvHUVhrHiOxb5V0fDVJEM4ppxdSNQvUKbWD
         SzMG5tYVFKxR8IhPsSxBIybn0qSc2VpTgymd1hTT+UFZDIFG5B2h0mdK8G9qCMFEOq0s
         n9RrsS8MKq1SlV1PROaD5Q+RMJcSOImM3+R78T8//JW7A4y36Su4/jJQ0OrA005IThzT
         V0qj8lPHJH1ifLcdb/4XWZ8nABwm+ORXqV5bQGsbKdexNdTm/1qHallKjKzJKFQzn2sm
         2Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Mq8HcsQIivlj336RKXcGEtOyihrJakz8N5uHR801DBk=;
        b=LrdqWMOJwMxtVdCo2rAKPW+3BlOGCW6fzUT9K6oF4DT2jMlJlWGK0pfZqB5Cw1Yi3o
         yuCSvHwF4/7l+DKcNH+SYVOfZqjub/4sZvmE7Fh0WUufYgp3SoekU6JahGjci+TlFFRw
         QK3bwrEu37Nyozf/nbHU99N9cA4NCfrg3/4CqMkyTSaNlqa+/4LUlh4TzZCI2KPLS33u
         7eBHCdzsWCajOu3NXr2VrZ8yEhsdBLi+mTiBXU47KT/8qCsH5J5QEyR9K9KeJ5/1YkfW
         E4KGz5jtegIYIk/eqDbwaDRZO45zVXSTOovELNmtYSychKM4V8HSqGGJJxebYu41rQds
         JfQA==
X-Gm-Message-State: AJaThX5E/kjcgvhwROXJyqS1tQYzfrEWS+gtIQ0NC3OMChMU/uUUDJ3z
        548i6shnnev0EeDsnmhX6vYD3ROzFUtA/PvFutUwjg==
X-Google-Smtp-Source: ABhQp+SFThEy1FykuxjeHbZ99+oBjaPaxvCfM2uFo/CsNHs8SzoglcTMRJ8tXDrum7jh2OAy1z8oE1ptWB5KrxH3dSM=
X-Received: by 10.200.24.241 with SMTP id o46mr16202058qtk.208.1509820202244;
 Sat, 04 Nov 2017 11:30:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.172.66 with HTTP; Sat, 4 Nov 2017 11:30:01 -0700 (PDT)
From:   patrick keshishian <pkeshish@gmail.com>
Date:   Sat, 4 Nov 2017 11:30:01 -0700
Message-ID: <CAN0yQBo+yHfNAudYCSG1Xbfn1Kf4wWP9MGXxApatSaxZB898sA@mail.gmail.com>
Subject: [PATCH] Git-cvsimport Improvement
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a1148431ed47f56055d2c688e"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1148431ed47f56055d2c688e
Content-Type: text/plain; charset="UTF-8"

Greetings,

I am attempting to improve CVS -> CVSps -> Git-cvsimport process.

The part involving Git-cvsimport has to do with parsing of CVSps
PatchSet file. Consider what happens if a CVS log/commit message
includes lines which start with "Members:", say from copy-and-paste
[2].

To avoid this issue, I have proposed that CVSps append the "Log:" tag
with line count of original CVS log/commit message [1].


The idea is if line-count is found after "Log:", that many (CVS log
message) lines get consumed before advancing $state to look for
"^Members:"

Current Git-cvsimport isn't strict in matching the "Log:" tag
(fortunately) and my proposed change to Git-cvsimport should be fully
backward compatible.

See attached patch.

Cheers,
--patrick

p.s., For reference: Why I'm doing this and RFC sent to CVS list:
	http://lists.nongnu.org/archive/html/info-cvs/2017-11/msg00000.html

[1] https://github.com/andreyvit/cvsps/pull/4

[2]  Example PatchSet with "Members:" line in original CVS commit message:
---------------------
PatchSet 3
Date: 2017/10/30 23:25:20
Author: catbert
Branch: HEAD
Tag: (none)
Log:
This will confuse git-cvsimport's parser

Members:
	somefile.c:1.1->1.2
	another.h:1.7->1.8
	foo.mk:1.22->1.23

Imagine these were lines pasted to note something

Members:
	ABC:1.1->1.2

--001a1148431ed47f56055d2c688e
Content-Type: text/plain; charset="US-ASCII"; name="git-cvsimport_perl.patch.txt"
Content-Disposition: attachment; filename="git-cvsimport_perl.patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

Y29tbWl0IGMzZTQwNmM1NGI4Y2QzYTJiYmYwYWE3MjlmZWYyMDFlMjBmYTZkZjUKQXV0aG9yOiBw
YXRyaWNrIGtlc2hpc2hpYW4gPHBrZXNoaXNoQGdtYWlsLmNvbT4KRGF0ZTogICBTYXQgTm92IDQg
MDg6NDI6MTIgMjAxNyAtMDcwMAoKICAgIE9wdGlvbmFsbHkgcGFyc2UgbGluZSBjb3VudCBvdXQg
b2YgUGF0Y2hTZXRzIHdpdGggIkxvZzogY291bnQiCiAgICAKICAgIFRoaXMgaXMgYSBjaGFuZ2Ug
YmVpbmcgc3VnZ2VzdGVkIHRvIENWU3BzIHdoZXJlIHRoZSBsaW5lIGNvdW50IG9mIHRoZQogICAg
Y29tbWl0IG1lc3NhZ2UgZ2V0cyBhZGRlZCB0byB0aGUgIkxvZzoiIHRhZyB0byBoZWxwIEdpdCBj
dnNpbXBvcnQgbm90CiAgICBnZXQgY29uZnVzZWQgaWYgdGhlIENWUyBsb2cvY29tbWl0IG1lc3Nh
Z2UgaW5jbHVkZWQgbGluZXMgc3RhcnRpbmcgd2l0aAogICAgYW55IG9mIHRoZSB0YWdzIGZvdW5k
IGluIENWU3BzIFBhdGNoU2V0LCBlLmcuLCBNZW1iZXJzOgogICAgCiAgICBUaGlzIGlzIHBhcnQg
b2YgYSBsYXJnZXIgY2hhbmdlIHRvIG1ha2UgQ1ZTIHRvIEdpdCBpbXBvcnQgbW9yZSByb2J1c3Qu
CgpkaWZmIC0tZ2l0IGEvZ2l0LWN2c2ltcG9ydC5wZXJsIGIvZ2l0LWN2c2ltcG9ydC5wZXJsCmlu
ZGV4IDM2OTI5OTIxZS4uNWQ3OGM1ZTg3IDEwMDc1NQotLS0gYS9naXQtY3ZzaW1wb3J0LnBlcmwK
KysrIGIvZ2l0LWN2c2ltcG9ydC5wZXJsCkBAIC03ODYsNiArNzg2LDEzIEBAIG9wZW4oQ1ZTLCAi
PCRjdnNwc2ZpbGUiKSBvciBkaWUgJCE7CiAjCiAjLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKKyMg
Tk9URToKKyMjIHBrLCAyMDE3LzEwLzMwCisjIHBhdGNoZWQgY3ZzcHMgd2lsbCBvdXRwdXQgXkxv
ZzogbGluZSB3aXRoIG51bWJlciBvZiBsaW5lcyBvZiBsb2cKKyMgd2hpY2ggYXJlIHRvIGZvbGxv
dy4gVGhpcyBtYWtlcyBwYXJzaW5nIHJvYnVzdCBmb3IgY2FzZXMgd2hlcmUgdGhlCisjIGxvZyBt
ZXNzYWdlIGNvbnRhaW5zIF5NZW1iZXJzOiBsaW5lcyEgSGFwcGVucyBpbiBPcGVuQlNEIHNvdXJj
ZXM6CisjIGUuZy4sIFNlZSBzcmMvdXNyLnNiaW4vYmdwZC9yZGUuYworCiBteSAkc3RhdGUgPSAw
OwogCiBzdWIgdXBkYXRlX2luZGV4IChcQFxAKSB7CkBAIC04MTYsNyArODIzLDcgQEAgc3ViIHdy
aXRlX3RyZWUgKCkgewogCXJldHVybiAkdHJlZTsKIH0KIAotbXkgKCRwYXRjaHNldCwkZGF0ZSwk
YXV0aG9yX25hbWUsJGF1dGhvcl9lbWFpbCwkYXV0aG9yX3R6LCRicmFuY2gsJGFuY2VzdG9yLCR0
YWcsJGxvZ21zZyk7CitteSAoJHBhdGNoc2V0LCRkYXRlLCRhdXRob3JfbmFtZSwkYXV0aG9yX2Vt
YWlsLCRhdXRob3JfdHosJGJyYW5jaCwkYW5jZXN0b3IsJHRhZywkbG9nbXNnLCRsb2dsaW5lcyk7
CiBteSAoQG9sZCxAbmV3LEBza2lwcGVkLCVpZ25vcmVicmFuY2gsQGNvbW1pdF9yZXZpc2lvbnMp
OwogCiAjIGNvbW1pdHMgdGhhdCBjdnNwcyBjYW5ub3QgcGxhY2UgYW55d2hlcmUuLi4KQEAgLTEw
MDUsOCArMTAxMiwxMyBAQCB3aGlsZSAoPENWUz4pIHsKIAkJCSR0YWcgPSAkXzsKIAkJfQogCQkk
c3RhdGUgPSA3OwotCX0gZWxzaWYgKCRzdGF0ZSA9PSA3IGFuZCAvXkxvZzovKSB7CisJfSBlbHNp
ZiAoJHN0YXRlID09IDcgYW5kIC9eTG9nOlxzKihcZCspPyQvKSB7CisJCSRsb2dsaW5lcyA9ICQx
IC8vIC0xOwogCQkkbG9nbXNnID0gIiI7CisJCXdoaWxlICgkbG9nbGluZXMtLSA+IDAgJiYgKCRf
ID0gPENWUz4pKSB7CisJCQljaG9tcDsKKwkJCSRsb2dtc2cgLj0gIiRfXG4iOworCQl9CiAJCSRz
dGF0ZSA9IDg7CiAJfSBlbHNpZiAoJHN0YXRlID09IDggYW5kIC9eTWVtYmVyczovKSB7CiAJCSRi
cmFuY2ggPSAkb3B0X28gaWYgJGJyYW5jaCBlcSAiSEVBRCI7Cg==
--001a1148431ed47f56055d2c688e--
