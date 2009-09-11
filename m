From: james bardin <jbardin@bu.edu>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 10:00:33 -0400
Message-ID: <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
	 <20090911133313.GF2582@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 16:00:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm6gB-0004lx-DU
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 16:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZIKOAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 10:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZIKOAk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 10:00:40 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:54256 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbZIKOAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 10:00:38 -0400
Received: by vws33 with SMTP id 33so722706vws.33
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5gsBVkLlwAW3y5PkDU5faqS0pQfnw61vMui1J6Z8JDc=;
        b=iijl/eWbyNWHOnos86A65JOEoT8ujK3iTxQZ1wnXVfgtcKZ1MW0BCYMdtZsWn2mb/r
         PnjivrtP7oyRKWAc0ttgFzXBnya3RhNPSXuOvsm/DY1bH+Tyc5leEj5NCRBqX1REs98V
         ie6rrARIBnPtuGv4k+9eU997G4H/gpq2mFXgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VcjbVwVkrGMOttzxXs1pMpLinvZyM8OiZv9R2W79maJBDIb2is+6Z4+s4Of5l8u/Ii
         IRvjIP3/vgxGSg1+q8KH0l5VepWZJtoHvDbpw67Jyi7WOB5Ks3LLn2UaGT5FdOiDHADB
         pA+OhofIkPOQvGKeT0WYCkBFheWOAlVHxCUuU=
Received: by 10.220.108.106 with SMTP id e42mr3650781vcp.77.1252677633555; 
	Fri, 11 Sep 2009 07:00:33 -0700 (PDT)
In-Reply-To: <20090911133313.GF2582@inocybe.localdomain>
X-Google-Sender-Auth: 31b2efc43ee2c853
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128194>

On Fri, Sep 11, 2009 at 9:33 AM, Todd Zullinger <tmz@pobox.com> wrote:
> james bardin wrote:
>> I'm making a git rpm for our site, and I'm getting an error with
>> bash_completion on RHEL/CentOS 5.
>
> Out of curiosity, have you tried rebuilding the Fedora packages from
> rawhide? =A0They should work on RHEL/CentOS 5 just fine (I use them
> myself).
>

I was trying to prune out some of the dependencies to make internal
deployment easier.
I bundled the doc tarballs instead of requiring asciidoc, and git
includes its own perl(Error) if it's not available.



On Fri, Sep 11, 2009 at 9:11 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> I can't reproduce this with git version 1.6.5.rc0.164.g5f6b0 on Fedor=
a 11.
>
> Which exact steps reproduce it for you, and which relevant settings (=
PS1
> and GIT_PS1_...) do you use? Do you have a system or global .gitconfi=
g?
>

I did a make install, and dropped the completion file in
/etc/bash_completion.d/. No other settings changed. I did a quick
check, and it happens with the current 1.6.5 snapshot too, and on a
fedora 10 box I found.

It seems I only get this error if I don't have a global config.
Touching ~/.gitconfig stops the error.
