From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 4/4] Documentation: Improve documentation for git-imap-send(1).
Date: Tue, 8 Jul 2008 21:35:46 -0400
Message-ID: <19AD9080-74BE-4147-8DF5-8A2937129B6D@silverinsanity.com>
References: <1215555496-21335-4-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOc0-0004vv-Dl
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYGIBfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbYGIBfw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:35:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37049 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYGIBfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:35:52 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 7C5B21FFC023;
	Wed,  9 Jul 2008 01:35:40 +0000 (UTC)
In-Reply-To: <1215555496-21335-4-git-send-email-robertshearman@gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87830>


On Jul 8, 2008, at 6:18 PM, Robert Shearman wrote:

> +Using direct mode:
>
> +.........................
> [imap]
> -    Host = imaps://imap.example.com
> -    User = bob
> -    Pass = pwd
> -    Port = 993
> +    folder = "[Gmail]/Drafts"
> +    host = imaps://imap.example.com
> +    user = bob
> +    pass = p4ssw0rd
> +    port = 123
>     sslverify = false
> ..........................

If you're going to use [Gmail]/Drafts as the example folder, shouldn't  
you just use mail.google.com as your example?  Google themselves use username@gmail.com 
  as an example[1], so that should be safe. So:

..............................
[imap]
     folder = "[Gmail]/Drafts"
     host = imaps://imap.gmail.com
     port = 993
     user = username
     pass = password
..............................

And I also assume that someone has tried this with Gmail and it  
doesn't mangle the Drafts.  I'd also move the sslverify option into  
the tunneling example, as it's more likely to be needed there.

[1] http://mail.google.com/support/bin/answer.py?answer=78799

~~ Brian
