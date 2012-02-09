From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 9 Feb 2012 17:04:19 +0100
Message-ID: <20120209160419.GA28718@glitch>
References: <20120209095415.GA19230@glitch>
 <CAPBPrntqaFk7YNf7Rz5aVNOMQVTAFaQcJoPFtsOn6rk8n2Q_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 17:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvWU1-0003hd-Js
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 17:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab2BIQEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 11:04:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50662 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab2BIQEX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 11:04:23 -0500
Received: by eaah12 with SMTP id h12so612313eaa.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=TLeCJtQVq0obthmbUop7Ax8sOWHLNgiCXh6xG19Ni7k=;
        b=LWyyFe6SlEy2FsN/zpikJhJlrTOhA0BG08QjGHvQXV0np9a2T47SsKW1e+M75fB1hQ
         P0o4OrJa7lwPhJ115UqilY4KXQUxBytvorcldilA2SddgI2oYC0wldFWvVCLhGb9q435
         v0dh3KiGjTYPRLcl49/2YI6z/Ohk8h5gd+szo=
Received: by 10.14.45.75 with SMTP id o51mr841363eeb.20.1328803462621;
        Thu, 09 Feb 2012 08:04:22 -0800 (PST)
Received: from glitch (178-85-163-250.dynamic.upc.nl. [178.85.163.250])
        by mx.google.com with ESMTPS id n56sm11060592eeh.6.2012.02.09.08.04.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 08:04:21 -0800 (PST)
Received: by glitch (Postfix, from userid 1000)
	id 3CF68BA0800; Thu,  9 Feb 2012 17:04:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPBPrntqaFk7YNf7Rz5aVNOMQVTAFaQcJoPFtsOn6rk8n2Q_sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190293>

On Thu, Feb 09, 2012 at 10:50:50AM -0500, Dan Johnson wrote:
> On Thu, Feb 9, 2012 at 4:54 AM, Domenico Andreoli <cavokz@gmail.com> wrote:
> >
> >   with the recent changes in tag merging (I updated git to 1.7.9),
> > my usual "git merge v3.X-rcY" command does not fast-forward any more.
> > Of course the initial head is something like "v3.X-rcZ" without any
> > change so that it should (and usually did) fast-forward to the new head.
> >
> > The editor is instead fired off and I have to fill the details of a
> > merge commit, diverging from mainline as soon as I save and exit.
> >
> > Is there any simple and clear explanation for this? Thank you.
> 
> Someone else can explain what is going on more fully, but can you
> report what happens when you run "git merge --ff-only v3.X-rcY"?

This is Debian unstable, out-of-the-box git package 1.7.9-1.

$ git reset --hard v3.3-rc2
HEAD is now at 62aa2b5 Linux 3.3-rc2
$ git merge --ff-only v3.3-rc3
fatal: Not possible to fast-forward, aborting.
$ 

Same for v3.3-rc1 -> v3.3-rc2.

Thanks,
Domenico
