From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] shifting xdiff hunks?
Date: Thu, 13 Apr 2006 09:44:13 +0200
Organization: At home
Message-ID: <e1kvft$4r2$1@sea.gmane.org>
References: <7vmzeqyolw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Apr 13 09:44:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTwUw-0000NF-VE
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 09:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWDMHoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 03:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWDMHoL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 03:44:11 -0400
Received: from main.gmane.org ([80.91.229.2]:52914 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964823AbWDMHoK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 03:44:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FTwUo-0000LX-6k
	for git@vger.kernel.org; Thu, 13 Apr 2006 09:44:06 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Apr 2006 09:44:06 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Apr 2006 09:44:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18655>

Junio C. Hamano wrote:
 
> Now, from correctness point of view, this is not a problem at
> all, but I am wondering if xdiff can help to always shift the
> hunk down or up to consistently produce one way or another
> (personally I feel the former is easier to read).

This would also help with adding new functions, as sometimes diff begins
with the closing brace of the preceding function, instead of ending with
closing brace of the added function.

Just my own 0.2 eurocents.

-- 
Jakub Narebski
Warsaw, Poland
