From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 17:28:22 +0530
Message-ID: <ec6uct$jdb$1@sea.gmane.org>
References: <44E54AC6.9010600@gmail.com> <20060818195148.66411.qmail@web31807.mail.mud.yahoo.com> <7v64gp7prk.fsf@assigned-by-dhcp.cox.net> <cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com> <7virkp3snv.fsf@assigned-by-dhcp.cox.net> <ec6rol$dbe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 19 13:59:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEPUK-0002MR-M2
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 13:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWHSL7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 07:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWHSL7Z
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 07:59:25 -0400
Received: from main.gmane.org ([80.91.229.2]:16567 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750891AbWHSL7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 07:59:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GEPTb-0002Al-H8
	for git@vger.kernel.org; Sat, 19 Aug 2006 13:58:55 +0200
Received: from 59.92.143.67 ([59.92.143.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 13:58:55 +0200
Received: from aneesh.kumar by 59.92.143.67 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 13:58:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.143.67
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <ec6rol$dbe$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25717>

Jakub Narebski wrote:
> Junio C Hamano wrote:
> 
>>  * The value of the hash is an array whose first two elements
>>    are a sub and a bool, and the rest of the elements are the
>>    default values of feature specific parameters.
> 
> Which means that it is not that easy to change defaults from 
> $GITWEB_CONFIG ($feature{'blame'}->[1] = 1; ?).
> 

how about 

   'blame'         => [\&feature_blame, $feature_blame_override, 0],

and picking only $feature_blame_override from $GITWEB_CONFIG

-aneesh 
