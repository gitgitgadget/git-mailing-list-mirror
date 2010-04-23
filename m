From: Konrad Karl <kk_konrad@gmx.at>
Subject: Re: multiple .gitignore and friends in same workdir possible?
Date: Fri, 23 Apr 2010 20:29:59 +0200
Message-ID: <12580.8595716537$1272047426@news.gmane.org>
References: <4526533254752708319@unknownmsgid>
 <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
 <7537.06050240925$1272033186@news.gmane.org>
 <4BD1B3AD.50407@drmicha.warpmail.net>
 <16960.9152632349$1272035032@news.gmane.org>
 <4BD1C1F6.9070908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 23 20:30:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Nds-0005NX-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 20:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab0DWSaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 14:30:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751070Ab0DWSaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 14:30:05 -0400
Received: (qmail invoked by alias); 23 Apr 2010 18:30:02 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp056) with SMTP; 23 Apr 2010 20:30:02 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX1+xX6oUkXCxR7KVslmiwTpcRNU3P2uzwFFqHORqT5
	YpFJXh49umGTyp
Content-Disposition: inline
In-Reply-To: <4BD1C1F6.9070908@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145632>

On Fri, Apr 23, 2010 at 05:51:18PM +0200, Michael J Gruber wrote:
> Konrad Karl venit, vidit, dixit 23.04.2010 17:03:
> > On Fri, Apr 23, 2010 at 04:50:21PM +0200, Michael J Gruber wrote:
> >> Konrad Karl venit, vidit, dixit 23.04.2010 16:32:
> >>> Hi
> >>>
> >>> On Fri, Apr 23, 2010 at 03:01:42PM +0200, Sverre Rabbelier wrote:
> .........
> > Because this information does not getting transfered with git clone.
> > 
> > People have the chance to forget to set this variable after cloning the
> > source repo and they will. 
> 
> ...and the same is true for setting GIT_DIR appropriately for each repo
> - people will commit to the wrong repo, which is even worse. That's why
> it's a fragile approach to begin with. Is there no chance you could put
> those libs in subdirs and use git modules?

the chance exists for the future but the existing build system does not
support it (especially for older releases which I would like to be able
to rebuild as is).

I think a script with a prominent name in the  workdir which will set 
the git variable  will be the next convenient solution which we can live with.

thanks for your input,
Konrad

> 
> Michael
