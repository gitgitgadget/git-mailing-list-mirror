From: Kacper Kornet <draenog@pld-linux.org>
Subject: Exit code of git-ls-remote
Date: Thu, 12 May 2011 14:05:36 +0200
Message-ID: <20110512120536.GA22033@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 14:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKUeL-0003Yo-Jz
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 14:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803Ab1ELMFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 08:05:44 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:38920 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549Ab1ELMFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 08:05:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 788015F0048
	for <git@vger.kernel.org>; Thu, 12 May 2011 14:05:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Nr7P43ms21oS for <git@vger.kernel.org>;
	Thu, 12 May 2011 14:05:36 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 986145F0046
	for <git@vger.kernel.org>; Thu, 12 May 2011 14:05:36 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 8249780B93; Thu, 12 May 2011 14:05:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173463>

git-ls-remote behaves differently then git-show-ref when it cannot find
any matching refs. While the latter returns non zero exit code in this
case, the former always returns 0. Is there any specific reason for this
behaviour?

-- 
  Kacper Kornet
