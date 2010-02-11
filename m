From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] Support working directory located at root
Date: Thu, 11 Feb 2010 19:44:51 +0700
Message-ID: <fcaeb9bf1002110444v4ada90f5t8fd7d9163956c9f3@mail.gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
	 <1265734950-15145-3-git-send-email-pclouds@gmail.com>
	 <201002092019.45134.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 13:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfYPi-0002M1-I2
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 13:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0BKMox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 07:44:53 -0500
Received: from mail-px0-f184.google.com ([209.85.216.184]:54137 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0BKMow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 07:44:52 -0500
Received: by pxi14 with SMTP id 14so797466pxi.20
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 04:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NUmGsmhL0AnSOldKtEKlPL1r9RWn7WY0rRpDhCn9LMA=;
        b=RFchIvO1D5AZt0xzcdtXy8QszYIl+labVih/BknlaOns8tQq1z5zXGAD4kTEPJ9APn
         SKKAAoEPzKyG2MCH5GULa8yxTuIr3gI0+glrAjrS7pTSHlWf6O3I/s4i86Pen5A1k5ut
         0JDusU38L59yEnoeN1zGQ7ph1iYgXen8BbYXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r7dbN9nd1mQ1C3hWj/LSRHerVix2oDZ8i49/uD6UUVmoZD8x/Osp8+v2Ja1rvwm1q3
         NwZvHS2qBfRXb/jBkMq9bhe9RHDFh+mZRaTiQhMkpgC4KYEN0r7so+aQkuKiXWSBBTM1
         43YRWwTjVNL9X6LR+FyDM9Kz/1B6dXX3/efrQ=
Received: by 10.115.134.9 with SMTP id l9mr1145550wan.91.1265892291979; Thu, 
	11 Feb 2010 04:44:51 -0800 (PST)
In-Reply-To: <201002092019.45134.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139586>

On 2/10/10, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 9. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy wrote:
>  >  I said I would have code change for DOS drive too. But I take it =
back.
>  >  Supporting GIT_DIR=3DC:\.git might be easy, GIT_DIR=3DC:.git is n=
ot.
>
>
> One does not set GIT_DIR=3DC:.git; it would be insane because it mean=
s ".git in
>  an unpredictable directory somewhere on drive C". It would be great =
to
>  support GIT_DIR=3DC:/.git

A bit off topic, but make_relative_path() may need more care for the
Windows port. I thought of making relative path between C:/foo and
D:/bar but it should work well for that case. //machine/share1/foo and
//machine/share2/bar may fail though.
--=20
Duy
