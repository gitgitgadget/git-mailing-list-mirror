From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: http git and curl 7.16.0
Date: Wed, 27 Dec 2006 11:57:46 -0300
Message-ID: <200612271457.kBREvkj2011916@laptop13.inf.utfsm.cl>
References: <skimo@kotnet.org>
Cc: George Sherwood <pilot@beernabeer.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 27 15:58:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzaEz-0003rh-4Q
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 15:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958AbWL0O6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 09:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWL0O6i
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 09:58:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47049 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932857AbWL0O6h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 09:58:37 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBREvrTn023770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Dec 2006 11:57:53 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBREvkj2011916;
	Wed, 27 Dec 2006 11:57:49 -0300
To: skimo@liacs.nl
In-Reply-To: Message from Sven Verdoolaege <skimo@kotnet.org> 
   of "Sun, 17 Dec 2006 12:32:35 BST." <20061217113235.GJ25274MdfPADPa@greensroom.kotnet.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 27 Dec 2006 11:57:53 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35473>

Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sat, Nov 18, 2006 at 08:07:08AM +0400, George Sherwood wrote:
> > I seem to be having a problem doing an http checkout with git built
> > with curl 7.16.0 enabled.  If I build against curl 7.16.0 and try a
> > clone, I get:

> > git clone http://dmlb2000.homelinux.org/~dmlb2000/git-repos/local/castfs.git
> > error: Unable to start request error: Could not interpret heads/master
> > as something to pull
> > 
> > If I rebuild git against curl 7.15.5 then I get:
> [..]
> > and the checkout finishes.
> > 
> > Has any one else seen this?

> FWIW, I've seen the same with curl 7.16.0 on a Solaris 9 machine.
> It worked fine with curl 7.15.0.

It works fine for me on Aurora Corona (sparc) with curl-7.15.5-1.al3, while
it fails as above on Fedora rawhide (i386) with curl-7.16.0-4.fc7.

Furthermore, with new curl pulling from HTTP repos when there are updates
gives double free errors and a crash.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
