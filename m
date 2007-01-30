From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: How to enhance merge commit message ?
Date: Tue, 30 Jan 2007 10:32:24 +0600
Message-ID: <200701301032.24917.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 05:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBkfl-0001mw-TT
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 05:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXA3Ech (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 23:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbXA3Ech
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 23:32:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:60973 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbXA3Ecg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 23:32:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1435363uga
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 20:32:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xcn8M8e0+zP+9InF0QYueHH/v9m09tDat4nmvMtSygpePVUR0nkw1qvYPyLzcKbYTI9Kw5NdFHmhbMy0lVycYjU+3GGIeewqEJlJ64naggryAQC5y1bIyWSzW8TAAQAjIuA5Iz7CJv/fjfj24BWRSjQ+CvDTp1ihlcM9bb6vzYs=
Received: by 10.67.119.9 with SMTP id w9mr9591496ugm.1170131552859;
        Mon, 29 Jan 2007 20:32:32 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 20sm7959352uga.2007.01.29.20.32.31;
        Mon, 29 Jan 2007 20:32:31 -0800 (PST)
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38120>

Hello list,

git's git repo contains a lot of merges with nice commit message, 
like this (d96497b8d):

Merge branches 'jc/merge-base', 'sp/merge', 'jc/diff', 'jc/explain', 'jc/web' 
and 'jc/pickaxe' into pu
    
    * jc/merge-base:
      Teach "git-merge-base --check-ancestry" about refs.
      git-merge-base: --check-ancestry option
    
    * sp/merge:
      Avoid git-fetch in `git-pull .` when possible.
    
    * jc/diff:
      test-para: combined diff between HEAD, index and working tree.
      para-walk: walk n trees, index and working tree in parallel
    
    * jc/explain:
      git-explain
....

How can I made the same messages using git pull . <branch> ?
