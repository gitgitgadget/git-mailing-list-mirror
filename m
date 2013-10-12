From: "Fernando Ortiz (e2k)" <eratos2000@gmail.com>
Subject: Git send-email fail on Mac OS X Lion
Date: Fri, 11 Oct 2013 23:06:17 -0500
Message-ID: <04374E86-02D8-4E76-A7F5-7DEE34F25C7F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Fernando Ortiz <eratos2000@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 06:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUqTB-000663-3r
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 06:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714Ab3JLEGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 00:06:21 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:55652 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab3JLEGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 00:06:20 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so3376711obc.20
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 21:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=TcBee9wwR/GASwGgUjeQ9kVLz7A9UxC/OtttV9Tmcu8=;
        b=Vr4EEgY3x2KN2WGXIeflMqRrCuSjfsan7Vq5jtFiRvt0Z+ma29Povek1KwMpA0BI8J
         tVB4GsHvlD5gAeraXzlMXSJ5ubi0zoDbwqR2pGbrBW2Ys9XlmNk/RVboq3Lqh3gvQO0M
         nX+rlngr8nzKo/pOHZDeFPZG+qdVDn6k5KYqVS0pKtLgHWXHCBP75oqnqHWfGK6oXyM9
         orsawEMh43hqI8LHmSj3LUcFNia7ivxoSUPdypMjvCI6ypZ5t3yFQ8w23l8pSp7WyceW
         Imv8qs6YFsz8/bOwgvDgWCcvB5G7qtKtXptHVgMJb6NAx/4uls5VRd+qa+IXBNG5hAT4
         v9rg==
X-Received: by 10.182.29.233 with SMTP id n9mr13210159obh.38.1381550780028;
        Fri, 11 Oct 2013 21:06:20 -0700 (PDT)
Received: from [192.168.2.106] (ip70-180-90-249.no.no.cox.net. [70.180.90.249])
        by mx.google.com with ESMTPSA id u3sm100429917oeq.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 21:06:19 -0700 (PDT)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235940>

I'm getting the following error when I do:

git send-email --compose --from Fernando Ortiz <eratos2000@gmail.com> --to fortiz2k@gmail.com --cc fortiz2k@gmail.com 0001-Change-zcat-to-gzcat-to-fix-build-restore-steps.patch

Net::SSLeay version 1.46 required--this is only version 1.36 at /Users/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/IO/Socket/SSL.pm line 17.
BEGIN failed--compilation aborted at /Users/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/IO/Socket/SSL.pm line 17.
Compilation failed in require at /Users/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/Net/SMTP/SSL.pm line 8.
BEGIN failed--compilation aborted at /Users/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/Net/SMTP/SSL.pm line 8.
Compilation failed in require at /usr/local/Cellar/git/1.8.4/libexec/git-core/git-send-email line 1232.