From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 21:34:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602142133360.23093@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org> <87irrhvkyl.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0602141056170.3691@g5.osdl.org> <43F231C5.5010205@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:35:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F96so-00006O-A5
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWBNUen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBNUen
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:34:43 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4548 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932072AbWBNUem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 15:34:42 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1B95C146EF7; Tue, 14 Feb 2006 21:34:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0CCDE6B14;
	Tue, 14 Feb 2006 21:34:42 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BE3E2146EF7; Tue, 14 Feb 2006 21:34:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F231C5.5010205@op5.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16167>

Hi,

On Tue, 14 Feb 2006, Andreas Ericsson wrote:

> [...] it would be nifty (and I imagine not particularly hard) to teach 
> "git checkout" to check out any revision, and not just a branch.

You have to have a valid HEAD. So, you can create a throw-away branch 
easily:

	git-checkout -f throw HEAD~56

Hth,
Dscho
