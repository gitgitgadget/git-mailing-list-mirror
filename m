From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Test fails on ubuntu breezy
Date: Thu, 13 Apr 2006 13:23:07 +0530
Message-ID: <cc723f590604130053k6896c0cfkd8ea648e91d50d0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 13 09:53:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTwdn-0001do-EA
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 09:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWDMHxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 03:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWDMHxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 03:53:09 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:18643 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964820AbWDMHxI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 03:53:08 -0400
Received: by wproxy.gmail.com with SMTP id i31so498404wra
        for <git@vger.kernel.org>; Thu, 13 Apr 2006 00:53:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Du99MlAOYbguH1wtF+OEZCVZSoTLVrNdmnafmqhkfJsxiRbAKJ2HHbdgjgh9d07sxg8PNw/OBljJmItlYDR79QXVA/LRrzCxskB2Yh94sCgnaT1vFeRmExBe2u6T6crSNc6NUbIMHrnwLubYCG1hZTZMp2mDrIVE9YSP1Q4DHUY=
Received: by 10.64.114.10 with SMTP id m10mr65447qbc;
        Thu, 13 Apr 2006 00:53:07 -0700 (PDT)
Received: by 10.64.114.4 with HTTP; Thu, 13 Apr 2006 00:53:07 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18656>

kvaneesh@home:~/git-work/git.build/t$ ./t3600-rm.sh
Committing initial tree e5c556e46aae6124ff4a2a466c95004e92d9a2e4
*   ok 1: Pre-check that foo exists and is in index before git-rm foo
*   ok 2: Test that git-rm foo succeeds
*   ok 3: Post-check that foo exists but is not in index after git-rm foo
*   ok 4: Pre-check that bar exists and is in index before "git-rm -f bar"
*   ok 5: Test that "git-rm -f bar" succeeds
*   ok 6: Post-check that bar does not exist and is not in index after
"git-rm -f bar"
*   ok 7: Test that "git-rm -- -q" succeeds (remove a file that looks
like an option)
*   ok 8: Test that "git-rm -f" succeeds with embedded space, tab, or
newline characters.
* FAIL 9: Test that "git-rm -f" fails if its rm fails
        git-rm -f baz
*   ok 10: When the rm in "git-rm -f" fails, it should not remove the
file from the index
* failed 1 among 10 test(s)
kvaneesh@home:~/git-work/git.build/t$

-aneesh
