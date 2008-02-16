From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: looking for example of following code across files
Date: Fri, 15 Feb 2008 23:41:20 -0500
Message-ID: <57E76010-D0F8-420C-A11D-8884832FD00D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQEsC-0001at-PJ
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbYBPEl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYBPEl0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:41:26 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:32440 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYBPElZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:41:25 -0500
Received: by an-out-0708.google.com with SMTP id d31so207138and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 20:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=VVP6bKoq0h4nS2nhEsXdVzps5JeY6m6GwukvC6ePU68=;
        b=uvJ6JyZ3MW3PBFpC7ajmAYjCVQuOEmtsbq8Izvyt5Td8EqRww/R1Oh8R9C0gv2NzoGNLnfhLo3uZLPiLIdskWR5+laFCsHdj5pSEdqgFzXszrOirlWGprmp4xcZTk5sbqzzP8tjST8Wr/kEsMm6eur41GDkRB3yIqASvN1j2ZtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=cpYzIqyYTscwUQyNx4zEIMOilVWammcbZs5p8Xz07eN4UtXhAFylRRQtwse+K0bvBmv43QwfMXse26GDfcmsik6LtfUl2i12pSDnZyrXszzOJgfj3cAJoVXAzAlQfPOdUxUXsfbff3PzaCGqNSgV01lsTFkki0bJ5HOBMNjaFnc=
Received: by 10.101.67.11 with SMTP id u11mr5462105ank.49.1203136884159;
        Fri, 15 Feb 2008 20:41:24 -0800 (PST)
Received: from ?192.168.1.103? ( [71.126.230.85])
        by mx.google.com with ESMTPS id c53sm10084441wrc.13.2008.02.15.20.41.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 20:41:23 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74007>

I seem to remember that when Linus was giving the tech-talk to the  
folks at Google he mentioned Git being able to follow a block of code  
as it was moved from file to file, but I'm having a hard time finding  
an actual example of how that plays out. I'd love to be able to  
demonstrate this to people but I'm not quite sure of the steps I'd  
need to do to accomplish this.

I've gotten as far as using git ls-tree to track down the sha1 of the  
blob I want to follow, which I'm assuming is the key to making this  
happen but I'm not sure where to go from there. :(

Can someone please point me to an example showing how to go about this?


-Kate=masukomi
