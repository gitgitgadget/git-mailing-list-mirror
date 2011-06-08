From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 03/19] t5800: document some non-functional parts of remote helpers
Date: Wed, 8 Jun 2011 21:51:59 +0200
Message-ID: <BANLkTinP2bnREuok6ptc7oBKdiPfqUqG_g@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-4-git-send-email-srabbelier@gmail.com> <20110608192850.GF27715@elie>
 <20110608193630.GH27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:52:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOo3-000557-MW
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab1FHTwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 15:52:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53577 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1FHTwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 15:52:39 -0400
Received: by qyg14 with SMTP id 14so467745qyg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jENvlec/IJqoDaJ0AYtJoQ1j2LnJkUThjYu3YsIKZ/8=;
        b=tUrxsR9vWBeB2v1j7Tr7171vWWnHNQu1nZ2CDrRdnr/IGv/pSCJJhsq0cfZSjXeqzh
         /E0QmDz2VPeCY/fc4GMVYMzmgCqyt4NpZdwO3h8ksJvQ0WTXUQXIu9bsil55Jg3O7omP
         EfIjMIwjnRFWBabvr49iy4IhYJqWbJUt2zcgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lejjC3tFHgX6s4p4bdv5L+sBnS4SHarNPWcrLV+1C7Z2jN7IUmClUA3KDG8xrmoqju
         pMfCmRzsmJGpRwDZyZrW2bna/dmjU7kgvYhVBveuh4KzqwNx9V3aStH/EP7IXfugJCzB
         JvkAh1TDt+Ed9MT3pD1yQbZkqDDDdgerKn4Tc=
Received: by 10.229.127.105 with SMTP id f41mr5943670qcs.15.1307562759101;
 Wed, 08 Jun 2011 12:52:39 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 12:51:59 -0700 (PDT)
In-Reply-To: <20110608193630.GH27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175452>

Heya,

On Wed, Jun 8, 2011 at 21:36, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Gah! =C2=A0Clearly I am not thinking straight and it means the
> transport-helper.

Yup.

> ... the level of permissible hackishness goes down :), making teachin=
g
> fast-export about refspecs the only obviously reasonable fix at first
> glance.

Or, as I mentioned in the nearby thread, by having
fast-import/fast-export not modify any refs at all, and do that
separately.

>> Anyway, I don't think this should be in the commit message for the n=
ew
>> test which doesn't even know about the remote helper protocol. :)
>
> Sorry for the nonsense. =C2=A0At least this last part still applies.

Sure, this was just a resend of Peff's patch, it does need a new
commit message :).

--=20
Cheers,

Sverre Rabbelier
