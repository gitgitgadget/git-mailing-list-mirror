From: Jan Klod <janklodvan@gmail.com>
Subject: chrooting git daemon?
Date: Thu, 11 Jun 2009 15:30:31 +0000
Message-ID: <200906111530.31160.janklodvan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 17:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEmEk-00016g-BU
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 17:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761275AbZFKPag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 11:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761252AbZFKPaf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 11:30:35 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:56898 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759151AbZFKPac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 11:30:32 -0400
Received: by bwz9 with SMTP id 9so1536481bwz.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OHlous4e/q7mu0cdWzWra78L8xgN7AL++bwIqXMehk4=;
        b=HixwXjR5b0Dq4RDYQaU9K1ayTNnLntEqTzrO6OajykuEPVzsOR4CC0nZlopaVi2StL
         p7/g0IfO0UNs658/CMZwRuNme8+zsJQty1W6EPGZHjRErpBYcCTM624g5BMGHCcmdtkd
         TTO/vLt4UQG1W0Aaz3wZI5/dmKgH4UpQrNz+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=tegP4BSna70KiGCu3LxHO8VDLqauQ8aPGtPX1ewuTG8v9vHLgpQlQ8XgklQkVyQzpD
         5g4bcFUUnICetGJ2eyGi544EGUPJDBMpjplJKVercT8BU6SwBc/llbD+rviVGwC1FOAJ
         Lo+nKkh7syNpxCeCUetziA2pnYVBQi4NMlItM=
Received: by 10.103.179.1 with SMTP id g1mr1383084mup.48.1244734233611;
        Thu, 11 Jun 2009 08:30:33 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id 12sm127135muq.53.2009.06.11.08.30.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 08:30:33 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121343>

Hello,
please, is that hard / complicated to run git daemon in chroot and what are 
the steps to do it best?
Do you consider it useless precaution there? 

Jan
