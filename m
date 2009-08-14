From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RE : RE : trailling whitespace with git am ?
Date: Fri, 14 Aug 2009 22:48:47 +0200
Message-ID: <81b0412b0908141348icee65d6kf4188cbd68405c0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?PICCA_Fr=C3=A9d=C3=A9ric=2DEmmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3hu-0007om-9w
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZHNUst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbZHNUss
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:48:48 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:38056 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZHNUsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 16:48:47 -0400
Received: by bwz22 with SMTP id 22so1352457bwz.18
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=EeCtYY3Y9I9FFRSWk5a/F2MglLb0WwlQg2h3RI8SK24=;
        b=Ififq7jw+tZoiOesyqrAKaUSjaaR/V5WpVeUXvVnSTIbWGkMtrb4sBlhTryQ9tHYDP
         OekFP3rOlbEW1HiE4pK1AzC0fmRVhNCmjwXbThN9hYeaNsQI7wpKmhisznrKLpGYbrRJ
         NgkIn2O+3oKR1MYLcq/00WM0p23WNgix2K/4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=UF+b8Z1+kod+hGNWFRmuhAEA6pLoqngrQSdw6YaUPVbZNwNKtFgN3BJCAJat/TYwXC
         hsvq05GPPGcx+2KEKbyqPR75R4XPOnDYMSuFOGEqh8Ev9bW9q3HIiON1F73KZ2gmxQv4
         1c6+PNd9lbqYGaFVgoGLokSFRVQDqQ18pdBEw=
Received: by 10.204.15.22 with SMTP id i22mr1361644bka.13.1250282927156; Fri, 
	14 Aug 2009 13:48:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125953>

On Fri, Aug 14, 2009 at 22:46, PICCA
=46r=C3=A9d=C3=A9ric-Emmanuel<frederic-emmanuel.picca@synchrotron-solei=
l.fr>
wrote:
>> how can I do the difference between a patch with normal CR+LF (the a=
utor use this format)
>> and a patch without CR+LF due to the webmail ?
>
>> That is a question to your webmail provider but I think you generall=
y
>> can't. =C2=A0Use dos2unix as Alex suggested and you should be fine.
>
> git am --whitespace=3Dfix was sufficient to apply the patch
>

Depending on your situation it can be an overkill: it'll remove _all_ t=
railing
white space. Not just \r (CR).
