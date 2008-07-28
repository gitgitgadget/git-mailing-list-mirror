From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: short log and email address
Date: Mon, 28 Jul 2008 14:06:06 -0400
Message-ID: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNX7m-0001jC-QP
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbYG1SGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYG1SGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:06:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:51969 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYG1SGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:06:08 -0400
Received: by qw-out-2122.google.com with SMTP id 3so266422qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Z/WZq59UN7UzUKsULp+uDxse51VUERL9293xr4lmb+Q=;
        b=TGC9lCh0oCYnbxBIaRKwbAous93nvRFRs5htwUkydKpEcpvvlkCO1e4vIgKzhiyq4N
         xHGzFj58j1HWeHdxWtHXqMAefqke2FbzqzgnMiln7E7Uq/4xmb1HPnxJzNUM+2X6qh/t
         MxJe1DnftabntibJwfbO1iQjZK+mtB6T03M+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=prs4XEjADPM+t7TgsnUwRVL8rABf4qQOBOp8ImgEkaShhVQvg/yY2q0GbcfLkG1q26
         1GPzcqrZRUwKBFeYDYuurE2BhUmYbtmvAqII9YW6g66O/LSAYNCuCw/1w2hC1dzP0UdI
         9Gtys+xihOhWczVLpgws2Q4kPmt2l88DcEan8=
Received: by 10.214.215.4 with SMTP id n4mr130776qag.35.1217268366637;
        Mon, 28 Jul 2008 11:06:06 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Mon, 28 Jul 2008 11:06:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90478>

Using the -e option in shortlog changes the results by spitting things
out by email address instead of leaving them combined  by name. That's
probably not what you want. Instead you want everything combined by
name and then display the most recent email address used.

Is there some way to fix this for the future? Maybe use Reply-to:
instead of From: on email import?

   998	David S. Miller <davem@sunset.davemloft.net>
   689	David S. Miller <davem@davemloft.net>
      6	David S. Miller <davem@huronp11.davemloft.net>
      5	David S. Miller <davem@hutch.davemloft.net>
      4	David S. Miller <davem@bnsf.davemloft.net>
      2	David S. Miller <davem@t1000.davemloft.net>
      2	David S. Miller <davem@ultra5.davemloft.net>
      1	David S. Miller <davem@goma.davemloft.net>


-- 
Jon Smirl
jonsmirl@gmail.com
