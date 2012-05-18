From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1] Documentation: git-rev-parse: clarify that --git-dir
 does not necessarily show relative paths
Date: Fri, 18 May 2012 17:23:00 +0700
Message-ID: <CACsJy8DNMcA_FKbKAYMvr19JqtsDy9a5nGBg8UoiAnOqunV2ow@mail.gmail.com>
References: <20120517182304.GA14367@burratino> <1337333004-23164-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 12:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVKLS-00027I-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 12:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967943Ab2ERKXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 06:23:33 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39737 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967636Ab2ERKXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 06:23:32 -0400
Received: by wgbds11 with SMTP id ds11so722204wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1lIOeM1Hs+dgTIuasoz08Ffqzq3mEWxEgBLJ81QGR8E=;
        b=fxyw/Foq9R12GElbSuOlP1SGIVdjxwwrMst2W6rkjK19J56CW+0/JDALXZ8UIyJUAL
         n9YxgREawz7QQsf+T5g5Y9K8qliRvY4hLjjx8x+6ne1zeROPlRPlIpIh18k4vG5MhAYL
         54YwePSYf1QBoqp2oVL/gkNxlDRCWbOManCriYJTBcJMmb016ab/79zR2e7FkSNvtj3A
         ppwTu24PPFEcg9tL9hDPNB4to2J5fbPzY1opis6wXO6zrW7IjSqU4WGji13blBRNrcgL
         6RVjtZTXvMPZZYgnS0Jp5d14I3PwWS51kRisYyX4FBCgCv/ztUzn6wPblPNvjQbRmpYI
         0zoQ==
Received: by 10.216.227.214 with SMTP id d64mr6596786weq.93.1337336610587;
 Fri, 18 May 2012 03:23:30 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 18 May 2012 03:23:00 -0700 (PDT)
In-Reply-To: <1337333004-23164-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197946>

On Fri, May 18, 2012 at 4:23 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> @@ -137,7 +137,8 @@ shown. =C2=A0If the pattern does not contain a gl=
obbing character (`?`,
>
> =C2=A0--git-dir::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Show `$GIT_DIR` if defined. Otherwise show=
 the path to
> - =C2=A0 =C2=A0 =C2=A0 the .git directory, relative to the current di=
rectory.
> + =C2=A0 =C2=A0 =C2=A0 the .git directory. The path shown, when relat=
ive, is
> + =C2=A0 =C2=A0 =C2=A0 relative to the current working directory.
> =C2=A0+
> =C2=A0If `$GIT_DIR` is not defined and the current directory
> =C2=A0is not detected to lie in a git repository or work tree

Definitely an improvement. Thanks.
--=20
Duy
