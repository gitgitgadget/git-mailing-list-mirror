From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Advice on choosing git
Date: Thu, 13 May 2010 14:20:55 -0400
Message-ID: <AANLkTinIsXGxPhC8aICUTODIy2CVI9YRyeR7464h0Tbc@mail.gmail.com>
References: <4BEA4B46.6010009@smartmediacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Noah Silverman <noah@smartmediacorp.com>
X-From: git-owner@vger.kernel.org Thu May 13 20:21:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCd2B-0005rz-Fc
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 20:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963Ab0EMSVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 14:21:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33646 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab0EMSVP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 14:21:15 -0400
Received: by pwi10 with SMTP id 10so168074pwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jZTCpEJF+5fFYFVL0ZWOvab+6byKdmFro1URcuUZyks=;
        b=s39PGOELo4YBWYfxxvMtihUAGUMWMGOW4gzNtAsRzAW4Ub7WrJ8xXx3juncsd+WSDD
         sTqAYo8vosHohDcgiA55vhVp+2hQEEzQzJxDteUPkpEVbQ6iVWXiU/BqfJZdv+wY21mE
         hpINpOEbvImHpFca8Yz2VRdeLnSN3Vk6B5N3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tlcxaSmlCcUJ8sEgZPWhFgwOEraZpbSqB3tmyCLs0m7kCGNX3GICHD3lQp6JxvGcx4
         fmKejEsNhg4g+RYD6Cm8BL8eI+9ZgLA7IXuB8ECNvAf1HkABXCYj1XhFGHdJGrJ1A44Y
         35034MkaQf4uM7EHYOoScLegDMTGMmi5yiflE=
Received: by 10.142.248.22 with SMTP id v22mr6624376wfh.276.1273774875291; 
	Thu, 13 May 2010 11:21:15 -0700 (PDT)
Received: by 10.231.199.147 with HTTP; Thu, 13 May 2010 11:20:55 -0700 (PDT)
In-Reply-To: <4BEA4B46.6010009@smartmediacorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147018>

On Wed, May 12, 2010 at 2:31 AM, Noah Silverman <noah@smartmediacorp.co=
m> wrote:
> 1) I'd like to keep my documents directory synced between the office =
and
> home machines.
> 2) I'd like to keep two or three sub directories of this synced with =
my
> laptop
> 3) We have a server in "the cloud" where I like to keep backups of my
> documents. =A0Just in case.

Unison is a perfect fit for items 1 & 2. Works well over large files,
does not keep history.

The DSCMs tend to fall over with very large (often binary) files. A
few videos included in your presentation, high res TIFF images,
horrendously fat PDFs coming from a third party, even an openoffice
presentation with many imagees, all make the DSCMs choke, because
internally the DSCM wants to load it into RAM to store deltas.

The DSCM assumption is that a source file will fit in ram with ample
space to spare, to be delta'd (for storage) and diff'd.

> 3) I have a few project where I am the only developer, but want a VCS=
 to
> manage my changes.
> 4) I have 3-4 projects where there are a team of 3 of us and I want t=
o
> use a VCS.

git is a perfect fit for 3 & 4. Mercurial is a close competitor.

cheers,


m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
