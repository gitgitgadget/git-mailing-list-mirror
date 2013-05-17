From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 12:02:58 -0500
Message-ID: <CAMP44s2AGWk76Nwk+va-6SBZqj46AHf6d_tm-AeN8jWKR-mEvw@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
	<7vobc91squ.fsf@alter.siamese.dyndns.org>
	<CAMP44s0o7tgUrz4xQh3H62+=625ppAOMFskOL70Nrx-O5uwaYw@mail.gmail.com>
	<vpqvc6hczq2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 17 19:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdO3d-00067X-OC
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab3EQRDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:03:00 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:32790 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab3EQRDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:03:00 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so4638811lbc.16
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Erwkzvv23L1THGnQjYZsmRa3VO2dzdgwW7sJcRhio4E=;
        b=M1sSpNljiI50dTCiGHKIz6jLAUpXAWR0yheTdl76HcqfjCplH10dPpJ6dTyzhsadUh
         3E/pP4AN1pEExKAFxO2kgWT0yW/YqtYu94VEjFXsUJ2Lft1ZlHASgE0juOliidIzSPFW
         mojj9/98cXXqXMgmbewzSeCV13fQwL52FtM+SpbKYfM3Sz/3nb3gm3Ga/Fo6D/7oUZuB
         g2ENK0IJVoxTZ2vgy9z5n4ANi3/D/F8avpT3npLjNJgurdDfRVWvOK0GoxQ9HK6XL+5o
         8cfiW1x6oiwLfe4XVoxp0V3ZxMdGJFrNZFdugBe2WeHVfXHpj5L5k9FXBjba64N5ZHVt
         WF+g==
X-Received: by 10.112.135.70 with SMTP id pq6mr22993837lbb.82.1368810178430;
 Fri, 17 May 2013 10:02:58 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 10:02:58 -0700 (PDT)
In-Reply-To: <vpqvc6hczq2.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224707>

On Fri, May 17, 2013 at 11:56 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> THERE IS NO STYLE BREAKAGE.
>
> Repeating something, and even making it all caps does not make it true.

Tell that to Junio. He is also repeating the same.

I actually provided *evidence*. Did you miss it?

> You are wasting your time and everybody else's in this thread and many
> others. You seem to reject the very concept of code review. The Git
> community likes very much code review. I do not forsee a change in the
> taste for code review and iterations to make the code as clean as it can
> be in the Git community. And I'd hate to see it change because some
> contributors are too stubborn to send a reroll when someone else points
> out something in the patch.

Sorry, did I miss somebody mentioning a problem in this patch? All
I've seen is people throwing opinions, nothing related to this
project's coding style.

If you see this patch doesn't follow the project's style, please point
where, and where it's described in Documentation/CodingStyle.

-- 
Felipe Contreras
