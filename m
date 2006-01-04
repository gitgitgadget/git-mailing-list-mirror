From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories ?
Date: Tue, 03 Jan 2006 18:26:59 -0700
Message-ID: <20060104012659.GA2353@socrates>
References: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de>
 <1136315518.11946.28.camel@cashmere.sps.mot.com> <43BAD1F2.8040209@op5.se>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 04 02:27:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtxQm-0001ms-OV
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 02:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWADB1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 20:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWADB1J
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 20:27:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11127 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751017AbWADB1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2006 20:27:09 -0500
Received: from pd2mr7so.prod.shaw.ca (pd2mr7so-qfe3.prod.shaw.ca [10.0.141.10])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0ISJ00MF9NZDJT70@l-daemon> for git@vger.kernel.org; Tue,
 03 Jan 2006 18:26:01 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd2mr7so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0ISJ005NINZDMZF0@pd2mr7so.prod.shaw.ca> for
 git@vger.kernel.org; Tue, 03 Jan 2006 18:26:01 -0700 (MST)
Received: from socrates ([68.148.44.80])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0ISJ00B41NZDV710@l-daemon> for git@vger.kernel.org; Tue,
 03 Jan 2006 18:26:01 -0700 (MST)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with ESMTP id k041QxJi023185	for <git@vger.kernel.org>; Tue,
 03 Jan 2006 18:26:59 -0700
Received: (from cougar@localhost)	by socrates (8.13.4/8.13.4/Submit)
 id k041QxU2023184	for git@vger.kernel.org; Tue, 03 Jan 2006 18:26:59 -0700
In-reply-to: <43BAD1F2.8040209@op5.se>
To: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14168>

On Tue, Jan 03, 2006 at 08:35:14PM +0100, Andreas Ericsson wrote:
> "origin..HEAD" is a valid and fairly common range.
> "HEAD..origin" is not (well, it is, but it doesn't include any commits 
> since it's going backwards).
> 

It depends on what you are doing. When I update my git repository, I do

git fetch
git-whatchanged master..origin
git pull

to find out what changed since I last updated.
