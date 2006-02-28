From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] quilt2git v0.2
Date: Tue, 28 Feb 2006 20:11:15 +0900
Message-ID: <20060228111115.GA32276@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 28 12:11:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE2lK-0007TR-IP
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 12:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWB1LLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 06:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWB1LLW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 06:11:22 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:37398 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751496AbWB1LLV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 06:11:21 -0500
Received: by wproxy.gmail.com with SMTP id i6so104740wra
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 03:11:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=F11EfMO8cwO4gN6na6IvEOn6z2RhMEkouPrbWf1f9wbLC2N9DA1B0t1ssfONg89w0gvBXQUTQfYxARi15NoWPEuy5B3LbidFGBw3eWL4nxxNioVz3ko0CSSW/mK+AGYA8hCTgtDIB9hTKTeCsPRq043DtGrq+bklzd2tISZqUDI=
Received: by 10.35.78.13 with SMTP id f13mr410739pyl;
        Tue, 28 Feb 2006 03:11:20 -0800 (PST)
Received: from htj.dyndns.org ( [221.139.199.99])
        by mx.gmail.com with ESMTP id n78sm2213523pyf.2006.02.28.03.11.19;
        Tue, 28 Feb 2006 03:11:20 -0800 (PST)
Received: by htj.dyndns.org (Postfix, from userid 1000)
	id C23EE1805D; Tue, 28 Feb 2006 20:11:15 +0900 (KST)
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16930>

Hello, v0.2 of quilt2git available.  New in v0.2.

* handles new git HEAD file format properly (regular file storing ref: ...)

* makes use of mail format header from quilt patch description.  From:
  becomes the author, Subject: the subject of the patch.  All commit
  information should be maintained through git2quilt -> quilt2git now.

* --signoff option added.  This option is simply passed to git-commit.

* little fixes

http://home-tj.org/wiki/index.php/Misc
http://home-tj.org/files/misc/quilt2git-0.2
http://home-tj.org/files/misc/git2quilt-0.1

Thanks.

-- 
tejun
