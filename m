From: Alexander Usov <a.s.usov@gmail.com>
Subject: Re: How do I get a squashed diff for review
Date: Sun, 6 Nov 2011 02:33:22 +0000
Message-ID: <CAH_EFyZgsGPtJRUTrc2Qhkj1Tr3o9SKd6KZuBM2M5AjU-n_BQA@mail.gmail.com>
References: <CAH_EFyZ_0JB0-5cw-6VEJkfJhSjbmA=3upByQ3YpmnVSvR+9Pg@mail.gmail.com>
 <20111105091514.GA97860@gmail.com> <CAH_EFyYUja4cKY5YM4Uqn-bnQZCnhnJCNsxGsUitL+SSqj9qxQ@mail.gmail.com>
 <7vobwq86tx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Roland Kaufmann <rlndkfmn+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 03:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMsYn-0001oL-VQ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 03:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab1KFCeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 22:34:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55549 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab1KFCeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 22:34:05 -0400
Received: by bke11 with SMTP id 11so2873543bke.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BkEDHKR8Imli9Qh9HMI3Nfwi9A5Zz8slLd7OOZNnmuo=;
        b=sGjZqzp3lFBp5RK+ouLu+Qd3UfdLAda9pVeqMtiYjdoQkSXQ8tO/i5CIWhQJ9O0wWG
         tqrXAo6kOba0PpIOKTs1YnVGScKC+qpOFTOGnqleWw7pSvugd/FreI48nXRMD8/6tngU
         L236ocmAhQVLpbV+gPRRANeSRPbH4t4f/EZ9o=
Received: by 10.204.139.200 with SMTP id f8mr15949186bku.25.1320546843223;
 Sat, 05 Nov 2011 19:34:03 -0700 (PDT)
Received: by 10.204.149.66 with HTTP; Sat, 5 Nov 2011 19:33:22 -0700 (PDT)
In-Reply-To: <7vobwq86tx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184892>

On 5 November 2011 23:53, Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Usov <a.s.usov@gmail.com> writes:
>
>> Consider the following history:
>>
>> master: A---B---D---F
>> =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 =A0\
>> branch: =A0 =A0 =A0.-C--E--G
>>
>> ...
>> - "git diff D..branch" would do a trick, but I'm not sure how to
>> correctly determine
>> D (if I'm to write a script).
>
> D is the merge-base between F and G. So "git diff $(git merge-base F =
G) G"
> would compare D and G.
>
> Modern git lets you write it as "git diff F...G" as this is a fairly
> useful short-hand.

Strange.
I definitely remember reading about "git diff F...G" and trying it out.
And somehow the result wasn't really correct -- as if commit B was
chosen to be merge-base.
I can't reproduce it right now on a sample repo -- will try it once
more back in the office.

Thanks for help.

--=20
Best regards,
=A0 Alexander.
