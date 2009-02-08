From: Mark - mkdynamic <markdodwell@gmail.com>
Subject: Suggestion: git submodule status
Date: Sun, 8 Feb 2009 21:39:37 +0000
Message-ID: <82B56DB5-C195-46DF-BFD3-903BB8A5D0CE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 22:41:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWHOv-00088E-68
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 22:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbZBHVju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 16:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbZBHVju
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 16:39:50 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:62490 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZBHVjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 16:39:49 -0500
Received: from [192.168.1.88] (host86-164-87-137.range86-164.btcentralplus.com [86.164.87.137])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1LWHNQ1jyV-0000Zo; Sun, 08 Feb 2009 22:39:44 +0100
X-Mailer: Apple Mail (2.753.1)
X-Provags-ID: V01U2FsdGVkX1+xUUC9wGJ2WPLYyBAmWGYdNjZaxns/+GMn/Dl
 FduWK8MJI8ezxtmRjcz3RYUEX/VLkxWj1F3+y8wS4Bh3brBnDR
 lxIy4/gfYWOXa/mdNRW+mTsbXfqfqcE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109016>

Considering a situation with 1 submodule:

   $ git submodule status
   SHA1 /some/path (REFERENCE)

Would it not be more useful if it reported the REFERENCE as reported by:

   git describe --all SHA1

rather than the current implementation, which I believe shows the  
result from:

   git describe -SHA1

Does this make sense, or am I missing something?

Thanks,

~ Mark
