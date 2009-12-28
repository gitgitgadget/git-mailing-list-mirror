From: Sylvain RABOT <srabot@steek.com>
Subject: Need some help with git rebase
Date: Mon, 28 Dec 2009 14:33:27 +0100
Message-ID: <4B38B3A7.6010900@steek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 14:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPFpn-0008By-M1
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 14:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbZL1Nk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 08:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZL1Nk0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 08:40:26 -0500
Received: from sarca.steek.com ([62.39.111.200]:54115 "EHLO sarca.steek.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbZL1Nk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 08:40:26 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2009 08:40:26 EST
Received: from localhost (localhost [127.0.0.1])
	by sarca.steek.com (Postfix) with ESMTP id 4B95246A82
	for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:33:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at sarca.steek.com
Received: from sarca.steek.com ([127.0.0.1])
	by localhost (sarca.steek.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tC1WeTbP-rgO for <git@vger.kernel.org>;
	Mon, 28 Dec 2009 14:33:28 +0100 (CET)
Received: from [192.168.1.190] (LMontsouris-152-62-23-90.w80-13.abo.wanadoo.fr [80.13.22.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: srabot@steek.com)
	by sarca.steek.com (Postfix) with ESMTPSA id 5837046A81
	for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:33:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135739>

Hello everybody,

I'm trying to backport a feature branch which is based on the master 
branch into another branch also based on master but older :

                         a--a--a--a--a--a--a--a--a feature
                        /
--x--x--x--x--x--x--x--x--x--x--x--x master
   \
    o--o--o--o--o--o--o 12.72.1
   
   
This is what I would like :
   
   
                         a--a--a--a--a--a--a--a--a feature
                        /
--x--x--x--x--x--x--x--x--x--x--x--x master
   \
    o--o--o--o--o--o--o--a--a--a--a--a--a--a--a--a 12.72.1
   

And this is what I get with git rebase --onto 12.72.1 master feature
   
    o--o--o--o--o--o--o--a--a--a--a--a--a--a--a--a feature
   /
--x--x--x--x--x--x--x--x--x--x--x--x master
   \
    o--o--o--o--o--o--o--a--a--a--a--a--a--a--a--a 12.72.1

Can you exlain to me what I need to do to get what I expect.

Best regards.

-- 
Sylvain
