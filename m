From: skillzero@gmail.com
Subject: Safe to manually copy git repository?
Date: Sat, 10 May 2008 10:57:24 -0700
Message-ID: <2729632a0805101057r181b9afftdcaf7c6d0b8895f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 19:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JutKs-0006iF-66
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 19:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbYEJR50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbYEJR50
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 13:57:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:25404 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbYEJR5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 13:57:25 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2501958waf.23
        for <git@vger.kernel.org>; Sat, 10 May 2008 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Cg2dy11HzFB9qRe16FXvTB31y+zv5SzSJb4aKwaMnk4=;
        b=dvMQ5mhOSYKXpNrqDFNAhbilOZRZ7IyGmqnt3/QFqLQbzxdH3tn9CfLhH3QTZFlh1y+Y3exFrNS1OGZxbXHfehr+ul6nOIeoT/J1kaeFLgXTXYe6OAA6+Z+Wn7KzPopJm7ooR0GESf+8xV/GukRm3oHLedhkirXI8mCAKkkICoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UDLesmReUGNoTgCI6yUIldVq/qXhye6nyHmPZHwTgytSctQmSJXCmdYycGL1ZfmnuJELLqFKtSCHXN66u5oaaZtIpRnZaW3Ii4J9pqGEXsijbZMGWchA5qYIvnN9N4644boABux3zBPZRrNHhIOGakdaqtTK+59XGAuIFcfbfls=
Received: by 10.114.150.1 with SMTP id x1mr5524754wad.46.1210442244698;
        Sat, 10 May 2008 10:57:24 -0700 (PDT)
Received: by 10.114.193.9 with HTTP; Sat, 10 May 2008 10:57:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81689>

Is it safe to copy the .git directory to a different machine and/or
location and start using it from there? Or are there machine and/or
location-specific things in the repository? Setting up a copy with git
init, git fetch, etc. doesn't copy hooks, etc. so I'd like to just be
able to set things up locally and copy the repository to the server.
It seems to work, but I wanted to double check.
