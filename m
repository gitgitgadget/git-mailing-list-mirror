From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Could #-ignoring in commit message be smarter?
Date: Sat, 4 Sep 2010 17:30:01 -0500
Message-ID: <AANLkTinTxFveiuJvCUyB5Hghj-Jy+=LfhPJhtW1UYkSH@mail.gmail.com>
References: <AANLkTimgt6kjTkc+gxyOmTz03bdnfiRzgt4p8vymQ=VY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 00:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1Fu-0001an-Uk
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab0IDWaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:30:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37548 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab0IDWaW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 18:30:22 -0400
Received: by gwj17 with SMTP id 17so1194236gwj.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Eu9o0r6OO2EYSuYlmtBQDLsUb9vsW1KbFUmjG3rdd/8=;
        b=M52D06ByC9CCe8FO1/gP/iFsPAdGgigB2851WwOIeY08cNT2Gb/B4Jst/w0SnkqJ3q
         gAIdiPuPFfEA/KolzHE8zzG+JdorshVPHMO66F1Ugo5JEbis6mYbnZb33bKNcojoPFKV
         9HCty+PsIRd6ZnHUl5Q66OTla00J2+u0Da94o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hrWfWAIcO241NX5UBvmaLXDseu9Q9MYXucec12U7U5ZLw6olLFFl09KJldRzhlhuf+
         h+PlZy/Prz4wC/s/eDDk3TDehHv9z/jK+JAJVymlILNeSFcxo17CD/tMxdTHll2W/yVL
         Bj3PCLWMOWhgMOBknXXISloi7CZ+y3MowxslQ=
Received: by 10.151.108.5 with SMTP id k5mr1075801ybm.58.1283639421426; Sat,
 04 Sep 2010 15:30:21 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sat, 4 Sep 2010 15:30:01 -0700 (PDT)
In-Reply-To: <AANLkTimgt6kjTkc+gxyOmTz03bdnfiRzgt4p8vymQ=VY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155379>

Heya,

On Sat, Sep 4, 2010 at 17:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Where I'm referencing the #-character in the commit message itself fo=
r
> some reason, and due to word wrapping it just *happens* to end up at
> the start of a line. So the commit message silently becomes:

Isn't this rare enough that it's not really a problem? I mean, sure,
when it happens it's a PITA, but it's about as painful as doing `git
commit -m "Yay, it works!"` and having bash history magic blow it
away. After a while you get used to it and either remember to escape
the bang, or not use it?

--=20
Cheers,

Sverre Rabbelier
