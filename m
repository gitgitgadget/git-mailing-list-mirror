From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 11:38:39 -0500
Message-ID: <76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 17:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDKtC-0002wj-Lt
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 17:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbZKYQif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 11:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbZKYQif
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 11:38:35 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:52258 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbZKYQie convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 11:38:34 -0500
Received: by ywh12 with SMTP id 12so7704577ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xlq+lNl0R+/Yz4A+qfMs2Q6mKHNtluIKoVD1+JociVE=;
        b=kGGcEe7ApKWTtwbJAOyW7EMfCZ/eW9CZvi6V0i3YIeYtH6BghFJIBlFH2aUweh5N4C
         2mDnF7Sx+Ly1ZBpwY6S4eewLvVOiS6reYJD0s4D/mPJWmex9xwyJ/6QsUUM69fPi47Tv
         k4STbwIrAxGiEbfW6EStKlom/HaL3UIynDbRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vKWH3+8OsvxY2YgGbSlpR10lZFd0g3jU1wGAfHA/JiF52UOqYITL094HVfjfUdOv5g
         7BpF6850tVNXE6k/P0RbSJLbkZCzzF78xrmV3cWWk6iCxZmyhIPwu7zU8WhWMGQRKwlz
         TEY7Gdm3gFkk0fZNoc5+FpZ79M5Mu/rQSvscY=
Received: by 10.90.10.9 with SMTP id 9mr5036579agj.69.1259167119657; Wed, 25 
	Nov 2009 08:38:39 -0800 (PST)
In-Reply-To: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133649>

>
> Suppose that I checkout the v3 branch, and fix the bug by editing
> several different files. =C2=A0(Lets assume for now that the files in
> question have not diverged between any of the 3 branches, even though
> tons of other files have changed). =C2=A0How do I commit the bugfix i=
nto
> all of v3, v4 and v5? =C2=A0Clearly, merging the branches together wo=
uld be
> bad. =C2=A0So I think what I should do is perform 3 different commits=
, but
> I'm not quite sure how to juggle the git index (or stash or whatever)
> to accomplish this. =C2=A0This may be a really obvious question, but =
I'm a
> confused git newbie.

It as not as clear for me why you think merge will be bad?
If you commit your changes to the v3, then merging to v4 and v5 (which
are not changed) should be very simple fast forward merge. Which means
just move the pointer to the last commit from v3

Am i missing something?

Thanks,
Eugene
