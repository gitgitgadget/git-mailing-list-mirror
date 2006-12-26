From: SungHyun Nam <goweol@gmail.com>
Subject: private file add/checkout
Date: Tue, 26 Dec 2006 11:00:12 +0900
Message-ID: <4590822C.3070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 26 03:00:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz1cF-000521-Cn
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 03:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLZCAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 21:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWLZCAR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 21:00:17 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:42841 "EHLO
	relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbWLZCAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 21:00:16 -0500
Received: from [211.48.62.136] ([211.48.62.136]) 
          by relaygw1.kornet.net ([61.74.75.196]) 
          with ESMTP id 2006122611:00:14:431109.19779.56757168
          for <git@vger.kernel.org>; 
          Tue, 26 Dec 2006 11:00:14 +0900 (KST) 
Received: from [61.84.23.13] ([61.84.23.13]) 
          by relay8.kornet.net ([211.48.62.136]) 
          with ESMTP id 2006122611:00:14:406341.24148.73214896
          for <git@vger.kernel.org>; 
          Tue, 26 Dec 2006 11:00:14 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
To: GIT <git@vger.kernel.org>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35404>

Hello,

Though I set 'shared=false' or umask=0077,
I cannot add a file with mode=0600.
GIT always added it as mode=0644.
How I can add/checkout a file with mode=0600?
Is it impossible?

Thanks,
namsh
