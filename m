X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Planned new release of git [was: Re: If merging that is really
 fast forwarding creates new commit]
Date: Tue, 7 Nov 2006 15:06:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611071504200.3667@g5.osdl.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
 <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
 <45503553.3020605@gmail.com> <Pine.LNX.4.64.0611070729370.3667@g5.osdl.org>
 <7vhcxb2b15.fsf@assigned-by-dhcp.cox.net> <eiqvoh$ebd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 7 Nov 2006 23:07:22 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eiqvoh$ebd$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31098>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gha1g-0002AV-GO for gcvg-git@gmane.org; Wed, 08 Nov
 2006 00:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753844AbWKGXGh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 18:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbWKGXGh
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 18:06:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62900 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1753844AbWKGXGg (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 18:06:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA7N6UoZ021046
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 7
 Nov 2006 15:06:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA7N6T0o020779; Tue, 7 Nov
 2006 15:06:29 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Tue, 7 Nov 2006, Jakub Narebski wrote:
>  
> Do I understand correctly that the work on not exploding downloaded
> pack on fetch, but making it non-thin, and related work on archival
> packs (not to be considered for repacking) is not considered ready
> (and tested)?

I'd like to see a new version with both the packed refs and the 
non-exploading download on by default. Maybe time for a git-1.5.0 release 
from master?

