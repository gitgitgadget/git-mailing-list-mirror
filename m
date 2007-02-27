From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 21:44:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272143340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net> <45E493D3.7060407@vilain.net>
 <7vodnfcoy1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:45:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9Bz-00019c-QB
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbXB0Uoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXB0Uoz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:44:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:41384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751853AbXB0Uoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:44:54 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:44:53 -0000
X-Provags-ID: V01U2FsdGVkX18ni48xqHwnyyglvxoLUP8WqZH/Ywx2Cm+sxcSLvq
	HBnQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vodnfcoy1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40800>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Sam Vilain <sam@vilain.net> writes:
> 
> > Junio C Hamano wrote:
> >> I take that as a sign that git hasn't been exercised well and
> >> yet more ancient bugs are sleeping, waiting to be triggered, not
> >> as a sign that we are very careful and adding only small number
> >> of risky new code in the releases.
> >>   
> >
> > No! It's a sign that there aren't enough tests :)
> >
> > Maybe investigate the coverage of the test suite?
> 
> I know we cover most of the success (expected) cases for things
> we care about, but at the same time I personally find that tests
> for failure cases (insane input, dataset expected to fail) are
> missing.
> 
> We do not need investigation.  We need a volunteer.

Maybe a Summer of Code project?

> And perhaps a new patch/feature acceptance criteria that requires both 
> expected behaviour and expected failure tests, but I am lazy ;-).

I think that's okay. Many, many new features and bug fixes come with 
tests. I think that we do not have _few_ tests. At least not comparing to 
other projects (especially commercial ones...).

Ciao,
Dscho
