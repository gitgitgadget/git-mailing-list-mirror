From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] send-email: initial_to and initial_reply_to are both optional
Date: Thu, 6 Sep 2012 14:49:25 -0700
Message-ID: <CALaEz9WpL4+712vTrkes6EvBkr3ksnFgb6C_Hm8PdHQTtaZR+g@mail.gmail.com>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com> <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
 <7vsjav6d85.fsf@alter.siamese.dyndns.org> <CALaEz9W_RR70KEzxk7GxjOu1_yv4UudckcsKAP2C_39Nc2yLbw@mail.gmail.com>
 <7vipbq3omb.fsf@alter.siamese.dyndns.org> <7vr4qe26gz.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jxO-0007Jn-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908Ab2IFVtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:49:43 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38896 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab2IFVtm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 17:49:42 -0400
Received: by ieje11 with SMTP id e11so3912882iej.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hYg/VSy5tuOhbzfQ59ziMtUE9f+9HHAbSgILrPiNNEY=;
        b=MqMZ0fOh0WFXnkWQqZFZbT12VFy4c1BOZIqqqGh8dqu9iSdcMKn7EQXXgr6UGaV/9r
         pyEtCd6mrWnxg8NDRLod2uWpfdHQZhmX+F38FjCSlxcvttUkjfa/Jr8I1QR2eYT8uEy+
         Na776cq9xj7AITVtG47wKtW8D6uedBliOBUNEIomnW/mDDjfXgai33xZ83xg1P26Avnt
         dKuqEapHnAFIT8fxBE5t+G4ChpthYg/jf0nVjzgQ8HQq+npuSGT8piQtwiaiHc6n7Jpq
         TJlQRi4CsII6KOH9EGU0ExI3NvqdhyWXSMBTP5TxILXbGUunU8BPHN+dS+13cJ6QgwBg
         6Iow==
Received: by 10.50.47.167 with SMTP id e7mr5336920ign.1.1346968181602; Thu, 06
 Sep 2012 14:49:41 -0700 (PDT)
Received: by 10.64.64.33 with HTTP; Thu, 6 Sep 2012 14:49:25 -0700 (PDT)
In-Reply-To: <7vr4qe26gz.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204928>

On Thu, Sep 6, 2012 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> We may pick up additional recipients from the format-patch output
> files we are sending, in which case it is perfectly valid to leave
> the @initial_to empty when the prompt asks.  We may want to start
> a new discussion thread without replying to anything, and it is
> valid to leave $initial_reply_to empty.
>
> An earlier update to avoid y@example.com stuffed in address fields
> did not take these two cases into account.
>
> Noticed and fix suggested by Stephen Boyd.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I am tempted to queue this, after asking you to eyeball it, and
>    then update the author to pass the blame to you before merging it
>    to 'next'.
>

Looks good, thanks.
