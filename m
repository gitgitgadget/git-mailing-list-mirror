From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: git svn clone failure
Date: Sat, 28 Mar 2009 08:18:47 +1100
Message-ID: <A5DCF978-5D10-4A6C-BE4B-1024FA475E2F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 22:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnJTW-0007tA-UI
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 22:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbZC0VSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbZC0VSz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 17:18:55 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:3720 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbZC0VSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 17:18:54 -0400
Received: by ti-out-0910.google.com with SMTP id i7so904402tid.23
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=Riz17TBcHB02UtvLtzUz1YEBNYHYouGe6snm3QMIhh8=;
        b=E7oYX7zK69rlq4mnc8G1gals/xU+6OcIHxaMNZZzrQpCr19xA+hNRT7zKf6kUxQZNn
         kTlpSDy2DQ9yIEAjdFoeKzVpBYXYSm6eLt5ajNZ1jCo3+mmthZpABp01fe5aezfozD5q
         8jszPNr7084p7BkL96Fkmirgrc20G64Afq/OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=LoudWFz7mRLH9q/KiS5mNECFmEka7af+CHwgEA5YdGIAE2Db2sJKum3bpkV8J66DGt
         PiKyUx+VCPREfTlc88J+jNHC5q/BlmOJv5wHuDwm2dxvCgsDJ6QygNjYKAUyPzZbzmeE
         wK5aqE6NIHPhvkwxbN9RE4Gh2zeca3Tl1mMUc=
Received: by 10.110.3.15 with SMTP id 15mr3489269tic.43.1238188731823;
        Fri, 27 Mar 2009 14:18:51 -0700 (PDT)
Received: from ?10.0.1.200? (208.198.233.220.exetel.com.au [220.233.198.208])
        by mx.google.com with ESMTPS id d4sm2149527tib.8.2009.03.27.14.18.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 14:18:51 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114925>

Hi there,

I'm trying to clone an existing svn repository with git (just getting  
started with git) and it keeps failing with:
...
r604 = 6428e63734a21ee5fcb4593274747e2758578a91 (git-svn)
fatal: unable to run 'git-svn'

I'm using git version 1.6.2
Mac OS X 10.5.6. git installed via macports with svn support.

Any ideas? How do I find out why it's failing?
Thanks.

with regards,
--

Lachlan Deck
