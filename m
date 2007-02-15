From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Thu, 15 Feb 2007 02:36:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702150234230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com> <7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net>
 <7vvei4l84q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vire4l76a.fsf@assigned-by-dhcp.cox.net> <20070215005431.GB94048@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 02:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHVYR-0008Sg-3E
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 02:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXBOBg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXBOBg4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 20:36:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:37138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbXBOBgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 20:36:55 -0500
Received: (qmail invoked by alias); 15 Feb 2007 01:36:54 -0000
X-Provags-ID: V01U2FsdGVkX18XJYU1DcMX8esDvF0S+xlV907dV7K3GIW6VA8nwx
	Yw9w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070215005431.GB94048@dspnet.fr.eu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39785>

Hi,

On Thu, 15 Feb 2007, Olivier Galibert wrote:

> On Wed, Feb 14, 2007 at 02:13:01PM -0800, Junio C Hamano wrote:
> > I wonder what you are doing inside .git directory in the first
> > place.  I never chdir() into it myself, but that may be because
> > I practicaly live inside Emacs.
> 
> "Hmmm, how did I call this remote already? ls .g<TAB>rem<TAB><RET>
> ahhh, I see".

Hmm. That does not work for remotes which are stored in the config (which 
is the default nowadays)...

So, what you described is obviously wrong.

Besides, "git remote" is way shorter. And it even completes if you 
installed the bash completion script!

Ciao,
Dscho
