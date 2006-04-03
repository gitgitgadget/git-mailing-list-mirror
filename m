From: Andreas Ericsson <ae@op5.se>
Subject: Re: Default remote branch for local branch
Date: Mon, 03 Apr 2006 09:56:07 +0200
Message-ID: <4430D517.5020205@op5.se>
References: <1143856098.3555.48.camel@dv> <200604021817.30222.Josef.Weidendorfer@gmx.de> <7v7j67k65b.fsf@assigned-by-dhcp.cox.net> <200604030128.42680.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 09:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQJv4-0004FO-2X
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 09:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWDCH4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 03:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDCH4J
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 03:56:09 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:4264 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932350AbWDCH4I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 03:56:08 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 74FB36BD05; Mon,  3 Apr 2006 09:56:07 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200604030128.42680.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18319>

Josef Weidendorfer wrote:
> 
> Optionally, branching <new> off from <old> could add <new> as
> topic branch of <old>: Thus, if you are on <old> and do git-pull,
> you get <new> merged in.
> 

This is clearly insane. If I'm on <old> and want to sync with my 
upstream source that would be impossible without explicitly telling it 
*not* to merge with <new>. Iow, this change would (possibly) simplify 
for the one repo maintainer, but make things harder for the 30-odd 
developers.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
