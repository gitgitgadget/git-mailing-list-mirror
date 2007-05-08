From: apw@us.ibm.com (Amos Waterland)
Subject: Re: [PATCH] wcwidth redeclaration
Date: Tue, 8 May 2007 13:18:55 -0400
Message-ID: <20070508171855.GA19533@us.ibm.com>
References: <20070508044608.GA32223@us.ibm.com> <7vmz0f52no.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705081202080.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 08 19:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlTXx-0000eA-KT
	for gcvg-git@gmane.org; Tue, 08 May 2007 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXEHRZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 13:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbXEHRZv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 13:25:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42296 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964934AbXEHRZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 13:25:50 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48HPoBv020332
	for <git@vger.kernel.org>; Tue, 8 May 2007 13:25:50 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l48HPoF0541046
	for <git@vger.kernel.org>; Tue, 8 May 2007 13:25:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l48HPnCZ017059
	for <git@vger.kernel.org>; Tue, 8 May 2007 13:25:50 -0400
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l48HPnfB017052;
	Tue, 8 May 2007 13:25:49 -0400
Received: by kvasir.watson.ibm.com (Postfix, from userid 1000)
	id AB47CB151F1; Tue,  8 May 2007 13:18:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705081202080.4167@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46602>

On Tue, May 08, 2007 at 12:03:47PM +0200, Johannes Schindelin wrote:
> Thanks indeed. I thought that a static function could shadow a global 
> function, but probably not with a different signature. Just out of 
> curiosity: what is the signature of wcwidth in your string.h?

This is it:

        extern int      wcwidth(wchar_t);
