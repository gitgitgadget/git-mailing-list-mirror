From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Restricted git push ?
Date: Tue, 19 Jul 2011 15:35:42 +0530
Message-ID: <CAMK1S_jsv-pFy6bNPG=EK=4YsJOh3GUZ+_DAq6n36ajWuhyNaQ@mail.gmail.com>
References: <20110719150637.596b9791@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Jul 19 12:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj7Ct-0001Yh-LT
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 12:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab1GSKFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 06:05:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51191 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1GSKFn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 06:05:43 -0400
Received: by vws1 with SMTP id 1so2764449vws.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vxja08VW1YYUB3JNfvT746mex0Zon1km+dou+4jJ+5U=;
        b=fvAcgGoVg7zhztD8b7siN0EzUWS9Z/1xCpITsPwguSobfkAeHggVVOwMON1B5iwk43
         lOtIoK0gHExXYvMmZr+/A2RSNBfvnIowhB0bON00N8qPPvdYhyD07qzA9BLy7oE9LO1w
         TM1kUaL7GfljiU9MR/di5XxVkB4zEHX/4zFrs=
Received: by 10.52.173.235 with SMTP id bn11mr308515vdc.19.1311069942911; Tue,
 19 Jul 2011 03:05:42 -0700 (PDT)
Received: by 10.52.167.105 with HTTP; Tue, 19 Jul 2011 03:05:42 -0700 (PDT)
In-Reply-To: <20110719150637.596b9791@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177447>

On Tue, Jul 19, 2011 at 3:06 PM, J. Bakshi <joydeep@infoservices.in> wr=
ote:
> Hello list,
>
> I have installed git repo based on http:// =C2=A0protocol and both re=
ad+write access is based on a htpasswd based authentication. The git re=
po is "bare" so that push is possible. But I like to have push from a l=
imited users only, not from all. For the rest, only pull should be poss=
ible. Is there any way to achieve this type of ACL ?

man git-http-backend has an example config described thus:  "To enable
anonymous read access but authenticated write access...".  It
certainly sounds like what you want.

Not sure what sort of http access you have setup but ideally you
should have used that one to setup your server.  If you did, changing
it to work this way should be easy now.
