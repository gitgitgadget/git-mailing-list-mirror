From: "Richard" <richard@webdezign.co.uk>
Subject: RE: Moving git
Date: Fri, 16 Oct 2009 16:45:24 +0100
Message-ID: <8440EA2C12E50645A68C4AA988716651244654@SERVER.webdezign.local>
References: <25926819.post@talk.nabble.com> <vpqk4yv2ws6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 16 17:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myp6l-0006zS-WB
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 17:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbZJPPvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 11:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbZJPPvc
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 11:51:32 -0400
Received: from mail.webdezign.co.uk ([213.123.201.79]:48116 "EHLO
	webdezign.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932635AbZJPPvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 11:51:32 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Oct 2009 11:51:32 EDT
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <vpqk4yv2ws6.fsf@bauges.imag.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Moving git
Thread-Index: AcpOc+SyvV33/l1IRBu7lbA2njp6zAAAMVAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130506>

Hi Matthieu,


Thanks for replying.

Basically, I used git-svn to import from git. I'm trying to get rid of
the origin branch. (I probably should have used the no-metdata switch).

The command I used was

git branch prune origin

I tried "git remote rm origin" which worked on my local win32 machine,
but the linux server I was working on did not recognise "git remote rm".

I'm pretty sure git stores the current git directory as I've seen the
--git-dir and --work-tree environment variables. Plus I also noticed on
msysgit gives " Local uncommitted changes, not checked in to index"
sometimes, when I move the directory.


Regards,

Richard

-----Original Message-----
From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr] 
Sent: 16 October 2009 16:17
To: Richard
Cc: git@vger.kernel.org
Subject: Re: Moving git

Richard Lee <richard@webdezign.co.uk> writes:

> Hi Git forum,
>
> I've just started using git yesterday, so I'm very new. So please
excuse if
> I've done something the wrong way.
>
> I cloned a git directory/repository? and then moved it. I'm trying to
prune
> branches and it gives

Which command did you type?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
