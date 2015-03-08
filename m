From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Sun, 8 Mar 2015 18:15:55 -0400
Message-ID: <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c>
	<CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com>
	<20150308220424.GD4245@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 23:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUjUP-0005iG-7c
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 23:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbCHWP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 18:15:56 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:43187 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbbCHWP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 18:15:56 -0400
Received: by ykbq200 with SMTP id q200so2796051ykb.10
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=8cieOxviOH2+irHFLm5qdmk1xcfTy1ZbLTq1jTJKtCQ=;
        b=s2v7hLHWwpN3EGYtIgt7Vppf5qNhNxCPb+7i9Ao4E6ss/YY728LRGp42Mykx7n7TSR
         Jw1lwVBKgklusWFj8dhCs03rGZcVb66NqAIbz5120JG93Lta+8uU50jrvXxGkofxwLde
         UW17OGBVu0135z9Jtfd4kDdzRd5Q7NMfiDOxsoX9vF/iIQ33kh9Mf+7hvF3uu29c5PGy
         wBg2LQCZYqziPPmq/iYasLYJyqy0lrD77EdiMShlMUTR69dlnDHrGNGHwVQ/8UFRLG4M
         Wlh7hsY1wv8a1FEmi7kJXzBMGWuERAxHspqCVJUKTAkUzU0/IFQbfuMUQ2Zt31gsd5w5
         gKiA==
X-Received: by 10.236.63.6 with SMTP id z6mr24411475yhc.65.1425852955450; Sun,
 08 Mar 2015 15:15:55 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 15:15:55 -0700 (PDT)
In-Reply-To: <20150308220424.GD4245@vauxhall.crustytoothpaste.net>
X-Google-Sender-Auth: nuzUoLfgF5OMmOgBD49acx6nh5s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265114>

On Sun, Mar 8, 2015 at 6:04 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Mar 08, 2015 at 05:43:41PM -0400, Eric Sunshine wrote:
>> On Sun, Mar 8, 2015 at 11:40 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
>>>   Warning: using insecure memory!
>>>
>>> Unfortunately when running the test, that message gets
>>> collected in the stdout result of git show -s --show-signature
>>> but is collected in the stderr result of git verify-commit -v
>>
>> I'm having trouble parsing this. Is there a word missing?
> Perhaps this is better?
>
>  Unfortunately when running the test, that message is found in the  standard
> output of git show -s --show-signature, but in the standard  error of git
> verify-commit -v causing the comparisons of both standard  output and
> standard error to fail.

That doesn't help me parse it any better.  It's the "but" without a
corresponding "not" which seems to be throwing me off. Typically, one
would write "this but not that" or "not this but that". I can't tell
if there is a "not" missing or if the "but" is supposed to be an "and"
or if something else was intended.
