From: "Michael J. Cohen" <michael.joseph.cohen@gmail.com>
Subject: git-svn doesn't like !! in the url
Date: Mon, 7 Jan 2008 02:10:49 -0500
Message-ID: <EA596F68-D87B-49AD-9DEF-2C2E07127BDE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBm8q-0004HG-5e
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 08:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbYAGHK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 02:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYAGHK4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 02:10:56 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:15554 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbYAGHKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 02:10:55 -0500
Received: by an-out-0708.google.com with SMTP id d31so1351493and.103
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 23:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=PBPlwRdMmB+qDvR707KGWBkflT66i68rRsAMb8rFnE8=;
        b=bDqLAdJEgjqOATbW3ocbMa25RKTCIRvlZF1nPJYSjtSmEvpACC9FSRz+QJ0UcIuaZWI3j61RCqrGSLURgP/BhBAZ/dxrBzHgRzW9a34dRaiUpbQVkPdWBx9gVSzz3RbT/nToTgNnpozsddgBg2+sF9KL4QzE6euOLgDZrFbS5jE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=UwHnfdIpg6z8gkwaGAwRjCj9Ym2Pa8rtmghnmtl/hFWuropf4daoQRWY3vQv8DXMZ4NKZFIjJEUxdUK9r0iksiq6flpAicm+f/WVAx+yaUMn0y84V/IluuK038YrznGCvyo+CRQLeeTpWs5uh91u/xMwvOjPcJDH19rM2pRtmfM=
Received: by 10.100.202.9 with SMTP id z9mr41894871anf.42.1199689854148;
        Sun, 06 Jan 2008 23:10:54 -0800 (PST)
Received: from www.ipslut.net ( [71.196.112.35])
        by mx.google.com with ESMTPS id a13sm24731053rof.9.2008.01.06.23.10.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2008 23:10:53 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69767>

I think it needs to urlencode the items before it passes it back to  
the server.

W: Ignoring error from SVN, path probably does not exist: (175007):  
HTTP Path Not Found: REPORT request failed on '/wowace/!svn/bc/100/ 
trunk/!!!LeaveMeAloneLibraries': '/wowace/!svn/bc/100/trunk/!!! 
LeaveMeAloneLibraries' path not found

works fine with svn co.

-mjc
