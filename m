From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Sun, 20 Feb 2011 16:30:07 +0700
Message-ID: <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com> <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 10:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr5d0-0006kx-75
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 10:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1BTJaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 04:30:39 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44365 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1BTJai convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 04:30:38 -0500
Received: by wyb38 with SMTP id 38so229513wyb.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pInKHIi9ZxPD434DJ3htfhnIl0wHhxeSq9J/UihJbP8=;
        b=xcOP6Gm5S5njPAmJE6cKjxUSlhgf/j3Ulmd28jCm7rGndOoin+PgwbW/SvQwW7k31z
         eOiyiid/sI/g2qkY2OSpLHMqnh+8NKHP41XQpMmfBnQdpOGtdbYmH7hJ7T2X2YF97caU
         jIIU1F1XKfFqoY+FWWokoGXSqNxO4ZUvMY0Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SZD6LiulJUZ2D+qz+Q4CYL3d0Zy/PfLleoVjnvFEg5w5eSrncRh4My58TRmnTrH+wr
         Wuf2sSm3KvnOx6S97ADQtOyeYW2S0JpYC58E2bOOvc6Qm3ZjrxIIrQPcZP5rNKdBal6z
         nkln44wNRhsIQoh78F0Py9jccFl8jZNt1Qo2Y=
Received: by 10.216.186.144 with SMTP id w16mr172975wem.13.1298194237099; Sun,
 20 Feb 2011 01:30:37 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sun, 20 Feb 2011 01:30:07 -0800 (PST)
In-Reply-To: <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167405>

2011/2/20 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/9/6 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> This bases on the original work by Robin Rosenberg.
>
> Junio, in the "what's cooking" you mention that you might jump in to
> improve this? Duy, are you still interested in carrying this forward?
> This patch [0] would be helpful to the hgit people as well :).

I can try to study resolve undo extension next week and see if I can
write it down in the document.
--=20
Duy
