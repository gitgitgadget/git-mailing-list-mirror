From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: push git: failing
Date: Sat, 18 Apr 2009 19:07:28 +0100
Message-ID: <1A83D14F3FC342B9A02B82C64AC080D8@HPLAPTOP>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP> <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk> <DD909F216D254CDAB2A0C0847AEB75C0@HPLAPTOP> <alpine.LNX.2.00.0904181632150.20139@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 20:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvEyQ-0007RO-LU
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 20:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZDRSHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZDRSHb
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 14:07:31 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:58110 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbZDRSHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 14:07:31 -0400
Received: by ewy24 with SMTP id 24so622835ewy.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:references
         :subject:date:mime-version:content-type:content-transfer-encoding
         :x-priority:x-msmail-priority:x-mailer:x-mimeole;
        bh=VoNWUl9KhktZoUl/b5ZzdKk5n/oYmgMbxvUgmSGFeaY=;
        b=ilF60bIDeckBJy6+Q5eI3+zNadSVam/9+yC3nhlnTk6tHSrFfbFb3Q7wZXGs/CiZPi
         u/hzdseGzuNRSrBRBoMXJu3oLxvn+eo2IIIY+k06Evf7DKIQwtR6qBTn7Yq2h+M4O3KT
         Qd0S45w/46f31X/NduS7aqAbxE+eEPAsLHbGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=TpXGbTW1FVOuev7PV5aTlTZtkqHCxD9rhOCqy/W7IEwrfjBU2oyX0xTIPkOljySaHs
         LklH4Z3bJK8kMFE7u7v9R2vBg2uNde6aoColf4I4KIuUquCQfUYdP07wL68UznfzoIGD
         vfCTrcpvciiJDIKq9REaHsGGP/sXfL0zXGdlE=
Received: by 10.210.33.3 with SMTP id g3mr4031469ebg.82.1240078049766;
        Sat, 18 Apr 2009 11:07:29 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 7sm5272717eyb.50.2009.04.18.11.07.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 11:07:29 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116858>

I am trying to get git to do a remote push, but it is intermittent, hanging 
sometimes, and not working others :-

    Aaron Gray@AMD2500-PC /usr/src/test/gittest/hello-world
    $ git push git://git.***/hello-world
    Counting objects: 4, done.
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (3/3), 557 bytes, done.
    Total 3 (delta 1), reused 0 (delta 0)
    fatal: read error (Software caused connection abort)

Server: F10
        git is version 1.6.0.6
        git-daemon 1.6.0.6-3.fc10.i386

Client: Cygwin
        git is version 1.6.1.2

/var/log/messages :-
Apr 18 18:18:28 *** xinetd[29002]: START: git pid=3083 
from=::ffff:212.19.110.144
Apr 18 18:18:28 *** git-daemon: [3083] Connection from 212.159.110.144:6008
Apr 18 18:18:28 *** git-daemon: [3083] Extended attributes (25 bytes) exist 
<host=git.***.org>
Apr 18 18:18:29 *** git-daemon: [3083] Request receive-pack for 
'/hello-world'
Apr 18 18:18:29 *** xinetd[29002]: EXIT: git status=0 pid=3083 
duration=1(sec)

Aaron
