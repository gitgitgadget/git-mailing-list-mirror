From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: multi-threaded git-index-pack
Date: Thu, 6 Dec 2007 22:32:28 -0500
Message-ID: <9e4733910712061932p712b9f00k49677a0db4afee8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 04:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0TxK-0001Ly-91
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 04:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbXLGDca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 22:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbXLGDca
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 22:32:30 -0500
Received: from ro-out-1112.google.com ([72.14.202.179]:14093 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbXLGDc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 22:32:29 -0500
Received: by ro-out-1112.google.com with SMTP id p4so6945207roc
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 19:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=yg9VfJ0/P1oAyx0BBCw27NhgUy5kUo+m//Vt1ZaQiWA=;
        b=AKgA9uvLHMevIKTJ6GiojwbHilrnomw8L1FTPtzJDd5DGZEwplA0ZFnuZT6E1WTAqtDarviZ4/5smROi5pnuAuuI4NkR1BIpvzoLarSCYIglLikOzC0sh8OOY8mBzJ9ti4qciGrSQpQUEaBmxxi0wzDBOrQS+Ln4kQqtqeiTng8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bC/C5x3pfgv0pVj9OjuMBNnwZFLpi8ljgBVj8Gxt3FKrqw2H7v78SDtMTVcxHsUGEmMMYKM8c7j8qPZdYazO0Ho6uAKjxjLolydsgm1kkQcuZ/8QcFpbHwVu75G6DJpaP21uMs3XdIKrGNq3Zt5kHFFfp45H5yRmJ3CFD525kMY=
Received: by 10.115.22.1 with SMTP id z1mr2114087wai.1196998348342;
        Thu, 06 Dec 2007 19:32:28 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 19:32:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67373>

I'm cloning the gcc repo. My clone has been sitting in git-index-pack
for about 10 minutes and it is only using one core. Is this something
could be multi-threaded?

-- 
Jon Smirl
jonsmirl@gmail.com
