From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Sat, 30 Jul 2011 23:58:16 +1000
Message-ID: <CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<201107301548.09815.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 16:00:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnA5s-0003Ly-EV
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab1G3N6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 09:58:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62840 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1G3N6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 09:58:17 -0400
Received: by vws1 with SMTP id 1so3554994vws.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gcNubxwTcssm0gRvDpLJVQnushw3dMCvY+Lj9W4jnKM=;
        b=Hyt7Iws1VA6A8Fgb9F4zGituXLDv63ZpF3PTKw26U3ZAteZBALyQGjl2WqNy7eIzjo
         Bnxs2OB+3loXhl7cgHq4SQ4kFsYSpROL1JXASsd+Bwu2GqsqMOn6z/wXEQwbsAmiEGyQ
         3unzc9jvaB6kbx7F/GD/PaJNRji6khXL6EGUs=
Received: by 10.52.21.194 with SMTP id x2mr1734703vde.39.1312034296148; Sat,
 30 Jul 2011 06:58:16 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 30 Jul 2011 06:58:16 -0700 (PDT)
In-Reply-To: <201107301548.09815.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178197>

On Sat, Jul 30, 2011 at 11:48 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Hi,
>
> On Saturday 30 July 2011 10:28:26 Jon Seymour wrote:
>> For some bisection tasks, checking out the commit at each stage of the
>> bisection process is unecessary or undesirable.
>>
>> This series adds support for a --no-checkout[=<ref>] option to git-bisect.
>
> Sorry but I didn't reply to your previous email when you asked about a "--no-
> checkout[=<ref>]" compromise. I thought that Junio would reply and then I
> forgot about it.
>
> My opinion is that if you really want to be able to use another ref, then
> there should be a special "--update-ref=<ref>" or "--use-ref=<ref>" option
> that is different from "--no-checkout".
>
> "--no-checkout" looks like a boolean argument. And "--no-checkout[=<ref>]" may
> make the user think that this option will not checkout <ref>, and then it
> leads to the confusing question "but why would it checkout this f&#@ing ref in
> the first place?".

Good suggestions.

So, to confirm that I understand:

    use --no-checkout to control (no-)checkout behaviour and
--update-ref to specify a ref other than HEAD?

jon.
