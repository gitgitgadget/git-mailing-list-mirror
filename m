From: Mircea Bardac <dev@mircea.bardac.net>
Subject: git svn --use-log-author misbehavior?
Date: Fri, 20 Jun 2008 00:51:39 +0100
Message-ID: <485AF10B.7060202@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Tvl-0005I9-Ke
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbYFSXvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754320AbYFSXvq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:51:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:21211 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbYFSXvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:51:46 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1066246ugf.16
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 16:51:44 -0700 (PDT)
Received: by 10.210.26.10 with SMTP id 10mr2465375ebz.15.1213919503545;
        Thu, 19 Jun 2008 16:51:43 -0700 (PDT)
Received: from macmac.local ( [89.155.32.52])
        by mx.google.com with ESMTPS id i6sm1842868gve.4.2008.06.19.16.51.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 16:51:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85577>

Hi,

According to the documentation, this parameter (--use-log-author) should 
  use the author from the From/Signed-off-by line. Unfortunately, I 
found this to be working only on the first git svn clone. Later rebasing 
made the commits use the old username@uuid format.

I am assuming the option is not being preserved in the Git repository 
metadata and it is only used on cloning/init. Is this the intended 
behavior?

Many thanks.

-- 
Mircea
http://mircea.bardac.net
