From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RE : trailling whitespace with git am ?
Date: Sat, 15 Aug 2009 00:16:58 +0200
Message-ID: <81b0412b0908141516t757d2cb1tc6d0ff3805691418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?PICCA_Fr=C3=A9d=C3=A9ric=2DEmmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:17:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc559-0001an-CR
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 00:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734AbZHNWQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 18:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756665AbZHNWQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 18:16:59 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:55945 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbZHNWQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 18:16:58 -0400
Received: by fxm11 with SMTP id 11so1414911fxm.39
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=e+f/vPbW7cSukra5XXBj4gVpgK6kNivgnFekvh2+yvk=;
        b=esY29Whxf/B6yKLqjyO5sbh7zpoWbvVjAfgX+QVqIA+4/+bTj9PNvolYjEgQi3CJ+m
         c+1rraEWlTlwVA5IYPhN4C+X7siuOSG6XP0GeUbVkn2fNPNGorDP80mhHAcG+iyakTb4
         IBdLI+ILNH5hfkcqY/4Zkmh9qc0AI+d92HHHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=l1bWj8tf5yrK+z8zZyEu6dk5AB0G/WzQeeKwQT3j17O5uEfewQ3kpa/qVKw9RYlopV
         opVvh02nL16Zf/2SB/lgI2bIOwI1bUrCnZi6Y0i2GqeVADUhwa8KKGNjsINxd3Ys1d7b
         tc0+CSeBPovOJ6oAr79Eh8wZvDG0OpTPeCA+A=
Received: by 10.204.114.143 with SMTP id e15mr61028bkq.204.1250288218684; Fri, 
	14 Aug 2009 15:16:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125962>

On Fri, Aug 14, 2009 at 23:50, PICCA
=46r=C3=A9d=C3=A9ric-Emmanuel<frederic-emmanuel.picca@synchrotron-solei=
l.fr>
wrote:
> Maybe git apply should warn the user a different way if their is that=
 sort of
> dos/unix imcompatibilities.

As it all is history (in the new code) already, there is nothing to tal=
k about.
Git-am in "next" branch just accepts such a patch without a warning.
