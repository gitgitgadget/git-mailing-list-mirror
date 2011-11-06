From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sun, 6 Nov 2011 20:35:09 +0100
Message-ID: <CAGdFq_j7NxojZ+82s0GJ8ZF0oyd5sH8t0kcMOTQGtKbASXqYTA@mail.gmail.com>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
 <7v39e2852t.fsf@alter.siamese.dyndns.org> <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
 <7vy5vt7uqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?UTF-8?Q?Jonas_Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 20:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN8VX-0001Zs-Mn
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 20:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab1KFTfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 14:35:51 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60365 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1KFTfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 14:35:50 -0500
Received: by ywf7 with SMTP id 7so4476474ywf.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6wg5sj3Kc6JR5tIEIwgJFiv0XZ/Xg0cEDogmEvTEF08=;
        b=Z1/EOxjAD4cV3h6JN5xFXoVDHph5MW1AeUZT/8LwwxJ+rvX18AM+UHW+9Hpf7m4ssl
         2rAzjPe/nUACaD85wuTCuyrNMQOCIf1YNOjfRy5Ww2Y7mSoAn5WuhBYCtpEWRnKDuULX
         EVjW37Mc7SW6HkYQDFLxGjJS8IcN6DAMQWrv8=
Received: by 10.182.152.65 with SMTP id uw1mr6363187obb.10.1320608150288; Sun,
 06 Nov 2011 11:35:50 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Sun, 6 Nov 2011 11:35:09 -0800 (PST)
In-Reply-To: <7vy5vt7uqo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184925>

Heya,

On Sun, Nov 6, 2011 at 05:14, Junio C Hamano <gitster@pobox.com> wrote:
> I am puzzled, but that cannot be true. The existing message uses $msgnum
> and $FIRSTLINE but does not use $commit because it does not necessarily
> exist.
>
> What a value would the variable contain when I am applying your original
> patch message using "git am -s" (or "git am -s3")?

Aaah, I understand the concern you raise now. In that case a spurious
[] would be printed, which I agree is less than desirable. Would
checking 'if test -n $commit' be sufficient?

-- 
Cheers,

Sverre Rabbelier
