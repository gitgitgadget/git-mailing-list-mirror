From: Bryan Larsen <bryan@larsen.st>
Subject: large publicly accessible HTTP archive?
Date: Fri, 31 Oct 2008 13:07:01 -0400
Message-ID: <490B3B35.60508@larsen.st>
References: <S1751776AbYJaQ5O/20081031165714Z+111@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 18:10:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxTw-0006vK-2T
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 18:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbYJaRHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 13:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYJaRHG
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 13:07:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:18543 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYJaRHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 13:07:05 -0400
Received: by yx-out-2324.google.com with SMTP id 8so582396yxm.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 10:07:03 -0700 (PDT)
Received: by 10.65.163.8 with SMTP id q8mr13519867qbo.54.1225472822825;
        Fri, 31 Oct 2008 10:07:02 -0700 (PDT)
Received: from ?192.168.1.91? (206-248-156-239.dsl.teksavvy.com [206.248.156.239])
        by mx.google.com with ESMTPS id k29sm7988946qba.7.2008.10.31.10.07.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 10:07:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <S1751776AbYJaQ5O/20081031165714Z+111@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99609>

Hello,

I'm one of the maintainers of MacPorts git port.

A long time ago, we had problems pulling extremely large archives over 
HTTP on PowerPC machines.  By large, I mean on the order of 500 
megabytes: I was testing using an embedded Linux distribution.

We "fixed" the problem by turning off CURL_MULTI and ignored the 
problem.  Yes, bad form, I know.

Our problems were against curl 7.16.2.

However, in recent git's, CURL_MULTI is required to do an HTTP push, so 
we've had users complaining.

Curl is up to 7.19.0, they may have fixed our problem.  Unfortunately, 
the distribution I used for testing is gone now.  Putting up a local 
archive doesn't exhibit the problem either.

Is anybody aware of a very large HTTP accessible repository that 
wouldn't mind me doing a few test pulls from?  By large, I mean >500 
megabytes of network traffic for a single pull.

thanks,
Bryan
