From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2] gitweb: Use list for of open for running git commands, thorougly.
Date: Mon, 31 Jul 2006 14:38:15 +0200
Organization: At home
Message-ID: <eaktj9$df1$1@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <200607292251.21072.jnareb@gmail.com> <7virle6o5z.fsf@assigned-by-dhcp.cox.net> <eakqaj$530$1@sea.gmane.org> <eakrub$99t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 14:39:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7X2p-0002pq-3J
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 14:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWGaMio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 08:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGaMio
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 08:38:44 -0400
Received: from main.gmane.org ([80.91.229.2]:26839 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932134AbWGaMim (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 08:38:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7X2X-0002nD-Ok
	for git@vger.kernel.org; Mon, 31 Jul 2006 14:38:34 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 14:38:33 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 14:38:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24519>

Jakub Narebski wrote:

> Jakub Narebski wrote:
> 
>> Junio C Hamano wrote:
>> 
>>> This, together with PATCH 6, seems to break "history" link.
>>> Visit a repository (summary page), click on "tree" on the second
>>> line, and click on "history" (on any blob or tree).
>> 
>> Strange... returning this part of git_history to previous version, i.e.
>> 
>>   open my $fd, "-|",
>>     "$GIT rev-list --full-history $hash_base -- \'$file_name\'";
>> 
>> still gives no history. Curious. Will examine that...
> 
> Curiouser and curiouser. It seems that somehow --full-history option 
> (which was never documented by the way) got lost somewhere.

Ooops. I've forgot that '--full-history' option was introduced after v1.4.0
(which I use).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
