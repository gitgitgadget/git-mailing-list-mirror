From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone: don't unpack objects
Date: Wed, 19 Oct 2005 22:23:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510192221240.17759@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051019154341.2aed6998.tihirvon@gmail.com>
 <7v4q7d5kwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:26:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKTP-0008Il-9E
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVJSUXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVJSUXk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:23:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40865 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751298AbVJSUXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:23:40 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C93E613EFFC; Wed, 19 Oct 2005 22:23:34 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 87B229EEF7; Wed, 19 Oct 2005 22:23:34 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C5049EEF5; Wed, 19 Oct 2005 22:23:34 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DA5C813EFFC; Wed, 19 Oct 2005 22:23:33 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q7d5kwo.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10302>

Hi,

On Wed, 19 Oct 2005, Junio C Hamano wrote:

> What do people on the list think?

For projects with a long history, it might make sense to do it 
unconditionally, but for young projects, the packs would be very small and 
inefficient.

However, I cannot think of other use cases where "--keep" would not make 
sense, and since projects tend to get a long history, maybe it would be 
good to introduce a "--nokeep" to git-clone.

JM2C,
Dscho
