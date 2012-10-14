From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and isprint
Date: Sun, 14 Oct 2012 12:07:11 +0700
Message-ID: <CACsJy8B6Yo5zZsf8aBF=fPgUfmAfNEnnDNkh8+WF28GcGuyidw@mail.gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-3-git-send-email-pclouds@gmail.com> <7va9vp1wa8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 07:07:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGQc-0005qN-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab2JNFHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 01:07:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45196 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2JNFHm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:07:42 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6485221iea.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 22:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=efjJE0B5SmGREXv6/LxxUVKIjrlnVyZR/QhqenO6WgM=;
        b=MrHGsq5AlzXtQF5Ko6V+g8QSjElDtR763fEb8NPteqyfmEsF/XiDoMn7BpTFXygRDq
         JxAJNl9YA0wwI627CkFnMwS7gSfNl739cQgS0YX3l1ybP4U6djMylmQXwi1cnZAxD8bz
         dMvQo0GiFtxIPQrtzmJ6lVHg/aJSCqwGfULCnyCMCYpN5GFypkPhG4v8BjX6FjZ8Xj3B
         jEWUiqo6G43q0/GLoNmiyPWEM9gFc63tKO/Ouut8vqHZXzLeDWYSoWOADRhA4xtV3qsZ
         8IbH71Yequ3w+p6pjr6fzLboPkzMZ3xAqH4Fzq/t82NYbz8kBpOV5yPkV9TjM4k49xoL
         hmKw==
Received: by 10.50.185.231 with SMTP id ff7mr5919123igc.40.1350191261820; Sat,
 13 Oct 2012 22:07:41 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sat, 13 Oct 2012 22:07:11 -0700 (PDT)
In-Reply-To: <7va9vp1wa8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207613>

On Sun, Oct 14, 2012 at 12:02 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> The description to justify why it is ctype2[] seems to have been
> lost.  Intended?

Nope. I added the description after generating patches and forgot to
update the same to my branch. Thanks for catching.
--=20
Duy
