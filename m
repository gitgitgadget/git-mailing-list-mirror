From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: Confusion using git on svn server
Date: Sat, 20 Jun 2009 22:26:23 +0200
Message-ID: <4A3D45EF.1000704@etu.unige.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 22:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI79n-0004n6-Jb
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 22:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbZFTU0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbZFTU0Y
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 16:26:24 -0400
Received: from mail-fx0-f214.google.com ([209.85.220.214]:36066 "EHLO
	mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZFTU0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 16:26:24 -0400
Received: by fxm10 with SMTP id 10so277637fxm.37
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=pw4TcVuyRQGZ+OcPSiiu2Yn/EIm5f47FSQGcLQ0CzS8=;
        b=gWKzLXum0yyIQfynyHCAgglQJ42bO83hjbp3WAr04yBUynIvV3m2NVezFitgadwLHM
         FJLvEMnm/bC1evDqc7L67j0OeS3y2YF5DfvJq64kI4ClBUKrDnjvpL/bXXk/H3/g2ZiC
         vcGa8V44370worEcCeDld48gKfFP98ZK63EMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=sH9eXGIvvHhAi68ISSF2rKWkhyEusqolvkodGyDh3gmLoN7NTPqYq5OC5zAeDeTUwQ
         aXXILCObM3EVIt/FNhSd0Z/cEmjl0D54Pmiq2M226BzgjrFDzg5IB7Nt2DI545ODwkUS
         IHHpBspzCbA99I628UsTTx2w3gw68R+MfLhbA=
Received: by 10.86.93.17 with SMTP id q17mr4552021fgb.75.1245529585860;
        Sat, 20 Jun 2009 13:26:25 -0700 (PDT)
Received: from ?192.168.1.4? (adsl-188-155-122-1.adslplus.ch [188.155.122.1])
        by mx.google.com with ESMTPS id e20sm3457364fga.5.2009.06.20.13.26.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 13:26:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121953>

Hi

I just began using git on a svn file, which seems really nice. I'm for 
now confused with a git operation, as maybe my mind is still thinking 
with svn vision.

As I understood, unlike svn, you can make many commit without sending 
them to the server, and then then sending them in one block with git-svn 
dcommit (if I'm right, with push if git server).

So two questions:
-Where can I find documentation on that? Didn't find mention on it in 
git user manual or git-svn crash course.

-say I want to know, before doing git-svn dcommit, which commits will be 
sent, and if this will do a conflict... is there a way to check that 
before sending the commits?

My main concern is that in my git log, I have a commit and its "revert", 
will it be sent as two different commits to svn? I would love they are 
not sent at all as they represent a "neutral" operation.

Thanks a lot!
