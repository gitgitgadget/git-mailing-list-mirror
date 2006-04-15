From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --patch-with-stat
Date: Sat, 15 Apr 2006 14:37:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604151436280.6147@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64lbggrd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 14:37:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUk1n-0002o6-UR
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 14:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWDOMhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWDOMhY
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 08:37:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48286 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932505AbWDOMhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 08:37:24 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E28691FF1;
	Sat, 15 Apr 2006 14:37:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D6F3F1FDE;
	Sat, 15 Apr 2006 14:37:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B96C31CC7;
	Sat, 15 Apr 2006 14:37:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64lbggrd.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18747>

Hi,

On Sat, 15 Apr 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	BTW I really would like to have a diffstat for combined diffs.
> > 	Any ideas?
> 
> While I think combined diffs are somewhat overrated, I think
> what makes some sense would be to count --cc output for each
> parent's column, and show something like this:
> 
>  Makefile            | +-     +- 
>  debian/changelog    | ++++++ ++++++++++++++++++++
>  2 files changed, 7 and 91 insertions(+), 1 and 0 deletions(-)

Okay. That is a start, altough it will look funny with 12 parents...

I'll do some hacking while you're sleeping.

Ciao,
Dscho
