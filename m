From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 00/23] http*: refactor (v6)
Date: Sun, 7 Jun 2009 08:45:50 +0800
Message-ID: <be6fef0d0906061745q1cd65958raff19241b221e447@mail.gmail.com>
References: <20090606164253.65a945ba.rctay89@gmail.com>
	 <7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
	 <m3tz2t43xr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 02:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD6WO-0001L4-Vs
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 02:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbZFGApv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 20:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZFGApu
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 20:45:50 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:60107 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbZFGApt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 20:45:49 -0400
Received: by pzk1 with SMTP id 1so1546727pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JvlILpEPuLEr0+I0HGyN4rfg57lgiWO2KYnpMUK4Cng=;
        b=o+XQOnokSepbf+sMRKfuKP3eCeEHuohiO8mPRiT6phn2EpLzaA308Q7nY6h+1Dto+f
         yERsCGaMTfYgOeQoAOou8++6zE85S/fLuRExvQjjP5u3VSnGqKDHMeGW0gY0KNulMe0X
         beFqXGex4x58s0xJj0b/+QZcq1yXb0UpTLM1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hkp4Ux2nxqKZP1RjiZK//88P3NHEakMkfaJcdeJt6qxXiH3yOkuRFmhgspbsPcQSls
         wHL+AcoPXqxFmXO4/qfQpPBBYfxdqnTg5tnPGNk0BXt2gVxlR8MLJuBkiY+OJfRg+C+p
         PB/wPaK2/0vH1a/ksUMsxNoOgJeGwVVToj9CY=
Received: by 10.142.185.21 with SMTP id i21mr1851391wff.311.1244335551024; 
	Sat, 06 Jun 2009 17:45:51 -0700 (PDT)
In-Reply-To: <m3tz2t43xr.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120947>

Hi,

On Sun, Jun 7, 2009 at 2:23 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> Before git-send-email learned --cover option, I have used the
> following commands to generate "Table of contents" for a patch series=
:
> =A0* generate patches to some subdirectory using '-o' option
> =A0 of git-format-patch
> =A0* grep for subject and remove "Subject:" line:
> =A0 $ grep -h "Subject:" mdir/* | sed -e 's/Subject://' >> mdir/0000-=
cover.txt
>
> This way I had list of patches in the series in actual order...

I see. I output my patches into one big mbox file; I'm sure your
technique can be tailored to that.

But then, isn't there a way to do this with git-format-patch or git-som=
ething?

> P.S. Tay Ray Chuan, this patch series is again not being replies to
> =A0 =A0 cover letter...

Sorry about that; I already used --thread (you can see that the
patches all have In-Reply-To headers), but the Message-Id of the cover
letter changed while I sent it out, so I messed up.

--=20
Cheers,
Ray Chuan
