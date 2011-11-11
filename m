From: Cheng Leong <leongc@alumni.rice.edu>
Subject: Re: [PATCH/RFC] Restore line limit option in post-receive-email
Date: Fri, 11 Nov 2011 01:08:36 -0600
Message-ID: <CACor6wGkDPSkA_G117YtnsQA7H_cROKKW69m-jW_rb2SrVWo1w@mail.gmail.com>
References: <1320993311-27112-1-git-send-email-leongc@alumni.rice.edu> <7v4nybrvug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kpfleming@digium.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 08:09:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROlEV-0005Y4-5m
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 08:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab1KKHI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 02:08:58 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35644 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab1KKHI5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 02:08:57 -0500
Received: by ywf7 with SMTP id 7so3889684ywf.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 23:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ANistO6hjh3ufDRlVGD/qdwjFzlgxPnWv9idmTWqYSE=;
        b=JO5ZGsRtfaK6M8HlSuzAtefraYcVNY0euyPk+nLcd1bMKaDIb+vke18fo46W9UNrY7
         7dn2aNWeGYksZ1hOSr88+YSLJOm+JMt78b+Gw5zHC9mCR6WDb/RMB5ti8PU5RlumnzHk
         TbY1aXHJm7JXo5ldlElJsU0ACrR0cSzsXg+u8=
Received: by 10.182.17.34 with SMTP id l2mr2588902obd.2.1320995337178; Thu, 10
 Nov 2011 23:08:57 -0800 (PST)
Received: by 10.182.122.10 with HTTP; Thu, 10 Nov 2011 23:08:36 -0800 (PST)
In-Reply-To: <7v4nybrvug.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: TVqkOoVaq3-LD8zIiMDt_IWb5ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185257>

Junio C Hamano <gitster@pobox.com> wrote:
> Umm, there is another place where $maxlines is used without
> merit. Shouldn't we do something like below as well?
=2E..
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 generate_email $maxlines | send_mail
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 generate_email | send_mail

Agree. $maxlines is harmless, but extraneous here.
Would you like me to reroll a patch with both or is this a trivial fixu=
p?

Cheng
