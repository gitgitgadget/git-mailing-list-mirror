From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 4/4] git-p4: update locked test case
Date: Fri, 3 Apr 2015 16:00:23 -0400
Message-ID: <CAPig+cSsPZZ=kEQ9jwj-BKkO+gKFwZYVi-FrTvvTZpmatmokAQ@mail.gmail.com>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
	<1428087218-8186-5-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 22:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye7la-0000BF-KU
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 22:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbDCUA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 16:00:27 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34372 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbDCUAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 16:00:25 -0400
Received: by lboc7 with SMTP id c7so84328519lbo.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2gJv/4u+aQmOlr7k5QKmMAxvyu/Xvax3fV20LDY3OlU=;
        b=WnXmoS4wXNB+zFYCkgdbz9Yzr5Jxq0KJGnh1cFCijge9H/QCPJocDBIBrC13WC8Qct
         8kR/v2WT3c/uOuyEMbKdMO5wr2hklamkU9KD0ZT9SYBXBk1QKVEZ1pWKtD4Je7WUrX/p
         AHAsNQVnV7ZmsWhoPnHkAwwwzeqbBqq6nEMSFrntZXqq5rVX5FrZEWdeSB0A4wZGRW1n
         3jqXvnetQVm2CzZS3trTY539A1ASalaluOCOfb+T16thmzxXiq9Q1KdKID1Vxw07ZQon
         2KMNemaNQ/rGTAy6XywxLpvvQzm6notQfOY4pplKTmLPX2zEZIzcvqr1GPqbHJko1IR1
         GXaw==
X-Received: by 10.152.234.42 with SMTP id ub10mr3437392lac.60.1428091223684;
 Fri, 03 Apr 2015 13:00:23 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 3 Apr 2015 13:00:23 -0700 (PDT)
In-Reply-To: <1428087218-8186-5-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: x9Sir1JQn7Vn8YHhJ7QLqQETvI4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266723>

On Fri, Apr 3, 2015 at 2:53 PM, Luke Diamand <luke@diamand.org> wrote:
> The add-new-file and copy-existing-file tests from
> t9816-git-p4-locked.sh now pass. Update the test
> case accordingly.

This patch should be folded into patch 3/4, shouldn't it?

> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  t/t9816-git-p4-locked.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
> index 464f10b..d048bd3 100755
> --- a/t/t9816-git-p4-locked.sh
> +++ b/t/t9816-git-p4-locked.sh
> @@ -35,7 +35,7 @@ test_expect_success 'edit with lock not taken' '
>         )
>  '
>
> -test_expect_failure 'add with lock not taken' '
> +test_expect_success 'add with lock not taken' '
>         test_when_finished cleanup_git &&
>         git p4 clone --dest="$git" //depot &&
>         (
> @@ -107,7 +107,7 @@ test_expect_failure 'chmod with lock taken' '
>         )
>  '
>
> -test_expect_failure 'copy with lock taken' '
> +test_expect_success 'copy with lock taken' '
>         lock_in_another_client &&
>         test_when_finished cleanup_git &&
>         test_when_finished "cd \"$cli\" && p4 revert file2 && rm -f file2" &&
> --
> 2.3.0.rc1.30.g76afe74
