From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Large pack causes git clone failures ... what to do?
Date: Mon, 6 Sep 2010 10:04:55 +0930
Message-ID: <AANLkTi=4vF5o+oU-s=j8AyLjZ-FL5i2CbVv-ZQmkiB+N@mail.gmail.com>
References: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
	<20100831180247.GF32601@spearce.org>
	<AANLkTi=O5SbLRttzR0YwrHVEMz5gxtdTo9Z5C6V1yE1e@mail.gmail.com>
	<AANLkTik2Ms6qjQAaa_H8GGwmTG1fsk+8GR2y7ZmLviY-@mail.gmail.com>
	<20100901143819.GI32601@spearce.org>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 02:35:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPfs-0004Ax-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab0IFAe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 20:34:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54446 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab0IFAe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 20:34:57 -0400
Received: by wwj40 with SMTP id 40so5715566wwj.1
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=loPHcVDKkyyfhZuPYjNNwGBR+dkXSoKh6KRjhqyhXZc=;
        b=KATuxGuOJkmzRqyCbgyv+6rFE21U8NqmXb01KNsfomtKKKOhJD85+TlRWr9i3KXVZe
         RjNYPDpH3ZFBV5Q1174FHq1rCMMj/KsBCkrPB70lEzsO38iMJSLEYkmk4Qo7Fkxlm1Dy
         CHX+xx37ERABoW2Rt/DoaJDvhJXQmsD+bKfPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=T2BqhrkdmGTHpbz2URl0Eu1Xxm/txqHtNkvikDs6PPy7BS1gwGP8ee4WuvVHcs0aqN
         CSTs/I6zPXMfKb9P/D1dhdw6rLwNrUmEUiCIpa80+zTOXaJ9d+tHdCdEirCz0AfylFed
         xHBtBF9xai9pMRmigdarJbjzphGrXGQ1O+Bo4=
Received: by 10.216.0.76 with SMTP id 54mr3180107wea.49.1283733295249; Sun, 05
 Sep 2010 17:34:55 -0700 (PDT)
Received: by 10.216.164.19 with HTTP; Sun, 5 Sep 2010 17:34:55 -0700 (PDT)
In-Reply-To: <20100901143819.GI32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155508>

On Thu, Sep 2, 2010 at 12:08 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Geoff Russell <geoffrey.russell@gmail.com> wrote:
>>
>> I'm still interested in whether clone from a client take note of the
>> pack.packSizeLimit if I set it
>> on the server? Or does it use the client value?
>
> Neither.
>
> A clone doesn't split its pack. =A0It stores the entire project
> as a single pack file. =A0If your filesystem cannot do that, the
> clone fails.

I've moved the "master" repository to a faster machine with plenty of
memory and all the problems have gone away.  I was making wrong
guesses about the cause. A fresh clone gives a huge pack, but no proble=
ms
and everything runs much better

Thanks for your help.

Geoff.
