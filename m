From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: How to force explicit user info
Date: Wed, 5 Mar 2008 15:46:26 +0100
Message-ID: <8aa486160803050646m1dcceaf7y702dca453068f073@mail.gmail.com>
References: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
	 <m3r6epgrqt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuti-0003rx-1a
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYCEOqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 09:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYCEOqa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:46:30 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:11837 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYCEOq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 09:46:29 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1924731tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=a4yC9XfDGPUAJKJ4S4+FDg5U/crcN+l7jLO5gGvIsb8=;
        b=Zw9J1ioYy4MkTUgHQdy67Qtr/DroLY4wixXJhtiQqoxDGpqNYiB0pbvOMkJ8SA8HbC3zzygy836+5+l9O82N07x0/uIR8s5NlwPkaFeYKXPes2pOh7BCW1AOlFmfzG6OpOYk1Vf/CmiBdHac1aZ99zdOv3YaaD94VOHXreVy4TY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xA3N9rED0aDEu8FPjZkDTp1kf1/7yKCvSgIOq0gkVR6bE6c99DbsrmB4gC5GV/GHAuwIyNBHSMiEEci+hquA55mQJlnWfJ93cyse6YzgTtnWBScOR5jvQfLGVJNmfDbIjHXEwSFFXlU/I5A/hAGDVrvdD182UCfY1JxyyvGDpLM=
Received: by 10.151.10.7 with SMTP id n7mr1234858ybi.6.1204728386181;
        Wed, 05 Mar 2008 06:46:26 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 06:46:26 -0800 (PST)
In-Reply-To: <m3r6epgrqt.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76223>

On Wed, Mar 5, 2008 at 3:38 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>  >   How can I forbid the gecos info and always force git to ask for =
an
>  > explicit user.name and user.email?
>  >
>  >   I use a different email for personal projects and for work proje=
cts,
>  > using the same machine. So I set user.email locally in each
>  > repository. But when I forget setting this I get
>  > userid@hostname.(none) as the email. Is there a way to just die an=
d
>  > ask for this info (maybe user.AlwaysExplicit or something like tha=
t)?
>
>  I don't think there is a way to get exactly what you want... unless
>  you would "scratch that itch"... :-)

Yes, I'll add this to my todo.

>
>  You can set default user.name and user.email in the ~/.gitconfig
>  global (user) git configuration, and in /etc/gitconfig for system-wi=
de
>  git config, though. HTH.

But I don't want a default user.{name,email}.

Santi




>
>  --
>  Jakub Narebski
>  Poland
>  ShadeHawk on #git
>
