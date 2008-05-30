From: Lea Wiemann <lewiemann@gmail.com>
Subject: perl/Git.pm: Writing a test suite
Date: Fri, 30 May 2008 09:43:48 +0200
Message-ID: <483FB034.3050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 09:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1zI8-0006SK-RI
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 09:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbYE3Hn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 03:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYE3Hn4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 03:43:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:16742 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYE3Hnz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 03:43:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so61792fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=p194bfx6AdihSKccv6hYV7s2Klpd5YX6yMcPWXrkF6Q=;
        b=spQARGlH6L8/xiZZ5pmxHihHGd14fp6F4BEvKMosUA5hZAv35QNi1l48NCW0j2efxp7IZTVFlbSipadP2D/1kKSqipibACFqbd6eHDQLLlADOWRQipFrTndcYtUzYpgVndbuu2kRnel9l+NTV/JTvFv1+n4A1K32D0Ys8a1ywOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=SLohWnJOBVRkUqLPvf93AWZTekgHnjpnGmbfjGoFPqR3So59zngwPxcFQkUM9LY4req0ty9GdtLj8eBajD6hMeMa6/9nqGV4yn/PJYBPZa02XK/+ERT3Pwlzqxzuhs6BHHODYP3HBeWW2OGiOX0/cJSHcqobonMMPbXvXmGC7PQ=
Received: by 10.86.77.5 with SMTP id z5mr629113fga.47.1212133432150;
        Fri, 30 May 2008 00:43:52 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.225.53])
        by mx.google.com with ESMTPS id d4sm224942fga.4.2008.05.30.00.43.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 00:43:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83272>

Git.pm doesn't currently have a test suite, and I think it should get one.

Since Git.pm makes calls to the git binary, it would seem sensible to me 
to create mock output for the external calls, like Grit (a Ruby API) 
does it, here: http://github.com/mojombo/grit/tree/master/test/fixtures 
  (Having a complete test repository to test against like Ruby/Git 
(another API) at 
http://repo.or.cz/w/rubygit.git?a=tree;f=tests/files;hb=HEAD is probably 
too brittle and makes it hard to test edge cases.)

I haven't done testing in perl before, so if someone wants to exchange 
ideas and/or help me get this set up, please post here or message me on 
IRC (lea_w/lea_1 on #git at Freenode).

-- Lea
