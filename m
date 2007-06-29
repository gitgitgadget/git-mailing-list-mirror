From: Tobias Sarnowski <sarnowski@cosmocode.de>
Subject: How to share the same commits offline?
Date: Fri, 29 Jun 2007 17:28:03 +0200
Organization: CosmoCode GmbH
Message-ID: <46852503.8090407@cosmocode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 17:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4IbA-0005uz-6z
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 17:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbXF2Pl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 11:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757769AbXF2Pl0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 11:41:26 -0400
Received: from semaphore.cosmocode.de ([212.84.235.4]:39318 "EHLO
	semaphore.cosmocode.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135AbXF2PlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 11:41:25 -0400
X-Greylist: delayed 864 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2007 11:41:25 EDT
Received: from localhost (localhost [127.0.0.1])
	by semaphore.cosmocode.de (Postfix) with ESMTP id 8FAA245431D
	for <git@vger.kernel.org>; Fri, 29 Jun 2007 17:27:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cosmocode.de
Received: from semaphore.cosmocode.de ([127.0.0.1])
	by localhost (semaphore.cosmo [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppTk2jmdkowM for <git@vger.kernel.org>;
	Fri, 29 Jun 2007 17:27:23 +0200 (CEST)
Received: from [192.168.0.189] (tobi.cosmo [192.168.0.189])
	by semaphore.cosmocode.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri, 29 Jun 2007 17:27:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070628)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51178>

Hi,

I am very happy with git and I am using it now on every project I
develop, thanks Linus! My question is, how can I share objects with
another repository without a direct connection?

If I create patches with git-format-patch I am loosing the commit id
informations, so the copied tags loose their target too. I want to be
able to distribute changes by e-mail without loosing the sha1 ids. (Just
dump copying the .git/object files and updateing the .git/refs only
cause errors - I did not grab the source codes enough to understand the
connections)

Thanks,
Tobias Sarnowski
