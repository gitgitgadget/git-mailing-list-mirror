From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Determining commit reachability
Date: Mon, 6 Sep 2010 15:45:55 -0500
Message-ID: <AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
References: <4C83FEC3.3040101@gmail.com> <7viq2jv05c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Artur Skawina <art.08.09@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:46:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osia5-0008Pc-3z
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab0IFUqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:46:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47302 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab0IFUqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:46:15 -0400
Received: by gwj17 with SMTP id 17so1670089gwj.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BLlvUgFF2rr7jexIfadcXHDslISjq0NORrGDGQuAIdA=;
        b=OAtgFXtuNDJx0MFlwF9WrRKH+9PBNlOhO+xLpwRIPO3TdKVZeacdyzPhtxDYRBRY/B
         PREMZ+ADiK+rXCvdSG6Kmqlr9u1qJcrcWkDKFNFkaAUUCebJwYHrjT+gBWslqJFCIecC
         UCFuRxb9JzQ8heRT2EiWTYe+xMBxB3OocEpdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R/oKpIw2Em4nTZbz6Tjc/r4Z5EzY3mXRPNJwPrtD09ocstYVY9Yha/EBFGKC/Rzpws
         6B56elbFfyGs/C5JET0mQ7b++TIyfiAZAk7tZsM+//2Dn+EuOCpPzMwec7pU6nrM9HV8
         VsoVR870ipPA95k1Jh1GsN7FrpFxdc7ntlPWQ=
Received: by 10.150.136.4 with SMTP id j4mr518916ybd.293.1283805975136; Mon,
 06 Sep 2010 13:46:15 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Mon, 6 Sep 2010 13:45:55 -0700 (PDT)
In-Reply-To: <7viq2jv05c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155614>

Heya,

On Mon, Sep 6, 2010 at 01:47, Junio C Hamano <gitster@pobox.com> wrote:
> Depends on the definition of "best", but I often find myself typing
>
> =C2=A0 =C2=A0git branch --with C

In case anyone else is wondering, '--with' is a hidden alias for '--con=
tains'.

--=20
Cheers,

Sverre Rabbelier
