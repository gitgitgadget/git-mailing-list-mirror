From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [1.8.0] Re: reorganize the mess that the source tree has become
Date: Sat, 5 Feb 2011 16:11:43 +0100
Message-ID: <20110205151143.GA14187@vidovic>
References: <20110202022909.30644.qmail@science.horizon.com>
 <alpine.LFD.2.00.1102030036420.12104@xanadu.home>
 <AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
 <AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
 <87bp2sy2mf.fsf@catnip.gol.com>
 <20110204181550.GA14173@vidovic>
 <1296859660.1255.49.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Miles Bader <miles@gnu.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Feb 05 16:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pljnv-0002jA-NM
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 16:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab1BEPLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 10:11:50 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55566 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1BEPLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 10:11:50 -0500
Received: by wyb28 with SMTP id 28so3205124wyb.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hNCEY2NPuYWZolKuXiEoR0GUFp+IImdznWq9v3DR/Rk=;
        b=N4q5f3owyruy3T9JvP2Nbjq8UPzyOsCOIlDFH4XZkCI8Cuxqb0FirnOY9xMD0EJiWI
         SnyPK81RK+22Hh022nvWFt23D8vkImHyNf522QjrFqBP77Y0ca46zuJpdSbvhavIwIzl
         6tAbSmnXyaSNvHm4Wsy8NIBMVXFWRt9wXHydU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PbnPTAEtptiMxt0y9yhakJpsjPUI02fJOOjG3H9xXNsSaKij3HCb5i3ksIjEbXyjPP
         CsXpu1tiIJLl024q4EXdgNf0/Hp5VhCrdGOfwoLa60BH1TcKPzDFcJZsepTrcsyfmDGa
         b2mpzeZR836NGNvlUbh6r4PG2pDmRAzvs6Njg=
Received: by 10.227.161.13 with SMTP id p13mr13497316wbx.164.1296918708603;
        Sat, 05 Feb 2011 07:11:48 -0800 (PST)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id b54sm1044487wer.21.2011.02.05.07.11.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 07:11:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296859660.1255.49.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166097>

The 04/02/11, Drew Northup wrote:

> Having once upon a time (in CVS days) taken over a project that was
> neatly organized into tons of folders I can say that more folders is not
> always better.
> If you are organizing things into modules by folders, and those things
> are mutually exclusive pre-compilation then doing so may make sense. If
> the folders ADD value to the project by adding organization--as opposed
> to hiding disorganization--then they may have value.

This _is_ what we are talking about. Not tons of folders or whathever
you might think.

> destructive things
>                                                       killed that first
> project
>                            project       exploded with a fury resembling
> a religious confrontation.                  see that happen to Git
>                see that project die                  you exasperate
> enough of the core developers

Read again. I'm pretty sure this was not your goal but this almostly
looks like FUD to me. So, I don't think I'll involve to more discussion
in this subthread.

-- 
Nicolas Sebrecht
