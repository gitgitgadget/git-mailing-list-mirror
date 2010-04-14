From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: Add repos but not as normal files, not submodule
Date: Wed, 14 Apr 2010 16:11:17 +1200
Message-ID: <BFCA0C1E-FBE0-4CE6-8018-704BC5E0ACA6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: illegalargument@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 06:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1tx0-00050l-9l
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 06:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab0DNELY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 00:11:24 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:40135 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab0DNELX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 00:11:23 -0400
Received: by iwn35 with SMTP id 35so2497511iwn.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version:x-mailer;
        bh=ZoamHAryJq7fdEvJ1RSQdln9FNu0/+9d9E282BC44tI=;
        b=d149kHGgE7HjVWu+sm3o5svOQtB1WwsyWd2vY4dE8L+Ss6h1xQRrZBDCKfSNFPSqiY
         G57DXpdiJYJhjT1GRMRfPQzsUMxXtGzEYm30M9HPz3PUytfnTbyIvNfkhADAv/HTWYgs
         sY0UPtkIywRdOyRz54uyQkrw8HMZ39Gjwcd4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=b2SOgFnK2yjWq6IUQ4k7YdWAXLFxK0VSKIDxwbXfqWgy7xFtC9zoA807zISF6+4nO7
         FiWqwHS+LwZr4sjYbMmWk96cvo6YRnHqIIeDyWKzSd6KkeHXyWSC+BJgm52t4Ql8APRz
         29b/4jy2zpGIoKG0PLkgCoHyTiRNcz9Pl0amE=
Received: by 10.231.143.148 with SMTP id v20mr3086975ibu.14.1271218282715;
        Tue, 13 Apr 2010 21:11:22 -0700 (PDT)
Received: from [192.168.1.20] ([210.55.232.26])
        by mx.google.com with ESMTPS id j42sm3554794ibr.7.2010.04.13.21.11.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 21:11:21 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144847>

Hi there. 

I have a special situation (maven git scm provider) where I have sub directories with git repps in them which I use as data to run tests on. 

Is it possible to track these "internal" repos without using submodules? 

The only alternative I see is to compress all the test repos in an archive and track that - but that's not nice.

Upon trying to "Add" the internal repos to track, I get error: Invalid path
for example:
antony-stubbss-macbook-pro-4:buildnumber-maven-plugin antonystubbs$ git add src/test/test-repositories/git/branch-tests-japanese/.git/config
error: Invalid path 'src/test/test-repositories/git/branch-tests-japanese/.git/config'
error: unable to add src/test/test-repositories/git/branch-tests-japanese/.git/config to index
fatal: adding files failed

The reason I don't want to do submodules is that I don't want to have the submodules as serperate projects as such, because they're not. they're "test data" so to speak.

Cheers,
Antony.