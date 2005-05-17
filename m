From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFH] Janitor projects around core GIT
Date: Tue, 17 May 2005 00:56:58 -0400
Message-ID: <4289799A.3040204@pobox.com>
References: <7vpsvqihkh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 06:57:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXu8U-0008RS-8z
	for gcvg-git@gmane.org; Tue, 17 May 2005 06:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEQE5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 00:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEQE5J
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 00:57:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48799 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261265AbVEQE5D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 00:57:03 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DXu8c-0005md-Gv; Tue, 17 May 2005 04:57:02 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsvqihkh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>  * Rewrite command line parsing code, probably using GNU getopt.
>    I have three gripes about option parsing in the current code:


Use argp.  It supports short and long options, and is highly flexible. 
"info argp" should work on most Linux boxes.

It's in glibc, and if people care about porting git to Solaris/whatever, 
there is a GPL'd version already out there.

	Jeff


