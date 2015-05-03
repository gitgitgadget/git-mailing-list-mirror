From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/4] api-builtin.txt: explain common command groups
Date: Sun, 3 May 2015 17:13:51 -0400
Message-ID: <CAPig+cTB3JOoqw3pcSBBdC_btwDP2uzKDH119nVYVZ=4U=PFJQ@mail.gmail.com>
References: <554405D5.9080702@gmail.com>
	<55456990.6000509@gmail.com>
	<55456AD3.7090908@gmail.com>
	<CAPig+cT0aurG9gS2CrwMPG2B4xrAbhvwNJtAjYz7UYc4x1TiEA@mail.gmail.com>
	<55468C23.70306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 23:13:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp1D3-0006DV-27
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 23:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbbECVNy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 17:13:54 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38140 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbECVNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2015 17:13:52 -0400
Received: by igbhj9 with SMTP id hj9so70641950igb.1
        for <git@vger.kernel.org>; Sun, 03 May 2015 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xoEwIWK2Wt5PrYE7zxTxxNeH9HrQ9z4opkG4U4zLQTA=;
        b=je5LRiGyCkJazoPuGtegrtuEGyzu/FW0/p3qDgzhVpsu/GLriE8QgKwbzVTHFPoUq5
         IXch5UYq+OTFAHOLqr8BNrVfv4my5wnPySL7eT4kWXFrdd9aMrwt5acRJmzYYSN6e/6M
         hYLjToa1pBbAb2ApU/Gnj6iEP0eWw/QhsEdQoZum36fyJfIfFf/YYQlKQco1QJcINRA1
         fe+1+vJ9xcH3Q+WJH2ekZLCqFXRSfNw5SwR1kiHMTDIAyQriedHSsaaUzHdHeaYnIZV4
         RBsWjGQv5i8aTSAPwkdEJkbfpIt35/AJRD/ztHWBCKUNHHQVFxBp7fzmdT9iQgbmm2Rn
         J6dQ==
X-Received: by 10.107.31.134 with SMTP id f128mr24420815iof.19.1430687631967;
 Sun, 03 May 2015 14:13:51 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 14:13:51 -0700 (PDT)
In-Reply-To: <55468C23.70306@gmail.com>
X-Google-Sender-Auth: F2ESMGB_YDwGaOTMq29cVgxFPoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268295>

On Sun, May 3, 2015 at 4:59 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/03/2015 10:02 PM, Eric Sunshine wrote:
>> Finally, all of your patches are whitespace-damaged and fail to appl=
y
>> to the code-base. Did you paste them into your email client or some
>> such? If possible, try to send patches via git-send-email since it
>> does a good job of protecting against whitespace and other types of
>> damage.
>
> I'm having a hard time configuring send-email through gmail,
> so those patches were indeed pasted into plain text. I'll look into
> making send-email work.

The Gmail example in the "git send-email" manual should be sufficient.
However, perhaps other prerequisites are unmet in your case? (For
instance, I had to manually install the Perl Net::SMTP::SSL module on
my machine to get git-send-email working.)
