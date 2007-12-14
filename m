From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-email doesn't like me+git ML
Date: Fri, 14 Dec 2007 09:54:29 +0100
Message-ID: <476244C5.2090205@op5.se>
References: <20071214014753.GB8914@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 09:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J36Ju-00048j-AE
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 09:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255AbXLNIye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 03:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbXLNIye
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 03:54:34 -0500
Received: from mail.op5.se ([193.201.96.20]:42517 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758255AbXLNIyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 03:54:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 582EE1F08029
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 09:54:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EPTD4As4fPnM for <git@vger.kernel.org>;
	Fri, 14 Dec 2007 09:54:31 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id DAF8C1F08006
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 09:54:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071214014753.GB8914@fawkes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68267>

Jing Xue wrote:
> OK, this is bewildering. I tried a couple of times sending a trivial
> patch (the one that makes git-stash show keep quiet when there aren't
> any stashes), but it never made it to the list every time I used
> git-send-email, yet as soon as I did it as a regular email, i.e.,
> starting a new message in mutt, pasting the patch into the body, and
> sending it, it worked just fine.
> 
> My mail log shows the mails (the one thru git-send-email) went out just
> fine.  And it always worked when I tried to use git-send-email to send
> the patch to my gmail address. It just doesn't work with the list - and
> that obviously can't be. 8-)
> 

I've had similar problems. I think it's actually a filtering issue on the
receiving end though, as some seem to see the mails on the list (while
most don't). Looking at the headers, I see the hostname of my laptop as
originating host when using git-send-email, which obviously will fail
for any receiving host that tries to connect back to verify that the
originating sender is indeed a real SMTP server.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
