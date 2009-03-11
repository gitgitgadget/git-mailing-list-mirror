From: Bernie Innocenti <bernie@codewiz.org>
Subject: Obfuscated error message
Date: Wed, 11 Mar 2009 05:24:58 +0100
Organization: Sugar Labs Foundation - http://sugarlabs.org/
Message-ID: <49B73D1A.4050605@codewiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giovanni Bajo <rasky@develer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 05:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhG82-0007la-7y
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 05:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbZCKEbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 00:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZCKEbo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 00:31:44 -0400
Received: from trinity.develer.com ([89.97.188.34]:47108 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZCKEbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 00:31:43 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2009 00:31:43 EDT
Received: (qmail 30631 invoked from network); 11 Mar 2009 04:24:59 -0000
Received: from static-217-133-10-139.clienti.tiscali.it (HELO ?10.4.4.169?) (bernie@217.133.10.139)
  by trinity.develer.com with ESMTPA; 11 Mar 2009 04:24:59 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090103)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112878>

A friend who uses Mercurial pointed this out as a reson why
Git is evil:

rasky@lilax:~/src$ git clone git://www.develer.com/doesnt-exist
Initialized empty Git repository in /home/rasky/src/doesnt-exist/.git/
fatal: The remote end hung up unexpectedly

Plus, the directory was not really there :-)

rasky@lilax:~/src$ hg clone hg://www.develer.com/doesnt-exist
abort: repository hg://www.develer.com/doesnt-exist not found!

rasky@lilax:~/src$ svn co svn://www.develer.com/doesnt-exist
svn: URL 'svn://www.develer.com/doesnt-exist' doesn't exist

-- 
   // Bernie Innocenti - http://www.codewiz.org/
 \X/  Sugar Labs       - http://www.sugarlabs.org/
