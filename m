Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E731F461
	for <e@80x24.org>; Fri, 17 May 2019 07:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfEQHag (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 03:30:36 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34517 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfEQHag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 03:30:36 -0400
Received: by mail-pf1-f181.google.com with SMTP id n19so3267576pfa.1
        for <git@vger.kernel.org>; Fri, 17 May 2019 00:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TQYuRxJnblnzHFSAPLbGJA9cT3oKRsfOEm2/P8UnbnE=;
        b=AECo973gLE1XYBLStnM19LYjEBYatPmT031/kJ6DW7xqUya0b1P6ddcXTbfzqzGRoW
         u7WJun/COdKLxyy4g180hsvlY/vXnsWN0khXXr/jFDPeaBcadBmkqK5Y0wpl1A1V0jLc
         rRJ6iEZddDmKz4FB+DT/sKqwHngt71S53+xEj4gUeRgIbw61n7qDRh1/vAF6DDVfYp09
         4vY7aQkVFa90R636fbQaC/E3iUH8VPyd3wDtJAEWURBAjKXq+TrvAjCyq2LrwgiKZFhu
         OcCWIH7K0UtBwbCNimsj5IFgcmzF1AU/iE7RtGUA4DIQLJoqD6sfMfJ1JNumv8a/EPcj
         mNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TQYuRxJnblnzHFSAPLbGJA9cT3oKRsfOEm2/P8UnbnE=;
        b=M+SJTKyoyOYCkey/pLUp5v+YG5P/v33Snm/8DKJrF4D/YLgUXG+16tndY87gmPh54n
         GmeMpN1Cs+xtnElg1xL07QGmoVWXzEm3P5sy9kcyUoN5sYCzSiGKzpcx+DvyNO2ssSSM
         zT4RmA6B2aEHveP7r+og2yeLt46EJeo7dO1h5D8S7rQi+9lwN9xOJndZRVGvlQHqd7AE
         O/o1GZ/yhpnqlA4X6hCImjxGt4R4HPy5Y/CVKqKHFMF5WQHWyqLir+7txG+puoGkp3to
         lq8txA4wapIENSk4ITxUpWBgtTakPOhjBrr24JOpoHTQzutwNv71XbgBeRVZjaTqETLw
         1jIg==
X-Gm-Message-State: APjAAAXh+srL9DBn35YO21FRwYn8ZXvvMCxXYkKi/d42VQUuRTAmrSRK
        6XQ55o1JFMP8dXVXZMfYetcHluX+TCp5G9k+EzdEQA==
X-Google-Smtp-Source: APXvYqzT/Vm/b2MyFudmWHe7+CI2lOpgMcNvm+ty141HF3wXz4M9Fm6/glAUyNN214oExfiwOgXVGbqQI0YF1vxGRWQ=
X-Received: by 2002:aa7:8243:: with SMTP id e3mr59182856pfn.213.1558078235146;
 Fri, 17 May 2019 00:30:35 -0700 (PDT)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Fri, 17 May 2019 09:30:23 +0200
Message-ID: <CAGqZTUvTg5S_-i9JjOwEG75CY+xFXJHAwTqh8uLG3SQTa3O0YA@mail.gmail.com>
Subject: getting pull/push/fetch url
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bdbaed0589105be1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000bdbaed0589105be1
Content-Type: text/plain; charset="UTF-8"

Hello,

for my app, i need to be able get remote urls (fetch/pull/push) so
that i can derive some information from those, e.g. pull url netloc
from which i derive where other custom endpoints (binary file storage)
related to the remote git repo is located. This is just one example. I
am also using fetch url to store it into the composed package that i
generate by the app.

...And I also want to support git down to 1.7.1 (maybe i could live
with 1.8.3, not sure now)

Now, the problem is that getting those urls (fetch/pull/push) doesn't
seem to be an easy task. Currently i have the attached scripts to do
that. But i noticed that older gits like 1.7 use origin as a fallback
for pull url whereas the newer raise an error.

My question is if there is a better way to determine the urls that
would be backward compatible and easier than what i am doing right
now.

I could probably tweak my app to only use fetch url but then i won't
support triangle workflow so i would like to know if there is some
better option.

Thank you
clime

--000000000000bdbaed0589105be1
Content-Type: application/octet-stream; name=git_push_url
Content-Disposition: attachment; filename=git_push_url
Content-Transfer-Encoding: base64
Content-ID: <f_jvrraw3q0>
X-Attachment-Id: f_jvrraw3q0

IyEvYmluL2Jhc2gKCiMgREVTQ1JJUFRJT046CiMKIyBHZXQgYnJhbmNoIHB1c2ggdXJsLgoKZnVu
Y3Rpb24gZ2l0X2JyYW5jaF9wdXNoX3JlbW90ZSB7CiAgICBicmFuY2hfcHVzaF9yZW1vdGU9IiQo
Z2l0IC1DICIkR0lUX1JPT1QiIGNvbmZpZyAtLWdldCBicmFuY2guIiRHSVRfQlJBTkNIIi5wdXNo
UmVtb3RlKSIKCiAgICBpZiBbIC16ICIkYnJhbmNoX3B1c2hfcmVtb3RlIiBdOyB0aGVuCiAgICAg
ICAgYnJhbmNoX3B1c2hfcmVtb3RlPSIkKGdpdCAtQyAiJEdJVF9ST09UIiBjb25maWcgLS1nZXQg
cmVtb3RlLnB1c2hEZWZhdWx0KSIKICAgIGZpCgogICAgaWYgWyAteiAiJGJyYW5jaF9wdXNoX3Jl
bW90ZSIgXTsgdGhlbgogICAgICAgIGJyYW5jaF9wdXNoX3JlbW90ZT0iJChnaXQgLUMgIiRHSVRf
Uk9PVCIgY29uZmlnIC0tZ2V0IGJyYW5jaC4iJEdJVF9CUkFOQ0giLnJlbW90ZSkiCiAgICBmaQoK
ICAgIGVjaG8gIiRicmFuY2hfcHVzaF9yZW1vdGUiCn0KCmZ1bmN0aW9uIGdpdF9icmFuY2hfcHVz
aF91cmwgewogICAgYnJhbmNoX3B1c2hfcmVtb3RlPSIkKGdpdF9icmFuY2hfcHVzaF9yZW1vdGUp
IgoKICAgIHB1c2hfdXJsPSIkKGdpdCAtQyAiJEdJVF9ST09UIiBjb25maWcgLS1nZXQgcmVtb3Rl
LiIkYnJhbmNoX3B1c2hfcmVtb3RlIi5wdXNodXJsKSIKICAgIGlmIFsgLXogIiRwdXNoX3VybCIg
XTsgdGhlbgogICAgICAgIHB1c2hfdXJsPSIkKGdpdCAtQyAiJEdJVF9ST09UIiBjb25maWcgLS1n
ZXQgcmVtb3RlLiIkYnJhbmNoX3B1c2hfcmVtb3RlIi51cmwpIgogICAgZmkKCiAgICBlY2hvICIk
cHVzaF91cmwiCn0KCnVybD0iJChnaXRfYnJhbmNoX3B1c2hfdXJsKSIKCmlmIFsgLW4gIiR1cmwi
IF07IHRoZW4KICAgIGVjaG8gIiR1cmwiCmZpCg==
--000000000000bdbaed0589105be1
Content-Type: application/octet-stream; name=git_pull_url
Content-Disposition: attachment; filename=git_pull_url
Content-Transfer-Encoding: base64
Content-ID: <f_jvrraw4g1>
X-Attachment-Id: f_jvrraw4g1

IyEvYmluL2Jhc2gKCiMgREVTQ1JJUFRJT046CiMKIyBHZXQgYnJhbmNoIHB1bGwgdXJsLgoKZnVu
Y3Rpb24gZ2l0X2JyYW5jaF9yZW1vdGVfdXJsIHsKICAgIGdpdCAtQyAiJEdJVF9ST09UIiBjb25m
aWcgLS1nZXQgcmVtb3RlLiIkKGdpdCAtQyAiJEdJVF9ST09UIiBjb25maWcgLS1nZXQgYnJhbmNo
LiIkR0lUX0JSQU5DSCIucmVtb3RlKSIudXJsCn0KCnVybD0iJChnaXRfYnJhbmNoX3JlbW90ZV91
cmwpIgoKaWYgWyAtbiAiJHVybCIgXTsgdGhlbgogICAgZWNobyAiJHVybCIKZmkK
--000000000000bdbaed0589105be1
Content-Type: application/octet-stream; name=git_fetch_url
Content-Disposition: attachment; filename=git_fetch_url
Content-Transfer-Encoding: base64
Content-ID: <f_jvrraw4t2>
X-Attachment-Id: f_jvrraw4t2

IyEvYmluL2Jhc2gKCiMgREVTQ1JJUFRJT046CiMKIyBHZXQgYnJhbmNoIGZldGNoIHVybCAod2l0
aCBvcmlnaW4gdXJsIGFzIGEgZmFsbGJhY2spLgoKZnVuY3Rpb24gZ2l0X2JyYW5jaF9yZW1vdGVf
dXJsIHsKICAgIGdpdCAtQyAiJEdJVF9ST09UIiBjb25maWcgLS1nZXQgcmVtb3RlLiIkKGdpdCAt
QyAiJEdJVF9ST09UIiBjb25maWcgLS1nZXQgYnJhbmNoLiIkR0lUX0JSQU5DSCIucmVtb3RlKSIu
dXJsCn0KCnVybD0iJChnaXRfYnJhbmNoX3JlbW90ZV91cmwpIgoKaWYgWyAteiAiJHVybCIgXTsg
dGhlbgogICAgdXJsPSIkKGdpdCAtQyAiJEdJVF9ST09UIiBjb25maWcgLS1nZXQgcmVtb3RlLm9y
aWdpbi51cmwpIgpmaQoKaWYgWyAtbiAiJHVybCIgXTsgdGhlbgogICAgZWNobyAiJHVybCIKZmkK
--000000000000bdbaed0589105be1--
