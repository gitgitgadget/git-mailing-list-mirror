From: Wayne Scott <wsc9tt@gmail.com>
Subject: bogus merges
Date: Mon, 5 Sep 2005 09:38:29 -0500
Message-ID: <59a6e58305090507387d412b3d@mail.gmail.com>
Reply-To: wsc9tt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Sep 05 16:39:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECI7L-0007rC-Ml
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 16:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVIEOic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 10:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVIEOic
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 10:38:32 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:57151 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750717AbVIEOib convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 10:38:31 -0400
Received: by wproxy.gmail.com with SMTP id i22so285473wra
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 07:38:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YVBi/TyKJSmUIEEUQSweGqbLbFDQHIKhV1SeWoNSDKBLlBlFtdr8mD9NRPyZ1It9MSkYFLg2/2O2/l+RMZm9a8bOBa0Trp9zpLtsVJKsj5CMfUJUEsO1ghEyhuSKKaxKLC9YsmWoB1938aHnupnvPGuHHX1dL/qx5MNO9rEXiRg=
Received: by 10.54.83.10 with SMTP id g10mr3729120wrb;
        Mon, 05 Sep 2005 07:38:29 -0700 (PDT)
Received: by 10.54.36.41 with HTTP; Mon, 5 Sep 2005 07:38:29 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8091>

A recent commit in linux-2.6 looks like this:

commit b129a8ccd53f74c43e4c83c8e0031a4990040830
Merge: 6b39374a27eb4be7e9d82145ae270ba02ea90dc8
194d0710e1a7fe92dcf860ddd31fded8c3103b7a
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Wed Aug 31 10:12:14 2005 +0100

    [SERIAL] Clean up and fix tty transmission start/stoping
    
The problem is that two parents of this merge are separate.  One is an
ancestor of the other.  This means the merge is really pointless and
probably accidental.

Really 'git commit' should detect problems like this automatically and
prevent them from getting in the tree.

-Wayne
