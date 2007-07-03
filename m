From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: git-svn failed on apr
Date: Tue, 3 Jul 2007 17:05:01 +0800
Message-ID: <4b3406f0707030205g3521cff5p1d5150b6a81af51b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 11:05:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5eJm-0008Ob-Lb
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 11:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbXGCJFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 05:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755771AbXGCJFD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 05:05:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:31270 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbXGCJFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 05:05:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1738866wxd
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 02:05:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lgVtasDH9grGzOSyfhjKE6FBgWYCpFhp3HYTwXY6DcAR4AtOqWiHpi9ZQVkVWkhHfOW5EH/22ITuqBlW2YTmzKNHfGQ1MuzjNrjhAGAn/f0MkMZaDJH395UUyboPgX1eOEBaqc47iU98NIdurNCGvN9pq2F/fDpKlq7QXxN/zkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TjD+dhKIrPFlCkToMxz3FITk8pnkBepX+fUeJPWAZIjzqOkerX5h16QXbRxV08NaJJp/m3V7avTs8RhCQDGYM/nMIAhADPQESGRL2G1O6IOp3Gg7RaU2CWEm8rY67NBJepYGkzjYafg607S+vLU/fqpDL9vk+c5YDLSOJ3bSy4g=
Received: by 10.70.103.12 with SMTP id a12mr4947580wxc.1183453501065;
        Tue, 03 Jul 2007 02:05:01 -0700 (PDT)
Received: by 10.70.43.18 with HTTP; Tue, 3 Jul 2007 02:05:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51469>

[ ~/wc/git-svn]$ mkdir apr
[ ~/wc/git-svn]$ cd apr/
[ ~/wc/git-svn/apr]$ ls
[ ~/wc/git-svn/apr]$ git-svn init -T trunk -b branches -t tags
http://svn.apache.org/repos/asf/apr/apr
Initialized empty Git repository in .git/
Using higher level of URL: http://svn.apache.org/repos/asf/apr/apr =>
http://svn.apache.org/repos/asf
[ ~/wc/git-svn/apr]$ git-svn fetch
W: Ignoring error from SVN, path probably does not exist: (175002): RA
layer request failed: REPORT request failed on
'/repos/asf/!svn/bc/2200': REPORT of '/repos/asf/!svn/bc/2200': 200 OK
(http://svn.apache.org)

What's wrong?

---
Dongsheng
