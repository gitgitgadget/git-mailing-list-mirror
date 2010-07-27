From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git 
	log --grep=foo".
Date: Tue, 27 Jul 2010 01:43:22 -0500
Message-ID: <AANLkTikGPMDvxQKjpKOBge8UwrC_GuC36_=C_tYR_ngr@mail.gmail.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr> 
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 08:43:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OddtE-0002HU-K6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 08:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab0G0Gno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 02:43:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41683 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0G0Gnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 02:43:43 -0400
Received: by gwb20 with SMTP id 20so370199gwb.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Zw3GSvV/j/8TJbFpvmotbXxTb7m5aV+qAMHydRTDKVQ=;
        b=b+chwbw9ZFKmAjaa3tq+C5wLUeZAuc12PoZwK9PS0SS5Z1bbuNf7tFPxZaW3fXZLmC
         sYVWhuVe5AnXyhYdSiM3Rv+zG09JqiSi8DEcEX9hBGQFkB9fpWdU6cwDJDAZa9IcgZpI
         2MoI2YsE4T/hYwxgnleS6RXG6cJPDGe5ce2XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xZyl23Uf3e2QCp2ZIGjsYJ0efFy32s3QWaPRYCGNVzEIxVYyYp/wvVJjOIGubP8chd
         l6ft35/xK7YCF3s/N+5Zyop4qAE6zdtqSbxp2jTwyy5oUrDGpq87hkGLDEjtEM98/Qp4
         7DYpvHdS8TLRF7Yxu0YBDJK0ukrmpmdOwnMvA=
Received: by 10.150.160.2 with SMTP id i2mr10338507ybe.314.1280213022779; Mon, 
	26 Jul 2010 23:43:42 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Mon, 26 Jul 2010 23:43:22 -0700 (PDT)
In-Reply-To: <1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151915>

Heya,

On Mon, Jul 26, 2010 at 13:14, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:
> + =C2=A0 =C2=A0 =C2=A0 } else if (!strcmp(arg, "--grep")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_message_grep(r=
evs, optarg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;

This one makes a little less sense since to me '--flag' are always
booleans, whereas '-m' can take an argument (such as '-m' from 'git
commit'.

--=20
Cheers,

Sverre Rabbelier
