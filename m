From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 19:10:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605201904320.31887@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
 <e4n8b3$ari$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 19:10:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhUxz-0003rc-CQ
	for gcvg-git@gmane.org; Sat, 20 May 2006 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWETRKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWETRKF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 13:10:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58278 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751425AbWETRKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 13:10:04 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id ADEEB1BEA;
	Sat, 20 May 2006 19:10:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A1F831985;
	Sat, 20 May 2006 19:10:02 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 71F05107B;
	Sat, 20 May 2006 19:10:02 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e4n8b3$ari$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20385>

Hi,

On Sat, 20 May 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > -             printf("From %s  Thu Apr 7 15:13:13 2005\n",
> > -                    sha1_to_hex(commit->object.sha1));
> > +             printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);
> 
> What's with the date?

Does not matter. This is not part of the mail header (the date is 
displayed as a "Date:" line).

I only changed the "From " line (note the missing ":") to match the output 
from git-format-patch.sh.

Ciao,
Dscho
