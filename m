From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Fri, 02 Mar 2007 17:29:12 +0100
Message-ID: <45E850D8.4040306@lu.unisi.ch>
References: <es66vt$jej$1@sea.gmane.org> <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DDB5.9060009@lu.unisi.ch> <Pine.LNX.4.63.0703021220420.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E814D9.7020104@lu.unisi.ch> <Pine.LNX.4.63.0703021640440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNAdF-00039z-Di
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 17:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992588AbXCBQ3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992584AbXCBQ3R
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 11:29:17 -0500
Received: from server.usilu.net ([195.176.178.200]:16064 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2992589AbXCBQ3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 11:29:17 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Mar 2007 17:29:13 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0703021640440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 02 Mar 2007 16:29:13.0520 (UTC) FILETIME=[E9ED6B00:01C75CE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41226>

> 	if (buf[i] == '[') {
> 		if (section_name_match(&buf[i + 1], old_name) {
> 			if (new_name == NULL)
> 				remove = 1;
> 			else
> 				/* write new section */
> 			continue;
> 		}
> 		remove = 0;
> 	}
> 	if (!remove)
> 		/* write buf */

Try doing this and you'll see that the 8-character indentation makes it pretty hard. :-)

Paolo
