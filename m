From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 16:26:01 +0000
Message-ID: <AANLkTil8sHZrfvHetwzjhOsyprsqrf7-XRS3B8qKH7cs@mail.gmail.com>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl Stenerud <kstenerud@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 18:26:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTH9t-0002JA-Gu
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab0F1Q0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 12:26:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39760 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0F1Q0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 12:26:03 -0400
Received: by iwn7 with SMTP id 7so165709iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kv4ze3J6vAs6JyGurE0HX8Pjdpe94nX2wh3smCpg2fk=;
        b=tEAXSDVZDLgHkwvjMjGx9Sns99qypp4/fiNg3o6FadM/kr5bRh2PSZvXQaSEfAvSuB
         Cv8tlF9/0goGm1AxSVkHDEDgI1VP5AHhmhxHsJr30yn/btbhVrLL3wcyb4pzGGemfLua
         1IHunJkdbNrLRwR0jxqGa4ERpnNHdM38Pw8CE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hF/1G2K6J0Xgr7Qr2vjWLn0VHD31xgGzFZtPJsGCO3J4GLUB9giO+9RJg5EBkzmdmk
         HaMyjxdwjmotTomwaLjXgFPtgND2wDCoh8k+nfNEIj9wnPCsqK4Q0p3TnrFCoLCkX4ch
         TpoYEI2xnDAEGf6anixU6Je3Otbh3iaBmYOZA=
Received: by 10.231.14.201 with SMTP id h9mr5366164iba.118.1277742361446; Mon, 
	28 Jun 2010 09:26:01 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 28 Jun 2010 09:26:01 -0700 (PDT)
In-Reply-To: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149836>

On Mon, Jun 28, 2010 at 16:10, Karl Stenerud <kstenerud@gmail.com> wrot=
e:
> The git help tells me I can disable it by setting gc.auto to 0, while=
 the mailing list archive tells me I also have to set gc.autopacklimit =
to 0. =C2=A0This is fine, but if I do that, I won't know when the repo =
is in need of cleanup. =C2=A0Is there any option I can set to instruct =
it to simply TELL me when it's in need of gc?

Anything that tells you whether you need to gc would incur much of the
speed penalty that running gc itself does.
