From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/16] t/t5505-remote: test url-with-# in branches-file
Date: Sat, 22 Jun 2013 12:46:59 +0530
Message-ID: <CALkWK0kKtORPf2pZR+owrBenOgyk5Ymfr+Fnd5HggovL1mvCdg@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-7-git-send-email-artagnon@gmail.com> <7vwqpnjdyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 09:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqI4u-0001BK-AP
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 09:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab3FVHRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 03:17:40 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55171 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3FVHRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 03:17:39 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so21401015iej.1
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+CgR+Bjcvv0UXtFEYMjzdtTN0+s0lJ+pM5AkwnHbeQE=;
        b=ecNiywvw5V5dnEcJUyYs8RuBLzRF1kQikDlFwCk1wz+ZD94Btyk8ro3YVagIXqJFpo
         SOGCZyD4r7R1Ysr8vROqIie6BVSxq1un1kFRyJKtDLzIiq8gugdsCmmxxQcSo1c1cWVq
         wVnoy1Jdmm4UcUrQRc6inzAGOeFQg6R4BbiX/QPmC7DZZAB8oC0IAYjeEOOFbU/FCmIW
         UZ67O/hogIlPOEIa8g/oNsczVryit7r9ODnT+DvY1HM+HtIHZa9ml5WmUo0+C2pDsUZn
         RXidFiHgSbcYtHgwTc4L34UOeQkFL8lCZMan8gVoLBgWzljanqpfhPXdv1AmZEKA+1UB
         5Iaw==
X-Received: by 10.43.88.3 with SMTP id ay3mr4104531icc.61.1371885459209; Sat,
 22 Jun 2013 00:17:39 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 22 Jun 2013 00:16:59 -0700 (PDT)
In-Reply-To: <7vwqpnjdyf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228674>

Junio C Hamano wrote:
>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>> index fd0a81e..93e11c8 100755
>> --- a/t/t5505-remote.sh
>> +++ b/t/t5505-remote.sh
>> @@ -702,27 +702,42 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
>>       )
>>  '
>>
>> -test_expect_success 'remote prune to cause a dangling symref' '
>> +test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
>>       git clone one seven &&
>> +     origin_url=$(pwd)/one &&
>
> The variable assigned here does not seem to get used.  Is this needed?

Silly error carried over from copy-pasting.  Fixed.
