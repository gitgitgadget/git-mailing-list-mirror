From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fsck: print progress
Date: Sun, 6 Nov 2011 09:37:55 +0700
Message-ID: <CACsJy8DDKLrtmA3rGdW6xghwSs_e+zi1o2LzPDbmryH+XufpvQ@mail.gmail.com>
References: <20111103211819.GA17341@sigill.intra.peff.net> <1320376242-27851-1-git-send-email-pclouds@gmail.com>
 <4EB4EB70.40801@gmail.com> <7vk47e86j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 03:38:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMscy-0002ql-5d
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 03:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab1KFCi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 22:38:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47612 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab1KFCi1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 22:38:27 -0400
Received: by bke11 with SMTP id 11so2874506bke.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T/Ue9nJ+lW/Jm2llPuUCbKxp0hnC8lrAUuKgv6qY4o8=;
        b=h6Ha0nXognV7YAyXp0Wl/QDQ6yB5YPIUQeJUSyUJL4cM8DPHdQhMEAdzi8a3+PU+7e
         xFkYgo16CCOhTVns/TGXDS/LNdzWFvv0G8yCxBMxYujKJMprss3KSVp19mCVjTEw2wgA
         2KDB22E1LMIlo2TWU3GmUz59pBys4o+ZaScpw=
Received: by 10.204.9.205 with SMTP id m13mr15633294bkm.32.1320547106127; Sat,
 05 Nov 2011 19:38:26 -0700 (PDT)
Received: by 10.205.134.1 with HTTP; Sat, 5 Nov 2011 19:37:55 -0700 (PDT)
In-Reply-To: <7vk47e86j5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184893>

2011/11/6 Junio C Hamano <gitster@pobox.com>:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>> What progress isn't shown? How about
>>
>> =C2=A0 =C2=A0 =C2=A0 If --verbose is used with --progress the progre=
ss status
>> =C2=A0 =C2=A0 =C2=A0 will not be shown.
>
> When I ask for verbose output, I do not get progress eye-candy?
>
> Why?

Because in verbose mode, the screen is filled with "checking ..."
lines for evevry object, there'll be no wonder why it stops for so
long. It'd be good to show how many percent complete, but with current
progress.c support, the progress line would be lost in "checking..."
flood.
--=20
Duy
