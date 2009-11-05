From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 5 Nov 2009 10:41:27 +0100
Message-ID: <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com>
References: <4AF19630.2070402@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 10:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5yqx-00088x-1s
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 10:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZKEJlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 04:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZKEJlr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 04:41:47 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48108 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbZKEJlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 04:41:46 -0500
Received: by ewy3 with SMTP id 3so4045859ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wvzYnz+s5gEaWMcVcW1jcwwdDqEy6gy/M+TLJT9Ui6g=;
        b=Bcr617Sucsw/PpFodLCNtfsDGEiKQP9AuhEb/13+A02rSOMDbBPlu/cs5g2+nB1kP1
         yh3eAUI3QN+DKs2dicHKg19ueiHNkFflrD+57rjq3y0cPIa64iqHqrLESRAWn+lFGDZ/
         WSP6gQYcpByTRB9EJnV+5m8AiwzETnOvTHHwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=owsW76oafe+dr82tSijVD/dWgKljZrjhBK4hdCG40TWcnCSXLOKml1TfXUTEPh3KnC
         Ga7P1kG90f5P827PPZXQhLe8hQ2yTa59ZvtUWZZ1nxTwUcy1Vl03C51GSnT76PuxEQrM
         ZgqTwoQX9K/eKkO7vp8sSZF6Amc0GM00qMm74=
Received: by 10.213.8.28 with SMTP id f28mr1202125ebf.39.1257414107216; Thu, 
	05 Nov 2009 01:41:47 -0800 (PST)
In-Reply-To: <4AF19630.2070402@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132217>

Hi Abdel,

On Wed, Nov 4, 2009 at 15:56, Abdelrazak Younes <younes@lyx.org> wrote:
> Hello Marco,
>
> While recompiling latest qgit4, I stumbled accross this. I am not qui=
te sure
> you used a QLatin1String instead of a QByteArray but the attached see=
ms to
> work fine...
>

Unfortunatly I cannot say the same here ;-)


>-class ShaString;
>+typedef QByteArray ShaString;

=2E..... cut ......

>
> =C2=A0uint qHash(const ShaString& s) { // fast path, called 6-7 times=
 per
> revision
>

=46unction:

uint qHash(const QByteArray&);

is already defined in the Qt Core libraries, so I have a link error
with your patch.

BTW I don't think I have understood the reason of your patch. Do you
have a compile error or something ?

Thanks

Marco
