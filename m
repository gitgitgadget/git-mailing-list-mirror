From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a
 shallow clone
Date: Fri, 12 Jul 2013 14:54:35 +0700
Message-ID: <CACsJy8BnOtgeRrJL5D0HQALstqNzcppabRoE7bYGG37kYz+GeA@mail.gmail.com>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com> <7vy59cnx06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 09:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxYCA-0004dn-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 09:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3GLHzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 03:55:07 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:54742 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab3GLHzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 03:55:06 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so12370716oag.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=y31IXiUy5pb9oYHBP7vRzL+zjA4jFX9bX6T4gVTc2BY=;
        b=HwYtq8/7rexwL/r+ugTMPXmdsjeVpQfE5BD9q3zWFHFINEVB59vPuexJ3bWuZI8dK+
         iMRZkgI8wXS8hWoUpyWRmf1/0uab/833vhfws8plVWVZyelQaefbjrfqYmKdcDL5WwGB
         s8+BurIKSEtXZhS+bweGgzZyk2bgW7N7uU9+Ec17fbjMzP82PCBOtBvToFzRz9hmDlo4
         B4AdvotlCC4Oj9j/S7ZVqEsZFX2yfpFC+0mzhlBDCnjzUE505uT772LPEr2+P8oKU98U
         XxZ0BVsonwgBBsZUoSGNXC+r2uZhofrf3sa89Tyl6isO/nLfnr9amNuQJqpFnd/Awt9V
         FNGA==
X-Received: by 10.60.54.232 with SMTP id m8mr34707790oep.35.1373615705710;
 Fri, 12 Jul 2013 00:55:05 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Fri, 12 Jul 2013 00:54:35 -0700 (PDT)
In-Reply-To: <7vy59cnx06.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230184>

On Fri, Jul 12, 2013 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +     number of limitations (you cannot clone or fetch from it, nor
>> +     push into it), but is adequate if you are only interested in
>> +     the recent history of a large project with a long history.
>
> Ahh, sorry for the noise.  You still say you cannot push _into_ it.

Yes, I actually removed that check in the first iteration of this
patch, reasoning that it can't cause any harm and it mostly works. But
"mostly" is not good enough. I will try remove it later if I can make
it always work by extending git protocol a bit (I think full clone
pushing to shallow one can always work. Shallow pushing to shallow,
probably no such guarantee)
--
Duy
