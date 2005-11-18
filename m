From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 12:04:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511181203510.16457@wbgn013.biozentrum.uni-wuerzburg.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
 <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <20051118075117.GK31613@kiste.smurf.noris.de>
 <7vbr0imlha.fsf@assigned-by-dhcp.cox.net> <pan.2005.11.18.08.56.22.908009@smurf.noris.de>
 <Pine.LNX.4.63.0511181134080.8037@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051118105415.GN31613@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 12:05:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed437-0000Id-Lv
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 12:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbVKRLEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 06:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbVKRLEm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 06:04:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13227 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161025AbVKRLEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 06:04:42 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 42E2A13FB4C; Fri, 18 Nov 2005 12:04:41 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 06C77B523C; Fri, 18 Nov 2005 12:04:40 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CAE1EB5235; Fri, 18 Nov 2005 12:04:40 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C3DC913FB4C; Fri, 18 Nov 2005 12:04:40 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051118105415.GN31613@kiste.smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12225>

Hi,

On Fri, 18 Nov 2005, Matthias Urlichs wrote:

> Johannes Schindelin:
> > From my diff man page:
> > 
> > -- snip --
> > DIAGNOSTICS
> >        An  exit status of 0 means no differences were found, 1 means some 
> >        differences were found, and 2 means trouble.
> > -- snap --
> > 
> > The exit value 2 is ambiguous for at least one version of GNU diff.
> > 
> AFAIK, We have
> 0 - no difference
> 1 - produced a reasonable diff
> 1 - produced a bad diff because binary stuff starts
>     after 4096-or-whatever bytes and diff didn't notice
> 2 - didn't produce a diff -- binary files differ
> 2 - something else broke
> 
> Right now we simply don't consider the second -2- case, because we just
> successfully wrote the two files in question; there's not *that* much
> that can fail after that. The second -1- case is sufficiently rare too.
> 
> So I still think a "Just write a 'Binary files FOO and BAR differ' line
> if the exit status is 2" rule would at least fix the current bug with
> diff 2.8.7.

Dunno. Am I the only one with an odd feeling about that?

Ciao,
Dscho
