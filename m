From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 21:37:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602142136250.23659@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
 <87fymlvgzv.wl%cworth@cworth.org> <20060214202728.GE31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:38:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F96vf-0000rE-PX
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWBNUhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBNUhl
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:37:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22468 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932376AbWBNUhk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 15:37:40 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AC7FF146EF7; Tue, 14 Feb 2006 21:37:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9DBD910F1;
	Tue, 14 Feb 2006 21:37:39 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3E556146EF7; Tue, 14 Feb 2006 21:37:39 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060214202728.GE31278@pasky.or.cz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16168>

Hi,

On Tue, 14 Feb 2006, Petr Baudis wrote:

> [...]
>
> It works by creating a new branch cg-seek-point and storing the seeked
> point there; if HEAD is already on the branch, it merely changes the
> seek point and resets the working tree appropriately. cg-seek without
> any arguments will then return to your original head, whose name was
> stored in .git/head-name.

And if you want to prevent accidental commit, just "chmod a-w 
$GIT_DIR/index".

Ciao,
Dscho
