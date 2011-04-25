From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.5
Date: Mon, 25 Apr 2011 03:07:17 +0200
Message-ID: <BANLkTi=77Z-AgBs1YxUvjMS=5dufWMZrNw@mail.gmail.com>
References: <7v39l7mlwh.fsf@alter.siamese.dyndns.org> <BANLkTikhkCDZ5Crw+KGWBprXd6qoFOH8kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 03:08:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEAHU-0003KL-Cm
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 03:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab1DYBH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2011 21:07:58 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:32857 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab1DYBH6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2011 21:07:58 -0400
Received: by vxi39 with SMTP id 39so1490112vxi.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=x+oXSnXBUZv+fXimyyQvXtzZ7285LnSDiYq3SIPN3WA=;
        b=AdlymQXDIlWL2UgGfJpSf19UMhNxSU7I3AmFCuufjv2jsAsIV+8On1NwZoFJ8P7tF2
         C9zsxaGRQl6Zf+GdNHF1EooT9LmyAsY8r/Vs2cmL7sT8jIIYcCfPJxT3QA1oqAOyr07I
         oqvAKcSN9S1Oi5y0qJg4h315xzTcmZ33vtdOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GuZqVXlSM4NGDCX1KJvSJB5iFgtKefnGzeUKaH4XA6a9ZiBAVVN2nSv3jBV0e55dzJ
         b6m6OL8Pgy6rt051SkOZV2r9+UOluu2MROqOdpfpTlA/oov9/LfeZQviQMrtZWai9k7H
         xT/KbkoVYDQbs1ZDgG+UTHMTt8AcTDLLre9Dc=
Received: by 10.52.94.48 with SMTP id cz16mr310806vdb.173.1303693677175; Sun,
 24 Apr 2011 18:07:57 -0700 (PDT)
Received: by 10.52.169.170 with HTTP; Sun, 24 Apr 2011 18:07:17 -0700 (PDT)
In-Reply-To: <BANLkTikhkCDZ5Crw+KGWBprXd6qoFOH8kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172010>

On Mon, Apr 25, 2011 at 02:00, Sebastien Douche <sdouche@gmail.com> wro=
te:
> Great! Thank you for this new release. Btw, I've some questions, sorr=
y
> if these seem like frivolous or stupid questions.

Ok, they are stupid questions :(.
>
>> =C2=A0* The codebase is getting prepared for i18n/l10n; no translate=
d
>> =C2=A0 strings nor translation mechanism in the code yet, but the st=
rings
>> =C2=A0 are being marked for l10n.
>
> Where are pot files for Git and Gitweb?

$ make pot

>> =C2=A0* "git checkout --detach <commit>" is a more user friendly syn=
onym for
>> =C2=A0 "git checkout <commit>^0".
>
> What is the interest?

=46or inspection (read the doc man).


--=20
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche (agile, lean, python, git, open source)
