From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 13:39:23 -0300
Message-ID: <200701171639.l0HGdNq4021842@laptop13.inf.utfsm.cl>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: Josh Boyer <jwboyer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 17 17:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Dp1-0005DX-2z
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 17:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbXAQQjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 11:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbXAQQjc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 11:39:32 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50400 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932573AbXAQQjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 11:39:31 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0HGdOX5012082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jan 2007 13:39:24 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0HGdNq4021842;
	Wed, 17 Jan 2007 13:39:23 -0300
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-reply-to: <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Comments: In-reply-to Johannes Schindelin <Johannes.Schindelin@gmx.de>
   message dated "Wed, 17 Jan 2007 14:49:50 +0100."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 17 Jan 2007 13:39:24 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2459/Tue Jan 16 19:03:34 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37013>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 17 Jan 2007, Josh Boyer wrote:
> 
> > Could we add an option to git-format-patch to use ".patch" as the file
> > suffix instead of ".txt"?  Something like the below?
> > 
> > diff --git a/builtin-log.c b/builtin-log.c
> > index a59b4ac..4eb2d32 100644
> > --- a/builtin-log.c
> > +++ b/builtin-log.c
> > @@ -217,6 +217,7 @@ static int git_format_config(const char *var,
> > const char *value)
> > 
> > static FILE *realstdout = NULL;
> > static const char *output_directory = NULL;
> > +static int psuffix = 0;
> 
> Why not
> 
> 	static const char *file_extension = ".txt"

Need to keep the length of that around for allocating string space and
such. Is the flexibility worth the hassle?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
