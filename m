From: Konrad Karl <kk_konrad@gmx.at>
Subject: Re: multiple .gitignore and friends in same workdir possible?
Date: Fri, 23 Apr 2010 16:32:48 +0200
Message-ID: <7537.06050240925$1272033186@news.gmane.org>
References: <4526533254752708319@unknownmsgid>
 <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 16:33:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5JwG-0002BH-BR
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 16:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab0DWOcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 10:32:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753258Ab0DWOcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 10:32:52 -0400
Received: (qmail invoked by alias); 23 Apr 2010 14:32:50 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp005) with SMTP; 23 Apr 2010 16:32:50 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX19+eSsLGYJ++RRpSNykd2WktDdScpiIj8IgOJnjzm
	eV+CBFiN7AZrtQ
Content-Disposition: inline
In-Reply-To: <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145618>

Hi

On Fri, Apr 23, 2010 at 03:01:42PM +0200, Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Apr 23, 2010 at 14:46, Konrad Karl <kk_konrad@gmx.at> wrote:
> > Is this currently possible or am I missing something? It would ease
> > my task a lot.
> 
> I assume that each repo has it's own gitdir, in which case it has it's
> own config file, so you could just use "git config core.excludesfile
> .gitignore.one"?

yes I could (i confess I was not aware of this config var) but
the fine manual says:

  In _addition_ to .gitignore (per-directory) and .git/info/exclude, 
  git looks into this file for patterns of files which are not meant to be tracked.


so if there was some way to _not_ consider the standard .gitignore &friends
I would be happy to live with.


Greetings,
Konrad

> 
> -- 
> Cheers,
> 
> Sverre Rabbelier
