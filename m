From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage warnings
Date: Fri, 3 Dec 2010 21:45:25 +0100
Message-ID: <AANLkTikNLqBo+5JnVSRhpdC9qWJHggmo02-xDCxmmZKG@mail.gmail.com>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
 <20101203190050.GB14049@burratino> <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
 <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:45:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcVu-0004X2-2i
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab0LCUpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 15:45:49 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:59070 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab0LCUps convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 15:45:48 -0500
X-Greylist: delayed 5994 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 15:45:48 EST
Received: by gxk19 with SMTP id 19so5309275gxk.11
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cYqXFqEX/D51e/EMeLX02zt/b39ES0PpXefCNE4X9Rc=;
        b=LKYpnElJIjVc7pnnOzzYmR/X5ONuEuMEeE6Pbxm2mcHsYIGmcfJLnN7fb1KOYIufCK
         hyKDdEwGinnCSmjPklEea5zN8fRkQjS4MHkzYwW8auQiQm3wDK6qsb3J4+fpB6C60QUg
         DdEHGpbBzmOa4ya35kxDFXhi6rteCZdJLD5Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=moBo68m6noj9oiZBEpO9qrRz4XcV9+3VMHQQxNudlN420ufaAlLug3GlB11ge5kYxw
         yWbun1NgH0u73v8Tp1ka/7GYRtn8rnUTeg0K1BNi2Z77kaEGBOS4U1SkFoxIIHByfefP
         TvBJwvdzs0iNZ/kLF8o907uwkWDLFmAj+DUuI=
Received: by 10.151.84.7 with SMTP id m7mr4424957ybl.359.1291409146775; Fri,
 03 Dec 2010 12:45:46 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Fri, 3 Dec 2010 12:45:25 -0800 (PST)
In-Reply-To: <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162848>

Heya,

On Fri, Dec 3, 2010 at 21:23, Santi B=C3=A9jar <santi@agolina.net> wrot=
e:
> The problem is that many parts of git-pull.sh/git-parse-remote.sh
> assume that you are not in a detached HEAD. Can you confirm that the
> following patch fixes it?

Yes.

Tested-by: Sverre Rabbelier <srabbelier@gmail.com>

--=20
Cheers,

Sverre Rabbelier
