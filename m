From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS
 compilant with GNU Coding Standards
Date: Tue, 9 Aug 2005 12:17:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508091212170.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <1123306575.7588.17.camel@dv.roinet.com> <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
 <20050808231036.GA22778@mythryan2.michonline.com>
 <Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 12:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2RBS-0008JN-FI
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 12:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVHIKR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 06:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVHIKR6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 06:17:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20446 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932503AbVHIKR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 06:17:57 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A8ECEE32D6; Tue,  9 Aug 2005 12:17:54 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8866BAC8CC; Tue,  9 Aug 2005 12:17:54 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6A98CAC8B3; Tue,  9 Aug 2005 12:17:54 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E13BE32D6; Tue,  9 Aug 2005 12:17:54 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Junio C Hamano wrote:

> Johannes, could you sanity check the commit change I have in the
> proposed updates branch when things percolate through kernel.org
> mirror network?  I ended up pushing it out before I found you
> already did a patch.

I just checked. Three nitpicks:

- I don't like the GNU way to abbreviate long options too much. Either you 
  know exactly what you're doing, and you use the short form, or you want 
  to make sure that you have spelt it correctly. Besides, it makes the 
  code less readable and more prone to errors.

- Multiple -m options was actually a feature of my version of the patch.

- The "case .. in x) .. ;; esac;" construct is sometimes more confusing 
  than a simple "if", or even a "[ .. = x ] && ..".

As I said, just nitpicks. I didn't test, though. I'll do that when the 
commit is in the master branch :-) Maybe I'll even write my first git test 
case, who knows?

Ciao,
Dscho
