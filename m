From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git pull
Date: Tue, 18 May 2010 18:31:15 +0200
Message-ID: <20100518163115.GA12950@vidovic>
References: <AANLkTimLZgkojC5L0ZdDewhprLgehLw2w4EZDwyViF4R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: matteo brutti <webmbackslash@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 18:31:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEPhh-0000vl-7t
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 18:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab0ERQb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 12:31:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56064 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab0ERQbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 12:31:24 -0400
Received: by fxm10 with SMTP id 10so1312172fxm.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=l0UF5tNkFRk+pXamn3/peTceySnWs7BA6p7PUtO+3CM=;
        b=LQtgbjnLCncWcFgBU+1Bh8/1ssMzl1N98etDUOfN6pmX6YEU/qQ2hDsxMX1jK/kbv1
         zqc+svJcUtWDzlg1qQU99daDOFw8iQCtvq0ofD6+eXQ74O3dIwQO/2v3jnhPuOU8EY/0
         kLV+5aiNIXCmr6oCFeeg+nYrfuR3DaAndiTlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=op//SV8wAN4fFIckRJGlSxM/dd2YLiHkwZL04+iHwLrOfHPOBH11xHkkcahJX91Dnl
         vvVXOXLJt5Mw4RpyJlNucW724Oo5CBaLoxQERTLhgEmhDM4r39WbAl/AMrm1ZNuVxOcT
         0lViYZttILHyB//ckq5BUzEwetdgjepdrEong=
Received: by 10.204.13.65 with SMTP id b1mr14760bka.188.1274200282746;
        Tue, 18 May 2010 09:31:22 -0700 (PDT)
Received: from @ (91-165-141-122.rev.libertysurf.net [91.165.141.122])
        by mx.google.com with ESMTPS id l1sm19744947bkl.20.2010.05.18.09.31.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 09:31:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimLZgkojC5L0ZdDewhprLgehLw2w4EZDwyViF4R@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147287>

The 17/05/10, matteo brutti wrote:

> Hi,

Hi,

> i'm learning about git and soon have a question.
> My repo is in /dev/sda6 and my home is in /dev/sda4, as are both in
> local i thought that when i committ, i'll found the files on repo
> changed, it was not so! I learn i have to use git pull, but i didn't
> understand why.

"/dev/sda" is the physical device and "/dev/sda6" a physical partition
of the hard drive "sda".

Inside a partition, we may find (usually after the installation process
of the system) a filesytem. The filesytem contains the files we can
access to when mounted to the virtual filesytem (begining at "/").

While using user application which works on usual files (like git does),
we don't care about the underlying local hard drive device ("/dev/sda"
here).

You can safely forget all the "/dev/<something>" things here.

> I made some tries, put my repo in /home/user/myrepo cloned in
> /home/user/myclones changed files and committed and the changes was in
> the repo without any need of pulling, and i have permission to write
> to /dev/sda6, so why have i to pull changes?

With the above in mind, could you please try to rephrase your problem
(and maybe provide a basic use case with the commands to reproduce it) ?

-- 
Nicolas Sebrecht
