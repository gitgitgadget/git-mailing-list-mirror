From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Wed, 4 Oct 2006 17:15:23 -0700 (PDT)
Message-ID: <20061005001523.72654.qmail@web31806.mail.mud.yahoo.com>
References: <7vzmcdpwso.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 02:15:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVGtd-0007aw-H5
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 02:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWJEAPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 20:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWJEAPZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 20:15:25 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:3946 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751247AbWJEAPY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 20:15:24 -0400
Received: (qmail 72656 invoked by uid 60001); 5 Oct 2006 00:15:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dmTFgKDnbqIq8PTTaKcgVP20n1WvKD+heTyud43EKv6BIqKX7S0VQvChL3bI4JI/I6KKAT6FiV9NFAzm1N14Kuw8Bj2OqSSoqrn90EWFC0OtTqEcZTo6vrN/WCIPqBy5BLwsJh66JN1dXAEqT4nFd9AW0JKrjfAtfKsU2IXmUaM=  ;
Received: from [64.215.88.90] by web31806.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 17:15:23 PDT
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vzmcdpwso.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28334>

--- Junio C Hamano <junkio@cox.net> wrote:
> BTW,
> 
>  - why do we have shortlog and log twice in the top navigation
>    bar in commit view (a=commit)?

It appears to be in the $extra argument to git_print_page_nav()
from git_commit() from cae1862a, lines 3033-3037.

    Luben


> 
>  - sometimes I'd like to view my tags sorted by name not by
>    age.  Maybe we could add <sort-by> control on the age and
>    name columns for git_tags_body()?
> 
> 
> 
