From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-mergetool about Apple's opendiff/FileMerge
Date: Thu, 22 Mar 2007 21:52:27 -0700
Message-ID: <46035D0B.8020009@midwinter.com>
References: <20070322213728.GD3854@regex.yaph.org> <7vbqiksh4a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>, tytso@mit.edu,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 05:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUblR-0004tm-JA
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 05:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbXCWEwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 00:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXCWEwa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 00:52:30 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50204 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751349AbXCWEw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 00:52:29 -0400
Received: (qmail 12333 invoked from network); 23 Mar 2007 04:52:28 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=PKT97M6G5rLzQYyU/mCNqFLt6fxh4ePexbr7vstmyTTQf14/J3u1xeTrYo9kB3cV  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 23 Mar 2007 04:52:28 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <7vbqiksh4a.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42904>

Junio C Hamano wrote:
>> +                opendiff $LOCAL $REMOTE -merge $path | cat
> What's the purpose of this cat anyway?  It looks like an
> expensive no-op to me.
>   

If stdout is a tty, opendiff appears to background itself automatically. 
I assume he wanted to prevent that without losing any output from the 
command.

-Steve
