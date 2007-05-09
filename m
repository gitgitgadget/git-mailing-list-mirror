From: "Fredrik Kuivinen" <frekui@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Wed, 9 May 2007 23:09:25 +0200
Message-ID: <4c8ef70705091409g30674cb6p6d3af42eb47ffc08@mail.gmail.com>
References: <87y7k4lahq.wl%cworth@cworth.org>
	 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	 <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
	 <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
	 <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com>
	 <17985.19926.347089.878721@cargo.ozlabs.ibm.com>
	 <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
	 <20070509182844.GA2982@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 09 23:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HltPl-0001sN-D8
	for gcvg-git@gmane.org; Wed, 09 May 2007 23:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbXEIVJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 17:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759331AbXEIVJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 17:09:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:36547 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759324AbXEIVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 17:09:27 -0400
Received: by nz-out-0506.google.com with SMTP id o1so351918nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:09:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qZgzc7TExIqwDfEbsZ4y+zcgpUDv6dVxZogMxgfV2XegEoGvZNWnQwPVJBSjWjXXBCZ2yFhDH/H+45JBL5A2bpx+l0hTsLjlv/nlBWO0GrGIm8uoSGNIq5GsKWu3OOxLfSJeA50FGKlKpZYnZSTflbbKM9qhtYDNkACvICuu6To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SzgIjr6vd1ESxNd15IxRR7g8xgEygVUKEUgxkO4RIz9I75nnPLC4AV4Q0NshNBMppqlzdc8ytMUXt9mHe9sBEzi7wSjrdxNmn/4TtAhr2KmtvGuXJVQpupMjTOTz4ReCJIt2DHgFTBmMGRhfLpaBZ0glp23dAi4jiGi8w7hjMHU=
Received: by 10.115.14.1 with SMTP id r1mr302191wai.1178744966038;
        Wed, 09 May 2007 14:09:26 -0700 (PDT)
Received: by 10.114.73.8 with HTTP; Wed, 9 May 2007 14:09:25 -0700 (PDT)
In-Reply-To: <20070509182844.GA2982@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46791>

On 5/9/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Wed, May 09, 2007 at 08:38:48 +0200, Marco Costalba wrote:
> > On 5/9/07, Paul Mackerras <paulus@samba.org> wrote:
> > >Marco Costalba writes:
> > >
> > >> Language to use is C++, not C (much more powerful IMHO)
> > >
> > >Sorry, C++ is not an option because I dislike it so much.
> >
> > Well, speaking about GUI applications, the 90% is in the graphic
> > library and only in small part in the language. With Qt we are at 95%
> >
> > Anyhow does exist also python bindings for Qt.
>
> Tried them, beed deeply disapointed. Qt always destroys all child objects
> with the parent, which is OK in C++, but does not play well with
> garbage-collection. And the python bindings (ruby ones seem to be better)
> fail to check reference validity, so you can quite easily segfault the python
> interpreter. Gtk plays much better with dynamic languages.

I have used PyQt for some smaller projects (notably Hgct, a no longer developed
commit tool for git and Mercurial. See
http://repo.or.cz/w/hgct.git?a=tree). For me
PyQt has worked very well. The python interface to Qt is more or less a direct
translation of the C++ interface, so the excellent documentation troll
tech provides
for Qt can be used when developing with PyQt as well.

I have never seen the segfaulting you mention. Maybe my programs have been too
small to trigger that bug...

- Fredrik
