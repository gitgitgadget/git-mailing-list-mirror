From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: define out variables only used under RE_ENABLE_I18N
Date: Thu, 19 Aug 2010 21:30:44 +0000
Message-ID: <AANLkTinCiX4WFmrQ6brZ9iswPcYq2UJMurhorQA__7kN@mail.gmail.com>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
	<1282242601-2630-1-git-send-email-avarab@gmail.com>
	<7vtymq74mp.fsf@alter.siamese.dyndns.org>
	<AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
	<7vlj8271mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 23:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmChH-000604-Ks
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 23:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab0HSVar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 17:30:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46116 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0HSVap convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 17:30:45 -0400
Received: by fxm13 with SMTP id 13so1415726fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yOgW9HoZq0lG0J/qfcAkvV+TyRwTNodTLZxC7Oy7qYs=;
        b=I17ItKgkNx8CLXRQjc32aUwix1XPslXA6CE5pk/MRJ71rfwCKVmWteuNSFPn0r2qct
         GTK2vyp4ffe5T0F8HcFutWDfMuBBHjM4bYjD1dqgMSxdodXIAqwmL4px4AOpSeHSZKMS
         xPSqz2jl1YwCuVYiB86qxTDUNc9/BUxdBv6ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gsOA4zZebGOJrbS3egnbtEEH7y4mZWNpRRyv4UkJaB+8E/eDySMYh7h4P3tT0Yknlw
         Zr+ixsmG7cc4DvSmee0AmrH0fW8tyCju5VNy7iwEWsMzvD1IOVYiAbmnz7pxiiYJWEJI
         5ywhnCPG7cwUYtSKCQZ7C2j7LMAcxsgQm520U=
Received: by 10.223.118.11 with SMTP id t11mr365279faq.51.1282253444568; Thu,
 19 Aug 2010 14:30:44 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 14:30:44 -0700 (PDT)
In-Reply-To: <7vlj8271mm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153961>

On Thu, Aug 19, 2010 at 21:07, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Could you compile the old compat/regex library on the same system?
>
> Did I ever say this was a regression?

No, you don't say much at all :)

But perhaps if we know the system / compiler / versions / flags
there's something we can do to make compat/regex more portable.
