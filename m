From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: is it possible filter the revision history of a single file into another repository?
Date: Thu, 18 Dec 2008 08:51:12 -0500
Message-ID: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 14:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJIn-0005Qr-Rg
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 14:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYLRNvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 08:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYLRNvO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 08:51:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:35225 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYLRNvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 08:51:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so228669wah.21
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 05:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=FRRl2yv6gL1Td7w0atCnDC+pWncTFmktunS1yMzGnuw=;
        b=dgHnVPbAB06Sl/efX74gvmN9Uq0n3yLWN/3ac1qqaA8dxprozptZEwhRp63V7HhJA7
         whiUhMPXJO+eP47GA+EKRbjpv7HXdv4ZxVgbpR9UYizMkVGw9EmDiR4+xT+UKSq8fJZt
         zan836TXpD5+nVSG58XMunslMoBjxY0O8vVx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=NLHrRksFud8slzZYnxgrNNxF1xy53hME/s7Jp/7E4CnRslSFFGudbA1hUSlQpTpgXM
         15huvxIGuyiJoeg52kMVia3ElEEEGoqLkduXl0OJCagz9GJF3wBO0BT4J1rtqHTuVVGV
         PdtfRuB29aNn94MDrVFZOhDQeXssgRu9Rb4ig=
Received: by 10.114.193.1 with SMTP id q1mr1106039waf.153.1229608272414;
        Thu, 18 Dec 2008 05:51:12 -0800 (PST)
Received: by 10.114.136.7 with HTTP; Thu, 18 Dec 2008 05:51:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103460>

For instance, if my repository contains foo.c, and 100 other files.

I would like to create a new and separate repository containing only
the revision history of foo.c.

Would someone mind pointing me at some documentation for this
procedure if it exists?

Thanks very much,
Whit
