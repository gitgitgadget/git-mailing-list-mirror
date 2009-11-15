From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Sun, 15 Nov 2009 19:39:33 +0100
Message-ID: <fabb9a1e0911151039g7c7373b5o3c14a9056c419f6@mail.gmail.com>
References: <cover.1258309432.git.trast@student.ethz.ch> <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 15 19:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9k16-0000Xm-RQ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZKOSju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbZKOSju
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:39:50 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50808 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbZKOSjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 13:39:49 -0500
Received: by bwz27 with SMTP id 27so4980085bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 10:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IAgFoJog2UEZFCnpVgvEods74utZ16ZORJ3hZ421Ab0=;
        b=l+8dw5mgFNf0KLsD9GDk3z2ud9Wuoe74Gkw5QsQJknxX0ch9fEHesgwSGpiqTugz1v
         pv/6gwPtPxAUxaBMZNje49f7FsFSPJHz+/fSA8iyh8umxmgHiQCize83Y7RXAIGWIveL
         NTW3WEBofCLBR5TdSVU+NdLgMHYiUDelwFR6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kXSCcBfiaUVXVW6mazcdUSptPJO2qvIDCY8H6/sVcIUNvj5VL3FDrFKw0Jsj9SJ8r0
         7zG53v2J93hyn5yFwO0fZSb5DYp50Yp5506IZr/bM90XfGFEMoRBWnUPr97z67BMHM3G
         kOe+u9nK8CCumQF9vbULo4Vt6FU7uVvqEcye4=
Received: by 10.216.88.136 with SMTP id a8mr849613wef.77.1258310393358; Sun, 
	15 Nov 2009 10:39:53 -0800 (PST)
In-Reply-To: <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132951>

Heya,

On Sun, Nov 15, 2009 at 19:25, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$STRATEGY" =3D "-s ours"

Is this solid? Would "-s  ours" (two spaces) work?

--=20
Cheers,

Sverre Rabbelier
