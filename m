From: skillzero@gmail.com
Subject: Re: Global reflog?
Date: Sun, 14 Feb 2010 14:14:13 -0800
Message-ID: <2729632a1002141414l4c4ccd82j32693e6e3bd02bc5@mail.gmail.com>
References: <2729632a1002141349s6c9a31b7u6784d89d132547ac@mail.gmail.com>
	 <alpine.LFD.2.00.1002141655450.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 23:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgmjM-00023b-Tw
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 23:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab0BNWOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 17:14:15 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:39753 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0BNWOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 17:14:15 -0500
Received: by iwn39 with SMTP id 39so1641092iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 14:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ifeh1Nk2QRM76FfqCVbevI5sY2WTds5WUaz7JkoZvFg=;
        b=I6OvZB4cwL1t390fjHa3EbqA8vs3ar+gJHKaF2COz5tPz3E1lN9PeifgbGqnghzgTP
         fJTqlXfp7aCzpOzdaxcWgR/waORmFSnrjsgV/GwrY54nMU1LvXDR4I4MNVGjppebQYhT
         1Tmqoz41uEVKF76loVUxR53Fhw1R4PwheO1qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rot1AHJor4GqXjH9ZBR8Qt3n99f/+EskFT8zhxhUxWECXRON2Lw4YUuA3x6ajoQKRa
         5BNa+nxiZl3A7x8thmX/8F+U5SSMm5XhGd/RocwKASy/VvA+BPmtDSAfqw2ExqFGSEtp
         IJJQ2Ib5jts7V6p1aQfAGOsjOnQ7OM6Mv7yEw=
Received: by 10.231.145.74 with SMTP id c10mr255178ibv.51.1266185653471; Sun, 
	14 Feb 2010 14:14:13 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002141655450.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139948>

On Sun, Feb 14, 2010 at 1:56 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Sun, 14 Feb 2010, skillzero@gmail.com wrote:
>
>> Is there a way to have git maintain a single reflog across all
>> branches (and stashes)? I switch between branches, create and delete
>> branches, stash save and pop, etc. frequently and it would be great
>> for me if there was a way to have a global reflog that showed every
>> operation, independent of a particular branch. Is there some way to
>> enable this?
>
> You have it already. =C2=A0It is the "HEAD" reflog.

I don't seem to see any stash activity. For example, I made a test
change, did git stash, and then git stash pop. When I do git reflog, I
don't see the stash commit or the delete of the stash. Is there a way
to enable that?
