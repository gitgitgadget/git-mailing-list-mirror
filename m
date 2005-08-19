From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git-push to a local directory forces unpack/repack?
Date: Fri, 19 Aug 2005 14:57:59 +1200
Message-ID: <46a038f905081819573626cee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 19 04:59:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5x5S-0007P7-Lv
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 04:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVHSC6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 22:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVHSC6F
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 22:58:05 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:2898 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750949AbVHSC6E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 22:58:04 -0400
Received: by rproxy.gmail.com with SMTP id i8so428754rne
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 19:57:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CBlm6FvPDCs/ryeqZNHwT9GS1mDSYQMjCwWTcZg0wHHEJTAlp237Uz+g5sAOQQ04B6Cmzl591AeCadfOvyqsCFYacOePuH6njdZWGeMtBTBHw0bmooF7ka79EqiensVCQ+iEf0LTEHeMU6CS5VqPyzeUFzXcp+/3sil+kGW1aPc=
Received: by 10.38.88.5 with SMTP id l5mr853284rnb;
        Thu, 18 Aug 2005 19:57:59 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 18 Aug 2005 19:57:59 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If I do git-push ~/somelocaldir it forces a full unpack of the
project, is this expected? I was expecting a harmless copy of the
packs...

At the moment, it means 900MB when I am initializing the public repo.
I haven't found the way to convince it to use rsync. Still running
repack.

cheers,


martin
