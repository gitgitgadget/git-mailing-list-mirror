From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Few cleanup patches
Date: Sun, 1 Apr 2007 22:21:01 +0200
Message-ID: <200704012221.01676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 00:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HY8xW-00041R-1Z
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 00:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXDAWzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbXDAWzU
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 18:55:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:42353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbXDAWzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 18:55:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1386144uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 15:55:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=DaJpI7kKoFGYYV5EHcmZWGmJr0rkdO0SF1Ie/NwaszZByhNcWaBrf/sw690P6HhpqfLS4QgI25QvgiJLlTvpwXDUzqVQA6zlqaQiWNr3tDe48A2NhJnKd7U0iDc8GmuF2lgltUUErubw3hAcGhTOn+QO1H7M4nbw2QzLTn71i4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=r+9nZJmZMuIeJa0G8fegrqpBt7qy+Fb6XCZaGXVAZwGyfSA/0mSNiwoF4T+CkIFV56p3X06UKZe6YJ5+l10G0JA9yz5ZQfP+RAvY7BcjSRTmv0XojryO+EA2uPVsBQln2OtJaqNYNBLlh6wzZFNQyOEhzUm7Tmg+IEv/WiRp1JE=
Received: by 10.67.103.7 with SMTP id f7mr4052141ugm.1175468117912;
        Sun, 01 Apr 2007 15:55:17 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm17434124mue.2007.04.01.15.55.15;
        Sun, 01 Apr 2007 15:55:16 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43592>


 [PATCH 1/3] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (3)
 [PATCH 2/3] gitweb: Quote hash keys, and do not use barewords keys
 [PATCH 3/3] gitweb: Few doublequoted strings cleanups

---
 gitweb/gitweb.perl |  150 ++++++++++++++++++++++++++--------------------------
 1 files changed, 75 insertions(+), 75 deletions(-)

-- 
Jakub Narebski
Poland
