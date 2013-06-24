From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Reroll of rr/triangular-push-fix
Date: Mon, 24 Jun 2013 19:21:05 +0530
Message-ID: <CALkWK0=L4X=5UrCPygoUeLo9byvRKh4bez0DVB5iqatLvdEEfA@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <CALkWK0kDwMq-ADRPShOdCy2Vh+zj9J9A0A4CFv21aKZFeiMs+w@mail.gmail.com> <7vli60c4gu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 15:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7BO-0002i4-7M
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 15:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab3FXNvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 09:51:46 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52223 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3FXNvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 09:51:45 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so24958392ieb.16
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QypKcoX4tSkPx8K8uy3FoGM1N9fH+0nn8Vomuah0WZw=;
        b=Fs9g+knJbZSkZYdGUAk0SxFS/9Kk6IQSMIkiJWp35lZT1FUc4RRW3apbrsa+KZ77iJ
         kGrwEEF2P6MYxxXg82dWpQjM4Kk9zQhDn0LGMpzJpEKq56UwjZ7SIf7WfuzAA2Ct6YQw
         jBjtV1dTTBhYfAMZvYEFGBXLTXcWqvJk7+jkZTSRIl8oh1Z/Y3H8i3EWad/oiStGG3a+
         2FZOUQWxLB4a82NcJ2gOGPmD8c2VxXZGmxeLxLyD7sdOsrX/71BmtZ+dFwnksZZpYWVH
         qB+9P2LKDayEq4dfnkWb8pJJrUgw8kxjgPWvgfdUat8MudxorJrFkNPXfVeuvcffl+l6
         7Ntw==
X-Received: by 10.50.47.105 with SMTP id c9mr5546916ign.50.1372081905377; Mon,
 24 Jun 2013 06:51:45 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 06:51:05 -0700 (PDT)
In-Reply-To: <7vli60c4gu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228811>

Junio C Hamano wrote:
> 'simple' is supposed to be an easy and safe default to help new
> people.  Your original patch to change its semantics for the central
> workflow from the current 'make sure upstream is set and set to the
> same name' to 'anything goes' is making the mode more dangerous than
> the corresponding 'upstream'.  Such a mode may have its place, but
> labelling such a mode with rough edges as 'simple' and forcing it on
> new people _is_ stupid, IMHO.

Oh, I agree that "anything goes" was the wrong approach.  However, I
think a sane default for branch.$branch.merge is a good way forward.

> In any case, the good news is, if you start strict, and if it turns
> out to be stricter than necessary, it is easier to loosen it later,
> because nobody would be relying on an operation to _fail_.

Okay,  I will quote you if you raise issues about "preserving how it
has historically been functioning" when I complete the upstream-fix
topic.

There's no need to stall this series then: [1/6] to [5/6] largely look
good-to-merge; drop [6/6], as it needs more thought.
