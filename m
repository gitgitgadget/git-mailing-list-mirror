From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv4 0/2] Documentation: refactor config variable descriptions
Date: Tue, 21 Jun 2011 22:36:57 +0200
Message-ID: <20110621203041.11131.90701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 22:37:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ7hl-0003Qd-P2
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab1FUUhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 16:37:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35343 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757455Ab1FUUhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 16:37:36 -0400
Received: by wwe5 with SMTP id 5so153395wwe.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=/Dhz2gopxCLm7dVwgXHa/Zoek0lMA/7ipZlPbF/Vldo=;
        b=mkc+bT925j9hP8wbPJfqTKmuNomirCbLJS3vnGmsxMNah+x6k0bY39HPrfJxp1xg0L
         p/HNmVJNhYG2eF4b5h4RlRa5DulE8M+JypD/7DdD3MurmmIvQmgnEBbFouSOLT4vhPYG
         Lc2sdXtqD42/5YKnzqV7jxTZ3crCXcLN2fhPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=pI0te/WWa9QnjwqR2R9S/MyiDaw1nbqEhciJdM0ErQP13Q4OKBIrW8xcDkTtzUa42p
         WT0avR7CEWay1N+psUzzueiw2Ssxg9TJDwzLE7RlGCeWdMybDvuIPx5cgszIxvuCdDNr
         C5mkNJlSne7D0cSIPZTgktInOKzRyznvks5Kg=
Received: by 10.227.165.10 with SMTP id g10mr343405wby.91.1308688653877;
        Tue, 21 Jun 2011 13:37:33 -0700 (PDT)
Received: from localhost.localdomain (abvd183.neoplus.adsl.tpnet.pl [83.8.201.183])
        by mx.google.com with ESMTPS id et5sm4286273wbb.50.2011.06.21.13.37.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 13:37:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5LKavP1011228;
	Tue, 21 Jun 2011 22:37:08 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176198>

This is something that I noticed while doing cleanup of old unused
branches.

Last version of this series was sent (IIRC) on 22.10.2010 as

  [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
  http://thread.gmane.org/gmane.comp.version-control.git/159641

This series is without

      Documentation: move format.* documentation to format-patch

Rebasing it on top of current version was easy, even though there were
many conflicts. I simply used the script in commit message of first
patch to extract config-vars.txt file automatically.
---
Thomas Rast (2):
      Documentation: complete config list from other manpages
      Documentation: Move variables from config.txt to separate file

 Documentation/Makefile              |   10 
 Documentation/config-vars-src.txt   | 1760 +++++++++++++++++++++++++++++++++++
 Documentation/config.txt            | 1759 -----------------------------------
 Documentation/make-config-list.perl |  234 +++++
 4 files changed, 2005 insertions(+), 1758 deletions(-)
 create mode 100644 Documentation/config-vars-src.txt
 create mode 100755 Documentation/make-config-list.perl

-- 
Jakub Narebski
ShadeHawk on #git
Poland
