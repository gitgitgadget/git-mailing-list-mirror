From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] remote.c: specify correct plural form in "commit diverge" message
Date: Tue, 3 May 2016 07:20:27 +0700
Message-ID: <CACsJy8C0mFfHQ+GSdJyXLc=SArnxKfZCFV7LJkoqEPs0ekzDZg@mail.gmail.com>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
 <1462234350-30902-1-git-send-email-pclouds@gmail.com> <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	ernesto.alfonsogonzalez@ge.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 02:21:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axO5M-0000zf-FM
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 02:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbcECAVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 20:21:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35361 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbcECAU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 20:20:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id u64so376559lff.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 17:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tzgZvAtQ4W/9OYPUzFQ4rG9Uot0cU/jnTv9t9kVxI0k=;
        b=plV+jW4sVFbCthJPJC7pMVnJUZr/qlWZYNFGhtI7K0t7lUUPs4wUiOeGNs9kc3aRcm
         Zj6fecZntLpHDtjlpcMbTt5A8xIHzhKNAI45LC5aGX2fVF/L687laF+FBIgGn59g6UbV
         IIAuWyDYyCdObfQ8CM+PkJnXL53MTytOqvMgU0xkWq7X+wr1OkQW4HxEmo80pPeVyQBn
         xRtJjTyG5Dq7ILocsc0TJdA9ptHp3hp+wWxQVKKfvDsBktPQvWXB5eJSDVCLJ75/w9j5
         CBJhHnZDCoYGIHZ/GdtkWIhUbmgFDgkPy0u722RcERrt3jKM5OIYkLmwAOY6cxwV5MpE
         jang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzgZvAtQ4W/9OYPUzFQ4rG9Uot0cU/jnTv9t9kVxI0k=;
        b=X63FFRdjw74pIZzzxtjCoyUu1BfBC+4VNpseKcDRIuVZ3iH18W1JvYthQjiG2Fbi3H
         foqg2wDLOkU4RCo60tvDx2uqwf/bONwu5QgH0SII7SNmg9TjdiYsLMJsC6HflkOSz4Up
         SIbALsxXAlPYlwOPvd6E9VePnpCGLu7C/XYAsci7+JzZuuAN6ZTVVQ72DkeUVTHPeBQT
         cP85qknbCKzBsKQm3U5rdFdfeOJ10JHdbEJ4ALbIIorzl9xchTNgZmIIrrY+G7N2TrpC
         5Z8v+PNjO4tRAkM7CnWn7CRp++uql/b2y8bBWrUqFWU0mzMMiKstJGrtiX+ztXvuSXCy
         jYBg==
X-Gm-Message-State: AOPr4FVSaMZe3dkfXPECfZiMopR+eIKcOsa+eKYTOFaYYVi9aOS/YddzGzDEtMZzVh8fpmm3PQGkZ90N6p170w==
X-Received: by 10.25.22.19 with SMTP id m19mr16101626lfi.118.1462234857333;
 Mon, 02 May 2016 17:20:57 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 2 May 2016 17:20:27 -0700 (PDT)
In-Reply-To: <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293312>

On Tue, May 3, 2016 at 7:16 AM, Stefan Beller <sbeller@google.com> wrot=
e:
> On Mon, May 2, 2016 at 5:12 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> We need to count both "ours" and "theirs" commits when selecting plu=
ral
>> form for this message. Note that even though in this block, both our=
s
>> and theirs must be positive (i.e. can't be in singular form), we sti=
ll
>> keep Q_(singular, plural) because languages other than English may h=
ave
>> more than one plural form.
>>
>> Reported-by: Alfonsogonzalez, Ernesto (GE Digital) <ernesto.alfonsog=
onzalez@ge.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  remote.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/remote.c b/remote.c
>> index 28fd676..212426e 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -2108,7 +2108,7 @@ int format_tracking_info(struct branch *branch=
, struct strbuf *sb)
>>                            "Your branch and '%s' have diverged,\n"
>>                                "and have %d and %d different commits=
 each, "
>>                                "respectively.\n",
>> -                          theirs),
>> +                          ours + theirs),
>
> I think it needs to be max(ours, theirs)
>
>     "Your branch and '%s' have diverged,\n"
>     "and have 1 and 1 different commit each, "
>
> so singular for that too, no?

I thought that would be "1 and 1 commits". English is complicated :-D
I don't think Q_() is prepared to deal with this, other languages may
have different interpretation of "x and y" too. But we can at least
make the English version right.
--=20
Duy
