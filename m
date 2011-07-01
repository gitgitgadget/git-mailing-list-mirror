From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] test: skip clean-up when running under --immediate mode
Date: Fri, 1 Jul 2011 12:49:26 +0200
Message-ID: <BANLkTimzFDquxjsZHz9OfatR=oe+R3xzTg@mail.gmail.com>
References: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 12:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcbIf-0007Yl-BX
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 12:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab1GAKuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 06:50:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49579 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab1GAKuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 06:50:06 -0400
Received: by pvg12 with SMTP id 12so2398424pvg.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=G57R99ivTzkKxLYDwwf5TEw9j5dSIHYoyD7sVA1bbrY=;
        b=JBwjKRIlkdoM6ua4Xm75VTH90LGoc44X20jXwJg/Lz51NtsTgOYbTMjPxEi6YnXHhc
         V0rMHkTO1Wvz7DzZtyOKjr2HX3VM6YdSbu/nEbPs5G07MbqNLjGquXkNEY0RCAqzZzmS
         ZMSlqqGsnLucJRk77w88nFapKnyVwEuUjT7IU=
Received: by 10.68.20.4 with SMTP id j4mr3665271pbe.301.1309517406072; Fri, 01
 Jul 2011 03:50:06 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Fri, 1 Jul 2011 03:49:26 -0700 (PDT)
In-Reply-To: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176520>

Heya,

On Mon, Jun 27, 2011 at 20:02, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C2=A0* Likes, dislikes?

Makes a lot of sense, the 'test_when_finished'-ed code will get
executed when the test doesn't fail anyway, so I don't think there
need to be a way to turn this behavior off. (I.e., the patch is good
as-is).

--=20
Cheers,

Sverre Rabbelier
