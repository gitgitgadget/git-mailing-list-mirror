From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Fri, 23 Feb 2007 02:07:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702230204190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
 <455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org> <4566E512.4010405@xs4all.nl>
 <Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE3D5C.5060105@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 23 02:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKOv0-0001xE-IG
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 02:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbXBWBIE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 20:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXBWBID
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 20:08:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:46516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752094AbXBWBIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 20:08:01 -0500
Received: (qmail invoked by alias); 23 Feb 2007 01:07:59 -0000
X-Provags-ID: V01U2FsdGVkX18yQwd4WtAyP+JCjyGxX/4t3g5dXRh/UPM2QstGnk
	yMrA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45DE3D5C.5060105@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40405>

Hi,

On Fri, 23 Feb 2007, Han-Wen Nienhuys wrote:

> nitpick:
> 
>   \n
> 
> for newline would be nice. Similar for backslash, formfeed, alarm, etc.

Yes, I thought about that. But it would change behaviour (even if I don't 
think it would do serious damage; the only user of interpolate.[ch] I saw 
is git-daemon, and that does not need \n, I guess).

Besides, "%n" is

- more consistent,
- date(1) does it the same way, and
- you can put BS, FF, AL, etc. into the format string before passing 
  it as an option to git; git does not have to help you there.

Ciao,
Dscho
