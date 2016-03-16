From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 21:05:01 -0700
Message-ID: <CA+55aFw8roOTTuFknzh3zRkCbgaMGmtxMRk-ctBdJ8Wsu041bA@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113fb6323716b1052e229ece
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 05:05:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag2hx-000658-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 05:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbcCPEFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 00:05:04 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36268 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcCPEFC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 00:05:02 -0400
Received: by mail-io0-f175.google.com with SMTP id z76so49334382iof.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=6MSbeiiViRI/cyJTnCxV+cljMqhRUQy5DlOdaBt4HhE=;
        b=j3GjlxHDBBtflnB49R1vpVEptCLtwSd9gqWvPL/IDdwxRiJbFaHhjkk5HzxMoqYTFZ
         vRsL4DvhTQ/+aqTc/Oju51lE+d0DT59FLz3DhWoMyW+cgw/Qy6gMuKWqeEDqwzz6vI6o
         WkXCgNFYhniiEJWZen5EZsxbMp+CWQ80xcRy0fhhRz7cJWdW3sXNyxp/byt2Kt9wAh0A
         n+bU8mfqG1qjSDz4mub+U+QxeddRl/C7buZ85JkO/PtXMTnN7eO5+P95q8TcGnK8ROHO
         RGiKClFGOLl5Q/g0McfWQ54NIX55KoTIcMATBQuj8/QocYxF0CBVO+xid3wck4IOs3fH
         Orlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=6MSbeiiViRI/cyJTnCxV+cljMqhRUQy5DlOdaBt4HhE=;
        b=Ggna1fbjxMbhWKcF60Dfz+IYReTxPQhboL2yBkOakbpYWv7JhlxdzsC9APDtCsRhTu
         s+27Jo+qWFjzV8D4VcPYPAXnBnXllwlTbHbxWf+/9yJxyTJfvsCJYDVpoGlEziwWHCBa
         6jsTK892lk4WOnEB/zKqDQQY1MHQ+p8tK08GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6MSbeiiViRI/cyJTnCxV+cljMqhRUQy5DlOdaBt4HhE=;
        b=gWHAvGz5UX0fal603FMDKCpMBO07hmKiutdStgBixYaXpNKxXWg7lCXj92oqoKUB4s
         HN3uoVh5LG9zRsdFm+1Rp2SkX2uzryqL4sMaDvucDgHzuLysQYSDXzo5Szcd2GSyMRT3
         9uACMXZiqAWlfdURMMme4ILtkLyRM6XBuXpZ3Dqk9HKWJB9QUhjyvRwtPHiAWvQPzazl
         /2Hnh9wGFcvzGStnpmsNBQVK8k5u6RwDll4Jj9vZxUSYdo57RfQMTmKmS+J+CihTYDtW
         5hJ4NfRUuiD7ih5G3u5HJk5GSYBybGPKKAkrDWv1/uAoH7Ssn/01XEuxchl17XMFFLoh
         3jVQ==
X-Gm-Message-State: AD7BkJKorVMtrlcc9AV4IpKjqb0UVMpLtgSGMndHQdlu7frSNt2UezLKhgtQcKcHs2JenW5I0bFezqO2k+pVow==
X-Received: by 10.107.6.224 with SMTP id f93mr2465377ioi.137.1458101101681;
 Tue, 15 Mar 2016 21:05:01 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Tue, 15 Mar 2016 21:05:01 -0700 (PDT)
In-Reply-To: <CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
X-Google-Sender-Auth: XbwzN-6Us9NELqPxDHLSGc8EW-o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288943>

--001a113fb6323716b1052e229ece
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 15, 2016 at 5:48 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 15, 2016 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Wouldn't it be nicer to do this kind of thing at the output side?  A
>> stupid way would be to have an option to indent the log text with a
>> tab instead of 4-spaces, but a more sensible way would be to keep
>> the visual 4-space-indent and do the expand-tab for each line of
>> text.
>
> Yes, that would certainly work for me too. It's just the "ascii boxes
> don't line up" that is problematic..

Ok, that actually turns out to be pretty easy.

Here's a first try at it. It does tab expansion only for the cases
that indent the commit message, so for things like "pretty=email" it
makes no difference at all.

However, it hardcodes the hardtab size to 8, and makes this all
unconditional. That's how a vt100 terminal works, but fancer terminals
may allow you set actual tab-stops, and if you're in emacs you can
probably do just about anything)

Comments? This does make the kernel commit 0dc8c730c98a look fine, so
it would make me happy.

I can write a commit log etc if people think this is ok, but right now
this is just a silly raw patch in the attachement..

               Linus

--001a113fb6323716b1052e229ece
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilubl77c0

IHByZXR0eS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcHJldHR5LmMgYi9wcmV0
dHkuYwppbmRleCA5MmIyODcwYTdlYWIuLmRjZDYxMDVkMWViMiAxMDA2NDQKLS0tIGEvcHJldHR5
LmMKKysrIGIvcHJldHR5LmMKQEAgLTE2NTIsOCArMTY1MiwyNiBAQCB2b2lkIHBwX3JlbWFpbmRl
cihzdHJ1Y3QgcHJldHR5X3ByaW50X2NvbnRleHQgKnBwLAogCQlmaXJzdCA9IDA7CiAKIAkJc3Ry
YnVmX2dyb3coc2IsIGxpbmVsZW4gKyBpbmRlbnQgKyAyMCk7Ci0JCWlmIChpbmRlbnQpCisJCWlm
IChpbmRlbnQpIHsKKwkJCWludCBpLCBsYXN0ID0gMCwgcG9zID0gMDsKKwogCQkJc3RyYnVmX2Fk
ZGNoYXJzKHNiLCAnICcsIGluZGVudCk7CisJCQlmb3IgKGkgPSAwOyBpIDwgbGluZWxlbjsgaSsr
KSB7CisJCQkJaW50IGV4cGFuZDsKKwkJCQlpZiAobGluZVtpXSAhPSAnXHQnKQorCQkJCQljb250
aW51ZTsKKwkJCQlzdHJidWZfYWRkKHNiLCBsaW5lK2xhc3QsIGktbGFzdCk7CisJCQkJcG9zICs9
IGktbGFzdDsKKwkJCQlleHBhbmQgPSAocG9zICsgOCkgJiB+NzsKKwkJCQlzdHJidWZfYWRkY2hh
cnMoc2IsICcgJywgZXhwYW5kIC0gcG9zKTsKKwkJCQlwb3MgPSBleHBhbmQ7CisJCQkJbGFzdCA9
IGkrMTsKKwkJCX0KKworCQkJLy8gSGFuZGxlIHRoZSB0YWlsIG5vbi10YWIgY29udGVudAorCQkJ
bGluZSArPSBsYXN0OworCQkJbGluZWxlbiAtPSBsYXN0OworCQl9CiAJCXN0cmJ1Zl9hZGQoc2Is
IGxpbmUsIGxpbmVsZW4pOwogCQlzdHJidWZfYWRkY2goc2IsICdcbicpOwogCX0K
--001a113fb6323716b1052e229ece--
