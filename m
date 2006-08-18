From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 22:10:34 +0530
Message-ID: <44E5ED82.8090904@gmail.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 18 18:41:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7Pe-0005t5-Kl
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWHRQla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWHRQla
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:41:30 -0400
Received: from main.gmane.org ([80.91.229.2]:39040 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751405AbWHRQl3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 12:41:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE7PF-0005na-Tb
	for git@vger.kernel.org; Fri, 18 Aug 2006 18:41:13 +0200
Received: from 59.92.199.81 ([59.92.199.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 18:41:13 +0200
Received: from aneesh.kumar by 59.92.199.81 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 18:41:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.199.81
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25676>

Junio C Hamano wrote:

> * Jeff Garzik reports that the summary page of gitweb does not
>   look at anything other than "master" which is not appropriate
>   for his tree.
> 
>   Message-ID: <44D874F0.6000907@garzik.org>
> 
>   I probably should bug gitweb gang (Jakub, Luben, Martin Waitz,
>   Aneesh) about this.
> 


I just tried editing HEAD. For the project 

http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary

$more HEAD
ref: refs/heads/from-linus
$

Is this solution fine ?. Or do we want to add a git-rep-config variable to indicate which branch to show.

-aneesh 
