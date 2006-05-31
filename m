From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 16:09:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605311607180.19671@wbgn013.biozentrum.uni-wuerzburg.de>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
 <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
 <20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 16:09:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlROB-00016s-58
	for gcvg-git@gmane.org; Wed, 31 May 2006 16:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWEaOJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 10:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWEaOJb
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 10:09:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50080 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965031AbWEaOJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 10:09:30 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id F07932176;
	Wed, 31 May 2006 16:09:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id E48F7216A;
	Wed, 31 May 2006 16:09:28 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C43B120D1;
	Wed, 31 May 2006 16:09:28 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Seth Falcon <sethfalcon@gmail.com>
In-Reply-To: <m2mzcycn4f.fsf@ziti.fhcrc.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21065>

Hi,

On Wed, 31 May 2006, Seth Falcon wrote:

> Matthias Kestenholz <lists@spinlock.ch> writes:
> 
> > * Geoff Russell (geoffrey.russell@gmail.com) wrote:
> >> It appears to have got lost when the shell script got converted to C.
> >> 
> > Yes, this was intentional. You should sign off your changes while
> > committing (git commit -s|--signoff)
> 
> When should one commit _without_ signoff?  
> 
> The obvious answer is: when one doesn't approve of the changes in the
> commit... But in my usual workflow, commit means
> works-for-me-I-think-it-is-good. :-)

Well, there are often times when I commit something to a throw-away 
branch, where I do not want to sign it off.

That was my original incentive to add this option BTW: I usually clean up 
a patch series in a cycle of tests and fixes, and only want to sign off on 
the final version.

If people need this option, I'll implement it, so speak up!

Ciao,
Dscho
