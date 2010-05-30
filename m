From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/7] Add a memory pool library
Date: Sun, 30 May 2010 11:12:40 +0200
Message-ID: <AANLkTiltqraEFzYohs_89VbJQsevQC3Yp5RYWSe4b3jd@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-5-git-send-email-artagnon@gmail.com> <20100529090609.GA7247@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:13:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIeZy-0003nV-PX
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab0E3JNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 05:13:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33641 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab0E3JNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 05:13:01 -0400
Received: by vws11 with SMTP id 11so897860vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cgEeBrXU50lNi5Os7cmiceH6Bd19q3YWHJJu3bsoLe4=;
        b=euiTuoQvYrLBGOmNgt56StqXlRdIbUnppGfLnoEDBpB8+dLE81RpAxzzHmZO+MjLJ4
         Cp7rrOojEGI71ypkDRiPKjkY/RgQkbY1zgM2k7gLH3wAY7xDXVx1CaM17S8459SDMsKH
         WcBrmvqYvT2cWiQJ/kW4jVid0A9uF530x6U8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wchIK9qeLS/u+40+cuEV5dUlj66pA0i9DGjBBXYQKOEJRI6/jL2VXH7Y8H2dPYXItd
         8T0uphFeibmUPcJ+H5DRthW9s3rf35S433+OA73UCAn38vkcsxCC7aOKErFBfT3Zsq5K
         Acagfc2bg2jKC4+GKuEjOCvNTvJ47CH510WAI=
Received: by 10.224.27.131 with SMTP id i3mr1078966qac.141.1275210780173; Sun, 
	30 May 2010 02:13:00 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 02:12:40 -0700 (PDT)
In-Reply-To: <20100529090609.GA7247@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147992>

Hi Jonathan,

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hmm, like talloc[1]. =C2=A0How do they compare?

I've never used talloc. What basis can we use for the comparison?

> This makes functions with names like string_alloc(), which would then
> be un-greppable. =C2=A0It might be nice (though certainly not necessa=
ry) to
> provide an overview in Documentation/technical/ so there is no need t=
o
> find the definition of each function.

Definitely. On a related note, note that while compiling, a lot of
unused functions are generated which pop up as compiler warnings- I
haven't figured out how to suppress them yet, and I suspect Junio
won't be happy with them either.

-- Ram
