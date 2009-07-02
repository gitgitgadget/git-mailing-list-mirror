From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace 
	differences
Date: Thu, 2 Jul 2009 23:05:40 +0200
Message-ID: <cb7bb73a0907021405r15639624y7fdbb2a0aed85b27@mail.gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org> <cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com> 
	<cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com> 
	<7vhbxu6f87.fsf@alter.siamese.dyndns.org> <cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com> 
	<7vws6q3in0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 23:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMTTt-00063J-Sc
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 23:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZGBVF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbZGBVF7
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 17:05:59 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:63821 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbZGBVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 17:05:58 -0400
Received: by bwz25 with SMTP id 25so1488480bwz.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NGNTTCsd0DcsuTBx9/YrSptvEcB53jhg7dJNziamkXw=;
        b=OqKc9B4iydZMqe2jw3ay8NqqjprooHP5gnUnr3XV/IyxJppjcGMvHH12V7YbRKCYZ1
         MqB++DYyI18cwZw3U2ZoBNeaPAteCg2MjPOHH/FY2hfOvhDp4sdGKs8RKXJeEjb28fqk
         6wFhfAwLxm3nFjx9/p/nukzK0fZbYPwSL2lXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DZEsyb3bIGTd9MRX0r5ch3mHvTYtjrQjl/jog1nTFrJsXjAR7CBjZpzA9ZGRS+Vh/U
         qU99N9dL9c6IRpy5IovYT5yNld+/byxThaU+fbbmtzha21gZHyH6oErajf+EGr2EYJIy
         Rb6guzY+kElBOnVq9a6ayhX/Q6JlZ68IU9yXg=
Received: by 10.204.70.135 with SMTP id d7mr447699bkj.87.1246568760174; Thu, 
	02 Jul 2009 14:06:00 -0700 (PDT)
In-Reply-To: <7vws6q3in0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122673>

On Thu, Jul 2, 2009 at 11:00 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> I do wonder what makes the patch 'unreviewable', since I assume that
>> doesn't mean just 'does not include the refactoring I requested'.
>
> Ok, unreviewable may not be the word, and "it is apparent that the patch
> has not been well thought through" is the word I would want.
>
> IOW, it really should have been marked as "[RFC/PATCH]".

Ah yes, I keep forgetting about that. I remembered it on the very
first try (actually, I wrote PATCH/RFC), but then I forgot about it in
the next rounds.

-- 
Giuseppe "Oblomov" Bilotta
