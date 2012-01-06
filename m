From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Why usage function exit with code 129?
Date: Fri, 6 Jan 2012 15:11:36 +0700
Message-ID: <CACsJy8D8uKGhtg4zjbHsJCGmqjTwodzFmAZ5w=aUx9CdadVAfw@mail.gmail.com>
References: <CAMocUqSbiO2XC3PUEciyV3HxgqDPW_rTW-hYH4P=C=BFCSrQMQ@mail.gmail.com>
 <CACsJy8Amo_9-9oCgHbwOZvTaNOV3Jj6wLCTU7nZT5LeA55=NEA@mail.gmail.com> <CAMocUqSmes+x_tkP6V0OM5rQ5wDGmMm=Q2MFBPhz6Qvzz_SOTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R2l0IOmCruS7tuWIl+ihqA==?= <git@vger.kernel.org>
To: =?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 09:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj4uO-00079U-Op
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 09:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569Ab2AFIML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 03:12:11 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40274 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab2AFIMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 03:12:10 -0500
Received: by eaad14 with SMTP id d14so827830eaa.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 00:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cC0cXTQbyHNrTJhPAhMc99GXhzPy/s/gtJWHz9N9Erw=;
        b=YzT+fDe0NipqF6Pl1h4ydcW/MnXmdeBV0LboSTG+j3IXYhS31x8CmwgEiMdr1luahy
         Y97duVJLiaCQYk8BaUHaFeCj/j5ncxMEUB+HyKN9CeqbSb/2sUYrbrPjXcHn+uL5Pwo6
         1z3w8JiyI3ZoAalemry/JihBxZ5JVcPV8OGMw=
Received: by 10.205.133.139 with SMTP id hy11mr2145286bkc.98.1325837527149;
 Fri, 06 Jan 2012 00:12:07 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Fri, 6 Jan 2012 00:11:36 -0800 (PST)
In-Reply-To: <CAMocUqSmes+x_tkP6V0OM5rQ5wDGmMm=Q2MFBPhz6Qvzz_SOTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188017>

2012/1/6 =E5=BE=90=E8=BF=AA <xudifsd@gmail.com>:
>>> [1] http://tldp.org/LDP/abs/html/exitcodes.html
>>
>> No it does not mean terminated by signals.
>> --
> In that case, why not just use another code instead of the code that
> leads misunderstanding? I mean, as far as I know, exit code between
> 129 and 255 are used to indicate the program terminated by signal. So
> that usage function can only exit with code between 1 and 127. Am I
> wrong?

Because that code has been there too long (since 2005) any probably
all git commands, including plumbing ones, rely on it. Changing it now
may break existing scripts.
--=20
Duy
