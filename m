From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 10:33:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 10:35:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUgj7-0006aJ-RO
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVJZIdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVJZIdi
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:33:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24536 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932577AbVJZIdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 04:33:38 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0DBAA13F25C; Wed, 26 Oct 2005 10:33:35 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E32929ABB3; Wed, 26 Oct 2005 10:33:34 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB7719ABAE; Wed, 26 Oct 2005 10:33:34 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 75CF213F25C; Wed, 26 Oct 2005 10:33:34 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10651>

Hi,

On Tue, 25 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Using dc is not really necessary, since expr understands summing 32 bit 
> > signed integers. Which means that git-count-objects will now fail when 2 
> > GB of unpacked objects have accumulated.
> 
> Sorry, but I am not very happy about this patch.  "local"
> bashism aside, doesn't this spawn expr for every unpacked
> object?

Aargh! I had the impression "expr" was a builtin... Just forget about the 
patch, okay?

Ciao,
Dscho
