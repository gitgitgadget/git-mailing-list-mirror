X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Mike McCormack <mike@codeweavers.com>
Subject: Re: pushing patches to an imap folder
Date: Wed, 16 Nov 2005 12:18:49 +0900
Organization: CodeWeavers
Message-ID: <437AA519.5050304@codeweavers.com>
References: <43799A67.9030705@codeweavers.com>	<7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>	<4379B9F6.5020402@codeweavers.com>	<7vzmo5ka20.fsf@assigned-by-dhcp.cox.net>	<437A9109.6010101@codeweavers.com> <7vek5hcmh4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 16 Nov 2005 03:22:31 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
Return-path: <git-owner@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
In-Reply-To: <7vek5hcmh4.fsf@assigned-by-dhcp.cox.net>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EcDrp-0002Hw-Af for gcvg-git@gmane.org; Wed, 16 Nov
 2005 04:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965203AbVKPDVq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005
 22:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVKPDVq
 (ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:21:46 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:48774 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S965203AbVKPDVp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 22:21:45 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
 by mail.codeweavers.com with esmtp (Exim 4.50) id 1EcDrh-0007g5-F8; Tue, 15
 Nov 2005 21:21:44 -0600
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Junio C Hamano wrote:

> Hmph.  Kinda surprised.  You guys do not do icons?

We do, but we have a tool called bin2res that converts them to text and 
stores them in a comment in the .rc file that they're associated with:

http://cvs.winehq.org/cvsweb/~checkout~/wine/dlls/shell32/shres.rc?rev=1.42&content-type=text/plain

This was done because of trouble with binary files in CVS.

