From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stupid quoting...
Date: Tue, 19 Jun 2007 02:00:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706190156110.4059@racer.site>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org>
 <86ir9l1ylc.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0S5T-0000el-IT
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762453AbXFSBAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763416AbXFSBAu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:00:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:48512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760535AbXFSBAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:00:49 -0400
Received: (qmail invoked by alias); 19 Jun 2007 01:00:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 19 Jun 2007 03:00:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sR9Vn6qTsW/8Mne1HTtnaew1BX/LSEIdiioXDEB
	GxbfYWnd0xPec+
X-X-Sender: gene099@racer.site
In-Reply-To: <86ir9l1ylc.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50432>

Hi,

On Mon, 18 Jun 2007, David Kastrup wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > David Kastrup wrote:
> >
> >> what is the point in quoting file names and their characters in 
> >> git-diff's output?
> >
> > 7-bit email.
> 
> I think it can be reasonably safely assumed that people using 8-bit
> characters in file names will not refrain from using them in the files
> themselves: [...]

However, please realise that chances are very good that none of these 
8-bit unclean things show in the diff.

Besides, the proper fix would probably involve making none-8-bit-clean 
diffs binary diffs (for FORMAT_EMAIL only, of course).

> So I don't see what quoting such characters in file names is supposed to 
> buy with regard to diff output in 7-bit email.

But isn't that obvious? Even if the diffs are not 7-bit clean, which I 
consider as an error, quoting the file names is already half what is 
required.

Don't just throw away backwards compatibility, only because it does not 
fit your wishes.

Ciao,
Dscho
