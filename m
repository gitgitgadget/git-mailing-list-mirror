From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --stat: do not drop rename information.
Date: Thu, 20 Apr 2006 11:40:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604201138130.9099@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmig3o7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 11:40:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWVeO-0000vr-Ac
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 11:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWDTJkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 05:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDTJkd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 05:40:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52458 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750770AbWDTJkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 05:40:33 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 3571F1F7C;
	Thu, 20 Apr 2006 11:40:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 299E71F8A;
	Thu, 20 Apr 2006 11:40:32 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 0AFA11E91;
	Thu, 20 Apr 2006 11:40:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmig3o7r.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18961>

Hi,

On Wed, 19 Apr 2006, Junio C Hamano wrote:

> When a verbatim rename or copy is detected, we did not show
> anything on the "diff --stat" for the filepair.  This makes it
> to show the rename information.

Makes sense. This also shows deletes and adds as "bla/bla => /dev/null" 
and "/dev/null => bla/bla", right?

Ciao,
Dscho
