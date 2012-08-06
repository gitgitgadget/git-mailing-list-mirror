From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] merge-recursive: separate message for common ancestors
Date: Mon, 6 Aug 2012 09:34:03 +0800
Message-ID: <CANYiYbFe6LUL+2m-X+Ek8ehFw6D5tvh+FwoGjF_zipcUe_MtMw@mail.gmail.com>
References: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com>
	<7vehnl41r2.fsf@alter.siamese.dyndns.org>
	<CAN0XMO+j08fV-5+nNrVQAteB3VStBjqvvjMzRq=6wcbg8OR+xg@mail.gmail.com>
	<7v628x3zjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:34:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCCz-00057k-PK
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab2HFBeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:34:06 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37649 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab2HFBeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:34:05 -0400
Received: by ghrr11 with SMTP id r11so2026661ghr.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hCGbzFh1lBy4ZCxEXl3AfxppzMmrmNJ0kLmAPJUj0QA=;
        b=Gq7anROEGd9vEmoKzOuNYl5QOXIZXQPhrNMtZEdlK8aWd75+QTNLjCW2UNTUb6SfZE
         /gBKrvfEaWqJNqwzfoIq3JkP/rIeLvCQTOfQE88lx0IsipXFZacdD+sCtxYo+xhe80BL
         4ZgYvqckRrz7j3yhwVcFpLTH/nXwbmm2MezXJj27XqFWoABzsRUTa6b/MOqGtVW654p2
         b9GLpohcGJCqcsaTLccHDTRsO+00ht4jB3UxIHw+bnOXqn6hkBtf2dTgnQqVuvuGHyeq
         fRGxY7KKeHX2PNu3fuSrqhuMjiJzziNFrCMT5e4i5VQbpfuZxHdaxtZncFt1Z1Ub/Mp1
         cJmw==
Received: by 10.50.160.130 with SMTP id xk2mr3972936igb.66.1344216844042; Sun,
 05 Aug 2012 18:34:04 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Sun, 5 Aug 2012 18:34:03 -0700 (PDT)
In-Reply-To: <7v628x3zjt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202943>

2012/8/6 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> It would be nicer for translators to have two messages.
>> In the end it's just a separation for singular and plural as it's
>> done in diff.c (e.g. Q_(" %d file changed", " %d files changed", files)).
>
> OK, so there was no hidden message behind "At least for better
> translation".  Will apply this so 1.7.12 can have it.

[resend to the list again, for last mail is rich text format and is
rejected by the list]

So I will not wait for Ralf's update on "de.po", he will catch up with next
round of l10n with this fix. Pull request for this round of l10n:

The following changes since commit 05a20c87abd08441c98dfcca0606bc0f8432ab26:

  Merge git://github.com/git-l10n/git-po (2012-08-01 15:59:08 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 649900bc126edf59aaae49ba025880dc948980f0:

  l10n: zh_CN.po: translate 76 new messages (2012-08-05 07:12:27 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (76 new, 4 removed messages)
      l10n: zh_CN.po: translate 76 new messages

Tran Ngoc Quan (1):
      l10n: vi.po update to follow POT in 3b613

 po/git.pot  | 433 +++++++++++++++++++++++++++++---
 po/vi.po    | 464 ++++++++++++++++++++++++++++++----
 po/zh_CN.po | 817 +++++++++++++++++++++++++++++++++---------------------------
 3 files changed, 1265 insertions(+), 449 deletions(-)

-- 
Jiang Xin
