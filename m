From: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Subject: Re: Modern Git GUI
Date: Tue, 26 Jan 2010 23:39:25 +0100
Message-ID: <8b65902a1001261439l309325dap43d0196e6e163f4f@mail.gmail.com>
References: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Andr=E9_Harms?= <andre.harms@kuhlsolutions.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:39:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZu4P-00006C-D2
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 23:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab0AZWj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 17:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141Ab0AZWj1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 17:39:27 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:43256 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab0AZWj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 17:39:26 -0500
Received: by pzk27 with SMTP id 27so1062441pzk.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V8gb0TE9xc4pibhgCdvWQORYZWZs5VbLhIdvQc63ZE4=;
        b=nbkn24++N/FS322E4XiAS92h30/CNQft+SOkBTrHuN8TIM5yix2DFEmb50UECWy9jz
         BG++pSdDAprt6mHLAvdHYyErXRTNeN2fcw83MvoB5NGPEYIiHKQ6LI6CRDU5pMCccbR6
         EDU6rjg1czyqlwwCIJ44kKS1anjB0vX4RMT7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=feWz80KvdynEG4t6kzqYJ6pqMezvGudzhdM/3CuXiO6kio/jEgSGYVlYBosQArNB8u
         LqMZoeGf84vx40wDtqJ3Byx7QH33AGDT3FMrn753DtAjuQBpL5bBD/A3QzvFDmv+HkP+
         mdimsOatEqynAffviBuHYQTgmB9Ic2Ie+bXPY=
Received: by 10.140.247.20 with SMTP id u20mr6002584rvh.230.1264545565729; 
	Tue, 26 Jan 2010 14:39:25 -0800 (PST)
In-Reply-To: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138081>

Hi,

IMHO, a really important question is: why do we have so many
started-not-terminated GUIs?

My point of view:
- a "good" GUI is a GUI that integrates well with a desktop
- a "good" GUI is a GUI that reuse an already existing/known metaphor
The most difficult is that raw Git is "stupid content tracker". So, a
complete GUI will expose too many features to end-user:
- which workflow: pull, push, email, ssh, ...
- topic branches: rebasing or merging
- and what about higher level feature: stash, stg, top git...
So, reading this, possible good GUIs are plugins for IDE with smallest
Git support.


2010/1/23 Andr=E9 Harms <andre.harms@kuhlsolutions.de>:
> Is there anybody who agrees or disagrees? I really would appreciate
> some feedback about that idea.

--=20
Guilhem BONNEFILLE
-=3D- JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=3D- mailto:guilhem.bonnefille@gmail.com
-=3D- http://nathguil.free.fr/
