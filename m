From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
   everything up-to-date
Date: Thu, 21 Aug 2008 18:22:49 +0200
Message-ID: <g8k4or$tf$1@ger.gmane.org>
References: <1219263969579-736663.post@n2.nabble.com> <8585F10E-C33C-481E-B044-A7125F3316F2@web.de> <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com> <7vbpznpeup.fsf@gitster.siamese.dyndns.org> <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com> <alpine.LNX.1.00.0808201808400.19665@iabervon.org> <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org> <1219332938839-740444.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 18:24:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWCxK-0000H3-P3
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYHUQXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYHUQXI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:23:08 -0400
Received: from main.gmane.org ([80.91.229.2]:52819 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbYHUQXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:23:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWCw9-0001pN-5S
	for git@vger.kernel.org; Thu, 21 Aug 2008 16:23:01 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 16:23:01 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 16:23:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <1219332938839-740444.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93170>

ir0s venit, vidit, dixit 21.08.2008 17:35:
> Sorry if you get this twice, oddly my first attempt to send this bounced.
> Thank you for all the good advice however, none of it seemed to resolve my
> issue.
> 
> Attempting to call:
> $git push origin mybranch
> 
> Results in the same message: Everything up to date =/
> I also tried to call $git fetch origin just in case, and doing a pull
> doesn't return anything (which makes sense, no one pushed anything to the
> branch -- although I seem to be the only one with this issue.)
> 
> Could my branch have somehow diverged from the origin remotebranch?
> 
> -- Irene

What do the following report:

git ls-remote origin
git ls-remote .
git log --pretty=oneline mybranch...origin/remotebranch

Michael
