From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Rename/copy detect in qgit
Date: Thu, 17 Aug 2006 15:40:08 +0200
Message-ID: <e5bfff550608170640j666795dbo9cccad2c7a1cf154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 17 15:41:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDi7i-0004Xo-H1
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 15:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWHQNkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 09:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWHQNkT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 09:40:19 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:38985 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964917AbWHQNkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 09:40:10 -0400
Received: by py-out-1112.google.com with SMTP id z74so1440399pyg
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 06:40:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j3Oq+SsjWu7R5vt1/s/jhvAvZoZOmIbcYda6f9j2WVyslWCF4CMMr8V6DB52LJwSVA7ZlOjpopC+qDJo558pntXiEItM3hQ7ZYZkWp7UY/CiSFDwGsUK3YCgQrjw8Dh78cPAtquYejUWTfJnEupohSmAGQbL5NTe4a45V5nSEgs=
Received: by 10.35.106.15 with SMTP id i15mr3580776pym;
        Thu, 17 Aug 2006 06:40:09 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Thu, 17 Aug 2006 06:40:08 -0700 (PDT)
To: "GIT list" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25584>

I have pushed (git://git.kernel.org/pub/scm/qgit/qgit.git) some
patches to add file rename/copy detection to qgit.

It was harder then expected due to some subtle details, and still the
merge combined case is missing, anyhow I think feature is usable and
should be quite stable.

If someone is interested it would be great to give it a try because
testing is required.

BTW it is now possible to view file rename/copy info in patch view as
well in file list (see screenshot), both views are synced and old
commands (as example double-clicking on file name) should still work
as expected.

Screenshot: http://digilander.libero.it/mcostalba/rename_copy.png

Thanks
Marco
