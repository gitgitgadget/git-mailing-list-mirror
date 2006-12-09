X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 12:27:29 -0500
Message-ID: <457AF201.2000205@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612091437.01183.jnareb@gmail.com> <457ACBA1.4090007@garzik.org> <200612091802.12810.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 17:27:42 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612091802.12810.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33821>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt5z7-0006Dl-DU for gcvg-git@gmane.org; Sat, 09 Dec
 2006 18:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758356AbWLIR1d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758829AbWLIR1d
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 12:27:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33172 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758356AbWLIR1c
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 12:27:32 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1Gt5z0-00005J-De; Sat, 09 Dec 2006 17:27:31 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Jeff Garzik wrote:
>> Jakub Narebski wrote:
> 
>>> As I said, I'm not talking (at least now) about saving generated HTML
>>> output. This I think is better solved in caching engine like Squid can
>>> be. Although even here some git specific can be of help: we can invalidate
>>> cache on push, and we know that some results doesn't ever change (well,
>>> with exception of changing output of gitweb).
>> It depends on how creatively you think ;-)
>>
>> Consider generating static HTML files on each push, via a hook, for many 
>> of the toplevel files.  The static HTML would then link to the CGI for 
>> further dynamic querying of the git database.
> 
> You mean that the links in this pre-generated HTML would be to CGI
> pages?

Yes, they must be.  Otherwise, the gitweb interface changes.

You don't want to pre-generate HTML for every possible git query, that 
would cause an explosion of data.

Both the HTML generator and CGI would need to know which pages were 
pre-generated and which are not.

	Jeff

