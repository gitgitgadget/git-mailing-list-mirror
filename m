From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 19:51:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605201945110.32590@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
 <e4n8b3$ari$1@sea.gmane.org> <Pine.LNX.4.63.0605201904320.31887@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pzk3831.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 19:51:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhVbx-0001rc-MT
	for gcvg-git@gmane.org; Sat, 20 May 2006 19:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWETRv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 13:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWETRv2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 13:51:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6082 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751453AbWETRv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 13:51:28 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 084CB1C5B;
	Sat, 20 May 2006 19:51:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id F0EE71C5A;
	Sat, 20 May 2006 19:51:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CFC8FC38;
	Sat, 20 May 2006 19:51:26 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pzk3831.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20389>

Hi,

On Sat, 20 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I only changed the "From " line (note the missing ":") to match the output 
> > from git-format-patch.sh.
> 
> Not a big deal, but I was hoping you would keep the inception
> date of git (April one) in the final version ;-).  The September
> date is totally a random date and does not have any
> significance.

Actually, I just tested something: pine seems to be confused when parsing 
a "From " line where the day of month is only one digit without two 
leading digits. I don't care.

> Anyway, with this change (and a lot of testing ;-) I think we
> can replace the script with built-in.  Thanks.

There are two options missing: --signoff and --check.

--signoff is my fault: it is probably a good thing to drop it from 
format-patch, and only leave it in applymbox.

As for --check: how about having yet another diff "format": 
DIFF_FORMAT_CHECK? Instead of showing the diff, it only shows the line(s) 
which are offending.

Ciao,
Dscho
