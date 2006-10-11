From: Wolfgang Denk <wd@denx.de>
Subject: cg-commit does not run pre-commit hook?
Date: Wed, 11 Oct 2006 22:30:54 +0200
Message-ID: <20061011203054.C5F80353A48@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 22:33:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXkjE-0003sC-FH
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 22:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWJKUa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWJKUa5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 16:30:57 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57284 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1161241AbWJKUa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 16:30:56 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 76D2FA0148;
	Wed, 11 Oct 2006 22:30:55 +0200 (CEST)
X-Auth-Info: e8mvRVddKy53J7j2+Nmu7Q49razc5UwJzfTrA8F1vqc=
X-Auth-Info: e8mvRVddKy53J7j2+Nmu7Q49razc5UwJzfTrA8F1vqc=
Received: from mail.denx.de (p54967D94.dip.t-dialin.net [84.150.125.148])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 62EF593980;
	Wed, 11 Oct 2006 22:30:55 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id F059D6D00BA;
	Wed, 11 Oct 2006 22:30:54 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id C5F80353A48;
	Wed, 11 Oct 2006 22:30:54 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28743>

Hi,

I noticed that cg-commit does not run the pre-commit  hook.  Is  this
intentional,  or  am  I  doing anyhting wrong? When I use git-coimmit
instead the hook is run just  fine.  This  is  with  git-1.4.2.1  and
cogito-0.18 of FC4 / FC5 systems.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are bugs and then there are bugs.  And then there are bugs.
                                                    - Karl Lehenbauer
