From: Jakub Narebski <jnareb@gmail.com>
Subject: git --prune --aggresive
Date: Fri, 23 Nov 2007 10:58:46 +0100
Message-ID: <200711231058.46578.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 10:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVJW-000695-Gh
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbXKWJ6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 04:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbXKWJ6x
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:58:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:21518 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbXKWJ6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 04:58:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2720106nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=mumoTxxKQLU7F5CijmzijsCNq+AQhudJYLe2OulFq58=;
        b=pt1UXvkK2VvQxGARVUNvNrDtPucLyU8hlHV9hORjOZZLsG2hGJnlx5F9oYwcWJ4e72aypz0V/NPFmVPEnCxZOWGEqPiRnk4NdMSVWttGabzwEJ23Fb+Bgw+OGMSqu10k9rbWRW5QYbPA/1ksCPBrildZtcjD3COkf875i6JJWk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mCHulsrnSmefghGFEO5DAU6QMtnDjO7viB8kSvK5S4bDuUwgYEKAkoQepBWLfgUUk5tDXoz77+inUFTucXaSWCqx9YDzXwCExhgY2z/9vZewaZOyBNfloPm3nBUeiXVIYsiHSzFCail4U4b6d0UxZxbTmoeLjEB7jKTfzDjcjXk=
Received: by 10.86.98.18 with SMTP id v18mr9384628fgb.1195811930083;
        Fri, 23 Nov 2007 01:58:50 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id 4sm1089361fge.2007.11.23.01.58.48
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 01:58:49 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65885>

2396:[gitweb/web@git]# git gc --aggresive --prune
usage: git-gc [--prune] [--aggressive]
2397:[gitweb/web@git]# git gc --prune --aggresive
usage: git-gc [--prune] [--aggressive]
2398:[gitweb/web@git]# git --version
git version 1.5.3.5

Either usage string should be fixed, as it suggests that you can specify 
both --aggresive and --prune, or git-gc should.

-- 
Jakub Narebski
Poland
