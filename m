From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH] git-parse-remote: Support dummy remote `.' in branch.<name>.remote
Date: Mon, 12 Mar 2007 09:38:44 +0100
Message-ID: <45F51194.5090106@lu.unisi.ch>
References: <45F182DC.9090507@lu.unisi.ch> <7v1wjy3qas.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 09:39:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQg3e-0006k1-Ta
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 09:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbXCLIix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 04:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbXCLIix
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 04:38:53 -0400
Received: from server.usilu.net ([195.176.178.200]:34670 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965346AbXCLIiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 04:38:52 -0400
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Mar 2007 09:38:48 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7v1wjy3qas.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 12 Mar 2007 08:38:48.0285 (UTC) FILETIME=[DA81D8D0:01C76481]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42014>


> By the way, I do not understand the semantics of that
> configuration variable at all.

I think I seriously misunderstood something -- I cannot even
recall what -- when I wrote that.  In fact, the only thing I
want to work, is the scenario for which I wrote the testcase.

I'll ponder your comments on FETCH_HEAD and see if I can write
the patch in a better way.

Paolo
