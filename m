From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Thu, 6 Sep 2012 14:47:26 -0700
Message-ID: <CALaEz9ULAAoX0P-Tp7Ma0UmWqRvenkG3OEQPQyE6iqwdV6Kxig@mail.gmail.com>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com> <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
 <7vsjav6d85.fsf@alter.siamese.dyndns.org> <CALaEz9W_RR70KEzxk7GxjOu1_yv4UudckcsKAP2C_39Nc2yLbw@mail.gmail.com>
 <7vipbq3omb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jvS-00051M-TE
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab2IFVrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:47:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35933 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab2IFVrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 17:47:43 -0400
Received: by iahk25 with SMTP id k25so2560618iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VVxeIx7ssovHPw8K8bTuRcb8vKrQYK3fhJ2yhNow2vE=;
        b=RL//N/r/kLNlNXULShqFGJYxMYta6O8dQe9j4LTNroSGL12B1CDMyw/rYrgAno5kNa
         7OE8Ei6OTn8kqhe7BGQxBfcT/05mmuJIns1x69fN+3yqBwIKQs/ssxvXsT6dNBGsxJfE
         vl5T4B79XwKfTF4WySKlEODpb0nE87bwblAHlKBrzP4V/mqdWkAxViBYgGP5D4qiliE9
         s9nEozgJsUSU/mfHxwrxswk0VnygXZAL84XA0Hk/UsvehwwTUHKuOyHMqfhEkrGIre5Z
         wA6gaXjolFi1vpqu3qXAMub/z/5HuhiubxCrgz5sWzKK6y+XSl/n+31Fl4yQ7cXAwp/E
         9V8Q==
Received: by 10.50.47.167 with SMTP id e7mr5332340ign.1.1346968061588; Thu, 06
 Sep 2012 14:47:41 -0700 (PDT)
Received: by 10.64.64.33 with HTTP; Thu, 6 Sep 2012 14:47:26 -0700 (PDT)
In-Reply-To: <7vipbq3omb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204927>

On Thu, Sep 6, 2012 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If you let $to to go empty with the first hunk of your patch, where
> does the mail eventually go?  Does anybody later in the code decide
> to add some recipient?  If there is a reason why an empty input is a
> valid here, I think there is a stronger need (that is, stronger than
> the above ase for $initial_reply_to) to explain when the user wants
> to leave this empty.
>

I almost never type anything and just use the To header in the patch I
want to send.
