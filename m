From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFH] pp_header(): work around possible memory corruption
Date: Tue, 19 Jun 2007 01:19:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706190118230.4059@racer.site>
References: <Pine.LNX.4.64.0706151318210.4059@racer.site>
 <7vps3w4g9x.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 02:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0RRf-0003b4-QA
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 02:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760535AbXFSATm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 20:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758774AbXFSATm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 20:19:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:35840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754155AbXFSATm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 20:19:42 -0400
Received: (qmail invoked by alias); 19 Jun 2007 00:19:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 19 Jun 2007 02:19:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187bHFHqyA7IIO1PX1/tciRoNOi59N87NNmVHD5wi
	HbV3oUtMXp3N7d
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps3w4g9x.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50429>

Hi,

On Fri, 15 Jun 2007, Junio C Hamano wrote:

> At least the older humongous pretty_print_commit() got separated into 
> manageable chunks, and I was happy.  I was just too lazy when 
> refactoring the code and stopped there.

That's perfectly okay. This is why you parked it in 'next', I guess.

> The right fix is to propagate the "realloc as needed" callchain into 
> add_user_info(), instead of having "this should be enough" there.  
> These two you touched are the only two callsite of that static function.

Right. As I said, I was in a hurry, and could not research it properly. 
Besides, now that you gave me the proper pointer, I can take care about it 
tomorrow, unless somebody else is faster.

Ciao,
Dscho
