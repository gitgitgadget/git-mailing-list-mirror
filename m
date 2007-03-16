From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH] git-fetch, git-parse-remote: Cleanup implementation of
 '.'
Date: Fri, 16 Mar 2007 10:38:03 +0100
Message-ID: <45FA657B.1010709@lu.unisi.ch>
References: <etavpn$ma0$1@sea.gmane.org>	<7vr6rqyr60.fsf@assigned-by-dhcp.cox.net>	<45FA5771.1040200@lu.unisi.ch> <7vps79v8ik.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 10:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS8t4-0005nB-3D
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 10:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbXCPJiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 05:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933259AbXCPJiK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 05:38:10 -0400
Received: from server.usilu.net ([195.176.178.200]:24246 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933149AbXCPJiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 05:38:08 -0400
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Mar 2007 10:40:54 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vps79v8ik.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 16 Mar 2007 09:40:54.0640 (UTC) FILETIME=[313D7F00:01C767AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42341>


> I may not be really thinking straight tonight (no I am not
> drunk, but just a tad sick), but I wonder if this is sufficient?
> 
> 	$(git-for-each-ref --format='%(refname):')
> 
> Shorter and one less process and pipe.

It is.  Would you take care of that?

Paolo
