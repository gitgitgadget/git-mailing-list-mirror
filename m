From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: Confusion using git on svn server
Date: Sat, 20 Jun 2009 22:28:21 +0200
Message-ID: <4A3D4665.9040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 22:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI7BF-000594-Ee
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 22:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZFTU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbZFTU2W
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 16:28:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31679 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZFTU2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 16:28:22 -0400
Received: by fg-out-1718.google.com with SMTP id d23so296153fga.17
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=pw4TcVuyRQGZ+OcPSiiu2Yn/EIm5f47FSQGcLQ0CzS8=;
        b=nLXkmiDKSg6Ze5vGJFkJ/3uZKntr3kV4KCW5P/xA12DkrNFTQPssNoBoeiPqBago9+
         GsIc5e6TfoVfmjP820Zyb8LCGmV3OkuxtbuEKEipzjIGUheY4MfiZzB6TPaqLge9fdgh
         PqJGNBeVfli6GL22xeUPNptAOleNRKly75giI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=O8mbd6VBmPmeVNTGx/z5dPrEZuEYKYgOEvWQ+udfXyiGOpDFDktwh4M2OyeRtrF/Yh
         SlDb5+bMAi0/fxHrTKqXvJLPlseNl1hEKOgNH1lc1qHlwAuabpijvPebgeJtdOlzuB5f
         XJu/YVpnf6VPZjwtElvaHUopInbWk94UIGPO8=
Received: by 10.86.91.10 with SMTP id o10mr4624234fgb.13.1245529703868;
        Sat, 20 Jun 2009 13:28:23 -0700 (PDT)
Received: from ?192.168.1.4? (adsl-188-155-122-1.adslplus.ch [188.155.122.1])
        by mx.google.com with ESMTPS id e20sm3450015fga.0.2009.06.20.13.28.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 13:28:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121954>

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
