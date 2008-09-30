From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 12:29:01 +0200
Message-ID: <48E1FF6D.1050907@viscovery.net>
References: <20080930080355.GA19605@sigill.intra.peff.net> <48E1FB76.1040500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:30:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkcUj-0006Nz-FR
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYI3K3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 06:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbYI3K3G
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:29:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12280 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYI3K3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:29:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KkcTV-0007rR-Tk; Tue, 30 Sep 2008 12:29:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A81CB4FB; Tue, 30 Sep 2008 12:29:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48E1FB76.1040500@op5.se>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97091>

Andreas Ericsson schrieb:
> Jeff King wrote:
>> -    if ! grep -qe "Invalid gitfile format" .err
>> +    if ! grep "Invalid gitfile format" .err
> 
> Doesn't output need to be redirected when you drop '-q'?

In standard mode, the test output is directed to /dev/null anyway, and in
verbose mode the extra output doesn't hurt at all, and is usually useful
because you know that a pattern matched.

-- Hannes
