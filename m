From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Rename push.default to push.style
Date: Mon, 30 Mar 2009 10:23:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903301021540.7534@intel-tinevez-2-302>
References: <1238281804-30290-1-git-send-email-santi@agolina.net> <1238281804-30290-5-git-send-email-santi@agolina.net> <20090330080115.GA19142@pvv.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1923528958-1238401429=:7534"
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 10:25:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCo8-0005Dj-Uo
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbZC3IXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 04:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZC3IXx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:23:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:33473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752807AbZC3IXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:23:52 -0400
Received: (qmail invoked by alias); 30 Mar 2009 08:23:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 30 Mar 2009 10:23:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aeAo4ODJavNCT+dHeXjcJo1I1hXXEjdGg7zR3Da
	bQhaL7eFpHIUO+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090330080115.GA19142@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115104>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1923528958-1238401429=:7534
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 30 Mar 2009, Finn Arne Gangstad wrote:

> On Sun, Mar 29, 2009 at 12:10:04AM +0100, Santi Béjar wrote:
> > push.default was too generic, and also didn't specify if it was about
> > remote, refspec, branches, behaviour...
> > [...]
> >  	"You can specify what action you want to take in this case, and",
> > -	"avoid seeing this message again, by configuring 'push.default' to:",
> > +	"avoid seeing this message again, by configuring 'push.style' to:",
> >  	"  'nothing'  : Do not push anything",
> >  	"  'matching' : Push all matching branches (default)",
> >  	"  'tracking' : Push the current branch to whatever it is tracking",
> > [...]
> 
> I don't think "push.style" is an improvement. "style" sounds like it 
> affects all pushes. This configuration variable says what push should do 
> when no refspec is given and none are configured, so the word "default" 
> should be in there at least. Maybe "defaultref" would have been better?

I'd prefer "push.defaultMode", but...

> Some people may have started setting push.default already, so changing 
> the name may cause additional grief.

... indeed, it is too late now.  The milk has boiled already.

Ciao,
Dscho

--8323329-1923528958-1238401429=:7534--
