From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re-organize "git-rev-list --objects" logic
Date: Fri, 16 Sep 2005 00:27:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509160026010.20359@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0509151507380.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 00:29:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG2Cf-00012u-T6
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbVIOW1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 18:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbVIOW1f
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:27:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18305 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965293AbVIOW1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 18:27:34 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8FDBD136869; Fri, 16 Sep 2005 00:27:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 739A3919B9; Fri, 16 Sep 2005 00:27:31 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5F1CC8C1B8; Fri, 16 Sep 2005 00:27:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B6A30E0F3A; Fri, 16 Sep 2005 00:27:30 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151507380.26803@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8647>

Hi,

On Thu, 15 Sep 2005, Linus Torvalds wrote:

> I know how to make it use _lots_ less memory, which will probably speed it 
> up. But that's for another time, and I'd prefer to see this go in first.

Mind to elaborate just a bit?
