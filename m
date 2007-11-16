From: Fabrizio Pollastri <f.pollastri@inrim.it>
Subject: preserving mtime
Date: Fri, 16 Nov 2007 10:33:45 +0100
Message-ID: <473D63F9.4010201@inrim.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 11:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isy72-0004NN-9R
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 11:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbXKPKHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 05:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbXKPKHb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 05:07:31 -0500
Received: from gate.inrim.it ([193.204.114.65]:44229 "EHLO posta.inrim.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755548AbXKPKHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 05:07:30 -0500
X-Greylist: delayed 1988 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2007 05:07:30 EST
Received: from localhost (localhost.inrim.it [127.0.0.1])
	by posta.inrim.it (Postfix) with ESMTP id B3CA32F6C37B
	for <git@vger.kernel.org>; Fri, 16 Nov 2007 10:34:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.808
X-Spam-Level: 
X-Spam-Status: No, score=-3.808 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.591, BAYES_00=-2.599]
Received: from posta.inrim.it ([127.0.0.1])
	by localhost (posta.inrim.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTgjpdO7DhB9 for <git@vger.kernel.org>;
	Fri, 16 Nov 2007 10:34:17 +0100 (CET)
Received: from [10.10.2.15] (zot.intra.inrim.it [10.10.2.15])
	by posta.inrim.it (Postfix) with ESMTP id E7B032F6C361
	for <git@vger.kernel.org>; Fri, 16 Nov 2007 10:34:16 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.13pre) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.11~pre071022-0etch1+lenny1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65209>

Hi all,
is it possible to tell git to preserve the file modification time in a 
checked out copy? It is useful when managing web files, where mtime is 
tested by spiders for download decisions.
Thank you, for any help.

--
Cheers,
F. Pollastri
