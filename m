From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input
 support to git submodule recurse subcommand
Date: Sun, 18 May 2008 16:32:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805181627320.30431@racer>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>  <1209978582-5785-2-git-send-email-imyousuf@gmail.com>  <1209978582-5785-3-git-send-email-imyousuf@gmail.com>  <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0805180636o4c5141c5vee559290832a4f03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, imyousuf@gmail.com,
	git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun May 18 17:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxksb-0000DQ-Pd
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 17:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbYERPcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 11:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYERPcG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 11:32:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58635 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754019AbYERPcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 11:32:05 -0400
Received: (qmail invoked by alias); 18 May 2008 15:32:02 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp031) with SMTP; 18 May 2008 17:32:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Z+gEu+ZEZPhlor4xvpZNblDvADp0rCjeGYk6W2Y
	lJ/1DHD8VsPOJe
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0805180636o4c5141c5vee559290832a4f03@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82389>

Hi,

On Sun, 18 May 2008, Sverre Rabbelier wrote:

> On Tue, May 13, 2008 at 12:43 AM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>
> > If we want a useful and flexible "recurse", perhaps the only thing we 
> > need to do is a command that lists a submodule directory path, one 
> > path at a time, in optionally different traversal order and depth 
> > cutoff, so that the user can feed it to xargs and do whatever they 
> > want to run in there.
> 
> How about Windows? Do we want to depend on something like 
> http://gnuwin32.sourceforge.net/packages/findutils.htm or does msysgit 
> ship with xargs? (Or do we not intend to build internal commands upon 
> this system and leave using the output of "recurse" to the user?)

git-repack already relies on "find", and if you have no silly naming 
scheme *1*, you do not need "xargs".  Besides, we do ship xargs.exe.

Ciao,
Dscho

*1* Oops, this is Windows, right?
