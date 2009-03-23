From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: git svn teething problems - initial clone okay - fetches not working
Date: Mon, 23 Mar 2009 19:30:55 -0000
Message-ID: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:33:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llpt3-0004qi-2C
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 20:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbZCWTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbZCWTbI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 15:31:08 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:48027 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbZCWTbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 15:31:07 -0400
Received: by ewy9 with SMTP id 9so1785706ewy.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=txR9110QOkKNXNjzF+MlxODuwO5JG3OqXh/NiOPiSBM=;
        b=yAhbmyjQmCLZN9STO6aR1rL7KUE7x7uIYrwOz/TXD0lJhJgt9JFJnSLcv+9thswEzM
         hAv6fELf4d1qq19j8ryjX7YsdA2/f36jSKeXHNSdp2mJ5Eri46UMx+H9djhe2Bogm0QZ
         OOdbkFeMIkLwinHaFkyYeuwmlWg9NWCd/ydUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=VaIKhiVZVVOQf84fdjyNirmRdWVjRAq0APdk5HDS0Xt0LUK8EMniAD7XorCzn8MIDE
         vJuR7c2SgimGtfS5kePUOtUDFohMz4L3TC50pFLJjmS0mBu9PBBvzlXcohysDH8YQuNG
         CpAi74dM/X1zcS313wGNTZiWyLdUjOJzKjbhk=
Received: by 10.216.16.208 with SMTP id h58mr2458547weh.60.1237836662243;
        Mon, 23 Mar 2009 12:31:02 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id d27sm5535586nfh.78.2009.03.23.12.31.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 12:31:01 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114343>

Hi,

I am a newbie to git, so be warned :)

I have installed git-daemon, and gitweb on an F10 server.

Basically managed to do a 'git svn clone' on LLVM, it took 11 hours !

Anyway I am having the problem that I can do a 'git svn fetch' and I see 
changes coming in. But the gitweb and another git clone from it do not 
reflect those changes. The repository is still showing its two days old.

I am obviously missing something. The only documentation I could find on 
'git svn' was the command line help and 'man git-svn'.

Hope you can help,

Aaron
