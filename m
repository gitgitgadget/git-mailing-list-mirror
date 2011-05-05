From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 5 May 2011 09:43:20 +0200
Message-ID: <20110505094320.5d64234f@mkiedrowicz>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
	<4DC24371.7060906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 09:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHtDc-0002mh-Lt
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 09:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623Ab1EEHnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 03:43:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40273 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1EEHnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 03:43:23 -0400
Received: by eyx24 with SMTP id 24so584847eyx.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ShJ5euzucx2kvg8xtawYS91+SBG+M0hLLQfsW3dcyhM=;
        b=XpUsBKnqcsQtBCK23G4TUaDNuqeE1hV6qwS7fKHUMFqiHdi98BD4uAtvDTkzPYKFwc
         XzWE5Gs/9j8vih0qdqmoF1yCrPfdTBWQs4/My1/Kr+U7xOVAUnrmQK09s66MWRjrBN61
         A3gCcMzeF2zP4KD5r6Hm9wFFjomGWGjTmE4Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=FuDs4MpYX7mf+Krvk1FpiGF0D1VGe114cKU/DnVs9PgH1sXGfAiWrXRRJuSiwMLVXq
         CMinATUrGdjpKc3e4RvtwMtgjVaSv6HxZAU3RZI9gdoebtqFVOhFePbjR+jSIERcr1FI
         LXuvrqKblQzw+rQy0Kf7PWGq8CPw6Y4Dgx+rQ=
Received: by 10.213.2.68 with SMTP id 4mr77958ebi.38.1304581402271;
        Thu, 05 May 2011 00:43:22 -0700 (PDT)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id r12sm302700eeb.18.2011.05.05.00.43.21
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 00:43:22 -0700 (PDT)
In-Reply-To: <4DC24371.7060906@viscovery.net>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172812>

On 05.05.2011 08:28:01 +0200 Johannes Sixt <j.sixt@viscovery.net> wrote=
:

> Am 5/5/2011 0:00, schrieb Micha=C5=82 Kiedrowicz:
> > +# Define NO_LIBPCRE if you do not have libpcre installed.
>=20
> This makes libpcre a requirement with an opt-out. But I can imagine
> that there are many platforms where libpcre is not installed. We
> would have to add NO_LIBPRCE=3D1 to many platform configuration
> sections. But how can this setting be countermanded if someone does
> install libpcre on such a platform?
>=20
> Wouldn't it be better to make this an opt-in (USE_LIBPCRE)?
>=20
> -- Hannes

Yes, Junio already wrote that too. I'll change that.

Thanks!
