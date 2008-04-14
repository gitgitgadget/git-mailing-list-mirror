From: Joachim Berdal Haga <jobh@broadpark.no>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when run
 within subdirectory
Date: Mon, 14 Apr 2008 09:03:35 +0200
Message-ID: <480301C7.3010702@broadpark.no>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
 <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:04:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIjn-0007ZI-KE
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbYDNHDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 03:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYDNHDj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:03:39 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:59734 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbYDNHDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:03:38 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0JZA001WUZM17RC0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 09:03:37 +0200 (CEST)
Received: from pep ([80.203.45.22]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0JZA0051SZM05EF0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 09:03:37 +0200 (CEST)
Received: from localhost ([127.0.0.1])	by pep with esmtp (Exim 4.69)
	(envelope-from <jobh@broadpark.no>)	id 1JlIj2-0000F6-7Q; Mon,
 14 Apr 2008 09:03:36 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-reply-to: <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
X-Enigmail-Version: 0.95.0
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: jobh@broadpark.no
X-SA-Exim-Scanned: No (on pep); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79473>

Shawn Bohrer wrote:
> When git clean is run from a subdirectory it should follow the normal
> policy and only remove directories if they are passed in as a pathspec,
> or -d is specified.
> 
> Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>

I have tested this version and it fixes my problem/testcase. Thanks,

-j.
