From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 16/20] transport-helper: update ref status after push
 with export
Date: Tue, 21 Jun 2011 22:11:12 +0200
Message-ID: <BANLkTinXKCxFoPOuFHqy0XTpd6Jco+J=YQ@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-17-git-send-email-srabbelier@gmail.com> <7vpqm76jd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 22:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ7Il-0007P6-IW
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab1FUULz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 16:11:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57587 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1FUULy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 16:11:54 -0400
Received: by pwj7 with SMTP id 7so172509pwj.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=/HXIuVw+3dKvS0nbtuEiDiILXilFBkTfzTwrIBJdJhE=;
        b=jdDYuhrt+thYo8QHuYwPrXV23oAeWh/txK9WvQNs/bKoeBMM8+zP8ourcdgxlkUS9d
         FNsFNyP217Yl5xsY6LuhnlfvlyizLpGnWj3g8BahhKImon+dfwL/kmwV+7GZzszYuUwt
         2iCmz+tGF+CELRBTpzpSctl7AiunwS/hYg4iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UhjfAg1Zr8jIw80Y/5T6fns345DCAWHwRlY/gOKlFLkp21ECo3iXGlybDCwK1gbPR1
         MtUS6g/W9MnNwfn2T6zBvo3W5++yt6oR3eOMDpvHk5nt4UPxqtNTMc3pCoQNauuKwo9I
         bnspgpDfWBjyELy5X6JUBic+7XzypJVPBtmq0=
Received: by 10.68.22.3 with SMTP id z3mr3123509pbe.142.1308687113309; Tue, 21
 Jun 2011 13:11:53 -0700 (PDT)
Received: by 10.68.41.99 with HTTP; Tue, 21 Jun 2011 13:11:12 -0700 (PDT)
In-Reply-To: <7vpqm76jd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176195>

Heya,

On Tue, Jun 21, 2011 at 22:05, Junio C Hamano <gitster@pobox.com> wrote=
:
> This assumes that nobody will ever _remove_ refs. I think it is a sen=
sible
> assumption but somebody might want to give a power to the fast-import=
 stream
> to say "I do not want that ref anymore".
>
> I dunno; it is not a big deal to me either way. =C2=A0Just something =
to think
> about.

I'll have a look at addressing your and Jonathan's comments (the case
of 'already up to date' and 'refs removed').

--=20
Cheers,

Sverre Rabbelier
