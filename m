From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] remote-helpers: test fixes
Date: Mon, 20 May 2013 17:53:34 -0500
Message-ID: <CAMP44s0gK5EgD-pJb1NVrpJvYeyXmN_nS6MT7renFHhne1cZJg@mail.gmail.com>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2sltgj4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYxY-0004tD-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab3ETWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:53:37 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65175 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab3ETWxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:53:36 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so81300lbi.17
        for <git@vger.kernel.org>; Mon, 20 May 2013 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3b68pttjkWQdUPaKzVeO5+uvYEvCkjTtyzHq7aNr+fs=;
        b=Zsx7KuyPwZHm4CfE9/eUdjfywEyxmfztw6lcLAjHy5skpXm5vGN3HF08xNjYWAbEEZ
         maskvrE63pVQs4c8WHqPO0YPGhrf7J9Ed+6ebwgaUKYjxBQYVQODS8NXcVOc4bwF+0Mx
         uDi2NscZXblL2cJoHPcd0xOfh+FOAqMg4hrBI2ZjFy0G2e57U8VnQQE03ck5XQ0yydXG
         xeazMvJ0IiF1dNP5BOTH++OpxQqbzNrYZSrTqXPxA5zDlsOcRIdutzpI3P/CVXnnWCAx
         ThaGuLg5/Y1EDNiqX/5mggJxPK3ISNZvzE5MamkSuFxGf2Du1l28wOuztEdJOsb3aWn/
         mntA==
X-Received: by 10.112.145.72 with SMTP id ss8mr149217lbb.12.1369090414935;
 Mon, 20 May 2013 15:53:34 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 20 May 2013 15:53:34 -0700 (PDT)
In-Reply-To: <7vd2sltgj4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224998>

On Mon, May 20, 2013 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Hi,
>>
>> I've setup a project in Travis CI for continuous integration with very good
>> results, however, I had to apply a couple of fixes.
>>
>> I'm not sure if this is v1.8.3 material, but here they are.
>
> Thanks; I'll queue them at the tip of fc/remote-hg to graduate soon
> after 1.8.3, then.

No, they should be graduated first. The tip of fc/remote-hg is in pu,
no? I have rebased that branch and squashed some fixes so every commit
works on all versions of Mercurial. I will resend all the patches, the
only reason I haven't done so is that I didn't want to create more
noise before v1.8.3, and you said I was the one taking the decision
when to merge remote-helper stuff to master.

So this should go to master, the rest of fc/remote-hg should be
dropped, I can resend any time, and I suppose after v1.8.3 is the best
time.

-- 
Felipe Contreras
