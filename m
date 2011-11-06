From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sun, 6 Nov 2011 21:42:28 +0100
Message-ID: <CAGdFq_gS2fV5B26ZBOLs=5L_rnaeORmKW49OxwbP-+vx+ZN8cQ@mail.gmail.com>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
 <7v39e2852t.fsf@alter.siamese.dyndns.org> <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
 <7vy5vt7uqo.fsf@alter.siamese.dyndns.org> <CAGdFq_j7NxojZ+82s0GJ8ZF0oyd5sH8t0kcMOTQGtKbASXqYTA@mail.gmail.com>
 <7vaa89573r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?UTF-8?Q?Jonas_Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 21:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN9Yi-0000YF-33
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 21:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab1KFUnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 15:43:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44617 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab1KFUnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 15:43:09 -0500
Received: by gyc15 with SMTP id 15so3429165gyc.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 12:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AgcPbF71JuygT+ofncSKET8NzTTn+7VYIDRK7rLOkSg=;
        b=v8klqmUhhFKGg7sFh9fbCX2jCBbfaWfzHRFEhTA0N6STMTxl4ETgkTXa58LDrNjnpK
         65BqcwP2bbYa/dPwsP/CoJtoDF5lgdb89XoXQQAi1lygiom0idX9QqB1nKqxTFkFdMXG
         n155qhB92AcV8PNbSobfmQD+RaDr73yZLTDjk=
Received: by 10.182.147.4 with SMTP id tg4mr6394979obb.60.1320612189038; Sun,
 06 Nov 2011 12:43:09 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Sun, 6 Nov 2011 12:42:28 -0800 (PST)
In-Reply-To: <7vaa89573r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184933>

Heya,

On Sun, Nov 6, 2011 at 21:27, Junio C Hamano <gitster@pobox.com> wrote:
> In what situation does it make sense to say "It came from _this_ commit"?
>
> I think there is a separate variable that allows any part of the script if
> we are being run as a backend of rebase or not, and that is the condition
> you are looking for.

The closest I could find is:

                if test -f "$dotest/rebasing"

Which is exactly the case when commit is set. Do you prefer the "-f
$dotest/rebasing" test or the "-n $commit" one?

-- 
Cheers,

Sverre Rabbelier
