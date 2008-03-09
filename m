From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: git svn dcommit does not cleanup after errors
Date: Sun, 9 Mar 2008 16:36:42 +0300
Message-ID: <c6c947f60803090636m3c656d35x5a924d093f68628e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 14:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYLiZ-0006dm-3j
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 14:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYCINgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 09:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbYCINgn
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 09:36:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:9344 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbYCINgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 09:36:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1730359wah.23
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=HavsJFlKur1GO4WEjLC3F/eP3G0DyM48j0oqIjE11M8=;
        b=cTnUr8ibpdjJ4VLv37DTKeyYsbH3bxvZ+OEtObS75mIX6tMIMpYOWBGW1OaCXIki83VcROJXiJJ7Q5kY2XVwU1Etz++qHYCQlASrwFPF36D+YFvZUOB2nSPRAR2AUExjAZFvyBjAcKwdv/kdO14bt5Orr85kBVGv6+gsnZg1fbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HJVqq0xP2V2rc7SoKMSDitr437UlfilfrH/xmd39sQsy3xC2uA48iqY7lve8M/8hTAdQd3Tn2n0WOBuamirH3xir8ftOelnOeOEgbB/+FMI4GRaI5eISRRoKFVyEAoqi434RcKCA0Uh4kgCv4J4m8C8a5ZELvpV5E1gPa+LgO4w=
Received: by 10.114.109.1 with SMTP id h1mr1904102wac.35.1205069802048;
        Sun, 09 Mar 2008 06:36:42 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Sun, 9 Mar 2008 06:36:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76660>

Hi, list!

(GIT v1.5.4.4)

When I'm doing git svn dcommit and it fails in the middle (due to SVN
pre-commit hooks or connection errors or whatever), it leaves my HEAD
rewound to the last commit it attempted to upload. I have to manually
do git reset HEAD@{whatever}. Is this behaviour intended? Is there a
more convenient way to restore my HEAD state?

Thanks in advance,
Alexander.
