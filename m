From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 12:18:32 -0500
Message-ID: <CAMP44s1uDEUxxJWwHi=J1Jf=CnApi99BW3ZxTPUa7T+py==gfQ@mail.gmail.com>
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
	<CAMP44s2AGWk76Nwk+va-6SBZqj46AHf6d_tm-AeN8jWKR-mEvw@mail.gmail.com>
	<vpqwqqxbka7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 17 19:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOIg-0002rW-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287Ab3EQRSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:18:34 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:57281 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab3EQRSe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:18:34 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so4595479lbi.4
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=m2aik/aTlBZmBthJfRt5pvS6XMjV4YuI9udnUF7ztKA=;
        b=sc/rRqJwTMF/YuqSC1Oc8IrIFDAZyYxTavgj38wnRp/pggqJFFWMbpoWBIEU9t+yOR
         G8M22MH2IMfmxhEE1HiLESh8I5MSoeHg/qw9ZmiPhO8JARqEv6qV56g0O+4kRcQKcpPa
         wh2hrXJ6ya9+bFaRKaZMXwolKXg0sir+t/KAI3WhmV3dJul2o9JRm0Z/zpgS/rImqKDy
         4NszILToDGeTMjiDyb0dV+m2e2DReYa03MocUYJDuAmIjl1XkWxW/ybGPXObLjL5lDYq
         W1FtfcvVOeLujBPJfjIKH6G35JcuLK1A8p0sXUfG4R/QwIpaIMjZD9BGQZzKe9ozGN3J
         +0Cg==
X-Received: by 10.152.22.168 with SMTP id e8mr23203792laf.20.1368811112499;
 Fri, 17 May 2013 10:18:32 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 10:18:32 -0700 (PDT)
In-Reply-To: <vpqwqqxbka7.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224712>

On Fri, May 17, 2013 at 12:14 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, May 17, 2013 at 11:56 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> THERE IS NO STYLE BREAKAGE.
>>>
>>> Repeating something, and even making it all caps does not make it true.
>>
>> Tell that to Junio. He is also repeating the same.
>
> Junio explained you carefully how the former code was purposely aligning
> stuff and you broke it.

Yeah, and it was purposely adding a space between the parenthesis,
that doesn't mean it's the desired style.

The fact that something is a certain way, or was, doesn't imply it
*should* be that way. Explaining what the code was formerly doing is
no argument, it's merely an observation.

>> I actually provided *evidence*. Did you miss it?
>
> Star-emphasis does not make things true either. Again, you're losing
> your time, and won't lose mine any further.

Of course, because you have no evidence or arguments.

-- 
Felipe Contreras
