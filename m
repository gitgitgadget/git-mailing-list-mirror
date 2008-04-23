From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 16:32:26 +0800
Message-ID: <46dff0320804230132u5ae94fd0x310bad0b8a145f42@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <200804221655.11914.Josef.Weidendorfer@gmx.de>
	 <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
	 <200804222007.03439.Josef.Weidendorfer@gmx.de>
	 <46dff0320804221859x7641144fua34df89fcc686aa2@mail.gmail.com>
	 <alpine.WNT.1.10.0804231124270.2728@theodor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Fedor Sergeev" <Fedor.Sergeev@sun.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 10:33:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoaPj-0000vH-Sh
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 10:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYDWIc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 04:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYDWIc3
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 04:32:29 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:7122 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYDWIc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 04:32:28 -0400
Received: by an-out-0708.google.com with SMTP id d31so685138and.103
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=emSOpodt0cxJs90iJHMd1CymFN8nYXu2bFpbIkOmhC4=;
        b=e+D0XvKls5VJwykQkB7DGLCilgBMr7pShB8Ba41xf0Vk4Rrio92rhx5qMWpjOt+yNjeKuS3vODjICgHuTQfOBcdzzd03PQ8Xh7sUNO114fnCprr0vJJg9B/LPqt9VkHnpUON5fkTB/iVMDPxWLl5bdK98YxjEnPTAzsvPUXfjvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b4pTnsufEkBWDVmLgVE8nRKEwrwdBVPzv2/Rdp8qA63HCrWTo+qon/4EHxLfwdJ5FpwM/kDH4U8DTN9OAi216W6kKqr2uFdtZBzUZDS8SPvpKFE2OMsQ8DabcfjBQtF5ydasrQJlDlpkVo3YEOI8rgSWItRKzw9zqp/xrmcjIts=
Received: by 10.100.139.20 with SMTP id m20mr2315113and.47.1208939546437;
        Wed, 23 Apr 2008 01:32:26 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 23 Apr 2008 01:32:26 -0700 (PDT)
In-Reply-To: <alpine.WNT.1.10.0804231124270.2728@theodor>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80199>

On Wed, Apr 23, 2008 at 3:47 PM, Fedor Sergeev <Fedor.Sergeev@sun.com> wrote:
> On Wed, 23 Apr 2008, Ping Yin wrote:
>
> >
> > On Wed, Apr 23, 2008 at 2:07 AM, Josef Weidendorfer
> >
> >
> > >  Hmm... At least, it can be very annoying when git fetches data from
> repositories
> > >  you did not expect, only because submodule URLs change via this
> > >  fallback mechanism. Perhaps it is a little far reached, but suppose a
> project
> > >  changes its URL, and the old one becomes occupied by a malicious
> person.
> > >  The problem is that the URL with the now malicious repository is bound
> in the
> > >  history of the project.
> > >
> >
> > It is always bound now without the fallback patch :)
> >
> >
> > >  For sure, you do not want to fetch from that old repository
> > >  by accident, after you did a checkout of an old commit. And there would
> be no
> > >  way to protect other people from this malicious repository other than
> rewriting
> > >  the whole history.
> > >
> >
> > I wonder how the *malicious* repository can hurt us since only the
> > commit recorded in commit of the super project will be checked out.
> >
>
>  If one manages to hack on repository one can modify it enormous amount of
> ways, including spoofing on SHA (providing wrong contents for it - does git
> verify that when getting a pack?), utilizing bugs in git etc...

Doable? I dunno.



-- 
Ping Yin
