From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: denying branch creation in a shared repository
Date: Tue, 20 Oct 2009 16:54:48 +0530
Message-ID: <2e24e5b90910200424m340c52d8rabc0b61a7bf55c45@mail.gmail.com>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
	 <2e24e5b90910190143j5579d9dfle15df8625eb20a00@mail.gmail.com>
	 <ee22b09e0910190943x51d48c09sdc50d941d643358d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mohit Aron <mohit.aron@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 13:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Cqu-00015C-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 13:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZJTLYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 07:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZJTLYp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 07:24:45 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:54129 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZJTLYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 07:24:44 -0400
Received: by iwn8 with SMTP id 8so2816966iwn.33
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Vv+ZEn8Aq+L8cTUNCXiCxd0rc7x8vdAONAy2K9I68eM=;
        b=TdAo8Tc421W+2fZzUxjHRaaJquxHVth2PlsAB1xjO6ImnGxtfYZ8LnEEMjiNczQxT+
         SvDKp/2b236hJ0XColN9ctEeEZPdZh/HszqqQXchlfy3LgsVj5/+vQt/hWziXdQ3JU9o
         CYeoKhTjnt5ud/Ba46qq43BDarQDRan5ve3hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NbKSQstok5KdHR+sELEmjDzXXlP5+YlhqQ2Vn6NGmxKSxgaZdqnuj0bTwCKBDVQDSL
         zImj4huBQ7cFEd31DQdB7bYlu/GEZifjRz4NgznA/pJHT6B5E5ct9T30Q8vp5SJcvmfW
         ko7/hJj3YihccJKXDnXtw5TqtxLONbvZDQsWc=
Received: by 10.231.120.30 with SMTP id b30mr7486216ibr.15.1256037888691; Tue, 
	20 Oct 2009 04:24:48 -0700 (PDT)
In-Reply-To: <ee22b09e0910190943x51d48c09sdc50d941d643358d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130785>

On Mon, Oct 19, 2009 at 10:13 PM, Mohit Aron <mohit.aron@gmail.com> wrote:
>>
>> That was the main reason I wrote gitolite
>> (http://github.com/sitaramc/gitolite), though now it does a heck of a
>> lot more than just that.
>>
>
> That's great. You might want to consider making it a deb package
> that's available from one of the Ubuntu/Debian repositories. An apt
> search on Ubuntu 9.10 doesn't reveal it. I usually shy away from
> installing software on my machines that is not automatically managed.

There are a couple of answers to this:

(1) I'm not really a debian guy, and definitely not ubuntu.  My distro
of choice for nearly 10 years has been Mandriva :-)

(2) gitolite's second reason for existence [after the one in this
thread] is the need to install something on machines where you do
*not* have root, can't create another user, etc etc.  There was a
Solaris 9 on which I couldn't install python-setuptools, and so no
gitosis :-(

Regardless of all that, someone is working on it...
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=550817

I respect your inclination to shy away; I do the same for pretty much
everything except git itself and one or two others.

But if you don't mind looking through the documentation (browse it
directly on github; it'll render the markdown properly, though the
plain text is quite readable too), you may be able to better decide if
you want to use it despite this limitation.

Regards,

Sita
