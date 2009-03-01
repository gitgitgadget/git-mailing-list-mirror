From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: coding style: #ifdef blocks and real C blocks
Date: Sun, 1 Mar 2009 17:33:02 +0800
Message-ID: <be6fef0d0903010133s7343a96ekd8939695a65ba4a2@mail.gmail.com>
References: <be6fef0d0903010052t50551f3w74352b69afdee620@mail.gmail.com>
	 <7vbpsl8v7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 10:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldi9T-0007Kz-IV
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 10:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZCAJdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 04:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbZCAJdF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 04:33:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:62155 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZCAJdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 04:33:04 -0500
Received: by wa-out-1112.google.com with SMTP id v33so990250wah.21
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 01:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MmK7ApEzZjppJVDlAJWxNtIsxsVIwp+ZYcYDK5hGld8=;
        b=aaxsyO1h7499oRg/xHG3nlfnKKP4QDewROAQxuN3S8h390XFDw7o1WDCab0CE6mD/a
         D8PPsFq9k5rQsPYLXX/i7SXndaD8YrWROzLvyD0LTnUjdtXY0SeQbe57wVW3FkLo5o5h
         Uq/RNE0psE4Q6c0hXZ10pByACA1ItAknYCjog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SPE7Cv7/rmfuj9RjjuL7VXGTvrxRUu/qH9adtV6UEJBGORcnl3WTH7o2HNYPyRd/ux
         1Ns+Gj+Yd96o0ruWiHboGOWmhXiA/CN7R0PIwUDgsnjq3fSR3P/cgGVBJnQxeMUojZPH
         QHV+Wl8HHrCnLrO87SIZ+T3iDdqPM1FVlt4/g=
Received: by 10.114.53.1 with SMTP id b1mr2075004waa.29.1235899982584; Sun, 01 
	Mar 2009 01:33:02 -0800 (PST)
In-Reply-To: <7vbpsl8v7r.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111832>

On Sun, Mar 1, 2009 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =A0 =A0#ifdef USE_CURL_MULTI
> =A0 =A0#define active_slot_get get_active_multi_slot
> =A0 =A0#else
> =A0 =A0#define active_slot_get get_active_slot
> =A0 =A0#endif
>
> so that the code itself would not have to have any #ifdef?

On further thought, wouldn't it be a better idea to make this
uppercase, ie. GET_ACTIVE_SLOT, to make it more obvious this is a
macro? Then we wouldn't have to jumble the name into "active_slot_get"
to differentiate it from the two slot functions.

--=20
Cheers,
Ray Chuan
