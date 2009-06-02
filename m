From: JiHO <jo.lists@gmail.com>
Subject: Issues with file status over samba
Date: Tue, 2 Jun 2009 11:11:43 +0200
Message-ID: <3A1A5212-FFB4-4B0D-A972-C90EA336F5D9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 11:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBQ8m-0004Il-HD
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 11:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333AbZFBJS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757321AbZFBJSZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 05:18:25 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:52315 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259AbZFBJSX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 05:18:23 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2009 05:18:23 EDT
Received: by fxm12 with SMTP id 12so6344724fxm.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=8Q0s306ZRC0uIxNltSUsoj26m8tAmn/ntKRu49h53z8=;
        b=mEvSkkjCKbt/E0yo4/EYN3X6hD3am66LOakXr7+lyhx8bR2bljsbLqOVeh/VCrobjI
         dZBrpvPHvhkIBlBcaO8ypQfHjyGotdCtMVc4IGLq3fjY/8hmn4N8uSnsEv2o6JVrmWxR
         YwvoKFJEOaQ6Dgrx+E7trdR3uzSaPNG4U3NAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=tr9RDEUcqMt6LPEGxBZ35/VQSQvYackm53Ffr/NLTrEiMKAlOM4+G5XcFYOX42lRVY
         0pZ4xfZW0ZANQG3FdUJ3AZvZkMohr2ThB/8kCmGc+TDAtvGrAPQMDzNuiWhhQsGJnvKA
         QCjxrP5q6StJHH1hqN7vRP+3+N0HPZQEU+5GU=
Received: by 10.102.215.1 with SMTP id n1mr3821426mug.57.1243933907505;
        Tue, 02 Jun 2009 02:11:47 -0700 (PDT)
Received: from ?192.168.1.173? (chercheur-ephe01.univ-perp.fr [194.167.139.32])
        by mx.google.com with ESMTPS id u9sm4148124muf.37.2009.06.02.02.11.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 02:11:45 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120498>

Hello everyone,

When working on a git repository on a mounted samba share, I am having  
trouble because some files are detected as changed while they are not.  
git status works OK but git GUIs (git gui and gitX on mac OS X) show  
the problem.

The issue was initially investigated through gitX and the bug report  
is there:

http://gitx.lighthouseapp.com/projects/17830/tickets/147-wrong-status-over-samba

Please let me know what I can do to test this further and help fix  
this issue.

Thank you very much in advance. Sincerely,

JiHO
---
http://jo.irisson.free.fr/
