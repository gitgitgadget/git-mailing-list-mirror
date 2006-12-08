X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 11:54:32 -0500
Message-ID: <457998C8.3050601@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net> <45798FE2.9040502@zytor.com> <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 16:55:11 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33705>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsizv-0002Au-Ic for gcvg-git@gmane.org; Fri, 08 Dec
 2006 17:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425630AbWLHQyw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 11:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425623AbWLHQyw
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 11:54:52 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:52310 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425630AbWLHQyv
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 11:54:51 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GsizZ-00070z-LS; Fri, 08 Dec 2006 16:54:34 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> I could write a simple C caching thing that just hashes the CGI arguments 
> and uses a hash to create a cache (and proper lock-files etc to serialize 
> access to a particular cache object while it's being created) fairly 
> easily, but I'm pretty sure people would much prefer a mod_perl thing just 
> to avoid the fork/exec overhead with Apache (I think mod_perl allows 
> Apache to run perl scripts without it), and that means I'm not the right 
> person any more.
> 
> Not that I'm the right person anyway, since I don't have a web server set 
> up on my machine to even test with ;)
> 	
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

This is quite nice and easy, if memory-only caching works for the 
situation:  http://www.danga.com/memcached/

There are APIs for C, Perl, and plenty of other languages.

	Jeff

