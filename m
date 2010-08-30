From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 05/13] transport-helper: use the new done feature to
 properly do imports
Date: Sun, 29 Aug 2010 19:28:29 -0500
Message-ID: <AANLkTimoWjN+Q7XOkNMtoczpDQzecFgpnLYembQMmEdL@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-6-git-send-email-srabbelier@gmail.com> <20100829220239.GG1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 02:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpsFH-0003pb-H3
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 02:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab0H3A2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 20:28:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38081 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0H3A2t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 20:28:49 -0400
Received: by yxp4 with SMTP id 4so110065yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R4mbzNevzw1jj2r8k9A3NqeGSRZj9FpRSpTnyK0WYes=;
        b=coAq6i/dnuv/nNbA/Z6wg5gFC/R6pvh5YT+ZNyPPAw8LD6CZRMMv+2yKzmK7lcr8et
         dM3o84ikdcwqzYPvnqbwS3KNfhdJLsqsTzsOzUNJXN8RXfgFxEbje+JFeImK7HYGj5VY
         QyjNdehAyL/JOfLdPcj6BmLb78DrEjGmFncT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KJXkRDYGP4YGN6aDgxyegatXiMlutQd5mRA4gWmi+FT+lRdnthA/y6yshk7neStip0
         c2DbTTYQOAgbPiHcZSf83yd6LKKG5z08iGg8q4giF/Z62ON2FyyybW9DwTenxoHVKFZN
         jGqVyOSqhrmbDyOyQtsAFJs90LI9v6/d4Yxow=
Received: by 10.150.52.11 with SMTP id z11mr4351405ybz.149.1283128129243; Sun,
 29 Aug 2010 17:28:49 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 17:28:29 -0700 (PDT)
In-Reply-To: <20100829220239.GG1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154734>

Heya,

On Sun, Aug 29, 2010 at 17:02, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0In other words, use fast-export --use-done=
-feature to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0add a 'done' command at the end of streams=
 passed to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote helpers' "import" commands, and tea=
ch the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote helpers implementing "export" to us=
e the 'done'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0command in turn when producing their strea=
ms.

Yes, that's a more accurate description, thanks.

--=20
Cheers,

Sverre Rabbelier
