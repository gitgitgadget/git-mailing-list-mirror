From: Tomasz bla Fortuna <tomaszfortuna@gmail.com>
Subject: About gitweb.cgi bug
Date: Fri, 29 Apr 2005 15:23:00 +0200
Message-ID: <e72f90b8050429062342724335@mail.gmail.com>
Reply-To: Tomasz bla Fortuna <tomaszfortuna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 29 15:49:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRVl2-0001TW-UD
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 15:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVD2Na0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 09:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVD2NaN
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 09:30:13 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:38995 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262625AbVD2NXG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 09:23:06 -0400
Received: by wproxy.gmail.com with SMTP id 68so1087069wra
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 06:23:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=axR02Oino1GDnWhbGrU491GBSINdNgRQsgxDumx1lidISfe4GqPU4I8+4x7640WUxW4crfcmJPwvop3zRK9RdVwK/UuISmEvDqiyeuO+4hX9bZdi9By/F6S28EyNVrH9NVkGH0lMu03RuSwXb6JtV30+4/yWEwSllr7KCsxonok=
Received: by 10.54.78.9 with SMTP id a9mr1700192wrb;
        Fri, 29 Apr 2005 06:23:00 -0700 (PDT)
Received: by 10.54.89.3 with HTTP; Fri, 29 Apr 2005 06:23:00 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,
I've found html injection bug:
http://www.kernel.org/git/gitweb.cgi?p=%3Cimg%20src=%22http://af.gliwice.pl/p.png%22%3Ecogito%2Fcogito.git;a=log
May lead to redirection to some pr0n sites using kernel.org address...
but its nothing.

Have a nice day,
  Tomasz bla Fortuna
