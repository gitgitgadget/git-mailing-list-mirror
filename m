From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Determining commit reachability
Date: Mon, 6 Sep 2010 16:05:59 -0500
Message-ID: <AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
References: <4C83FEC3.3040101@gmail.com> <7viq2jv05c.fsf@alter.siamese.dyndns.org>
 <AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com> <AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Artur Skawina <art.08.09@gmail.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 23:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ositd-0001i3-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab0IFVGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 17:06:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53559 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0IFVGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 17:06:20 -0400
Received: by gwj17 with SMTP id 17so1674420gwj.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZDHEvOGfJj3/8iCz0f67BeHGVpnSbPK7Z/ye7ZRAytw=;
        b=Ach07prJsCwh8YTMs3IHIES3N6yoiqYWOpUfFG4DfQSocl0eX3mDu+h6JNHVlnxHm4
         r8jla7XTNGrur9j0Q3wNobt4i10A2tqvupGfvm0a0zO3C6N/RoCAnoVrF83vEsul+5TY
         ViI59/U5p5xn+XRym30sNpdYHzkHwx1TahRqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CS97pmWZzYiJlhTyJ9tqhA+jV4wR3qmad8kCqPC0KZ9vXnwnjBywh99K6/gJXiDlZQ
         hsJVAOOHSf7HfZU9XNygKT4XI2TAKjN2a8ClCuQAzsZt/CQtLAzdn/TjAY9MzmVgenJ6
         gHIy4ri6EAHtz4OEdI4bfhKnPxCl4c5rA0T9w=
Received: by 10.150.54.21 with SMTP id c21mr327381yba.430.1283807179191; Mon,
 06 Sep 2010 14:06:19 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Mon, 6 Sep 2010 14:05:59 -0700 (PDT)
In-Reply-To: <AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155622>

Heya,

On Mon, Sep 6, 2010 at 15:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Mon, Sep 6, 2010 at 20:45, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
>> In case anyone else is wondering, '--with' is a hidden alias for '--=
contains'.
>
> Maybe it should be documented?

Junio added it that way back in "git-branch --contains=3Dcommit"
v1.5.3.6-879-g694a577 (Nov 7 2007) when the feature was added. Junio,
do you remember why you added "--with" as a hidden alias?

--=20
Cheers,

Sverre Rabbelier
