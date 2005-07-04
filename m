From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 15:46:11 +0200
Message-ID: <20050704134611.GM18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de> <20050704130324.GK18608MdfPADPa@garage.linux.student.kuleuven.ac.be> <20050704135327.GA32098@kiste.smurf.noris.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 16:03:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpRXi-0006YT-R0
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 16:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVGDODI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 10:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVGDODI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 10:03:08 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:27569 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261711AbVGDOC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 10:02:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 904DA137A1F
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:02:57 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 97A65137A5A
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:02:55 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 7F4714C0D1
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:02:55 +0200 (CEST)
Received: (qmail 19960 invoked by uid 500); 4 Jul 2005 13:46:11 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050704135327.GA32098@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 04, 2005 at 03:53:27PM +0200, Matthias Urlichs wrote:
> Hi,
> 
> Sven Verdoolaege:
> > Why not an explicit '-z' option as in the current git-cvsimport-script ?
> 
> Because my code doesn't support compressed cvs connections:
> a -z that doesn't work except for the rlog part would be a lie.

I was talking about the cvsps '-z' option (see current git-cvsimport-script).
Are you saying you want to reserve that option to signify compressed
cvs connections ?

skimo
