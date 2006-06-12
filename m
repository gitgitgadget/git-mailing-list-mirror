From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-diff --cc broken in 1.4.0?
Date: Mon, 12 Jun 2006 16:32:45 +1200
Message-ID: <46a038f90606112132jaf33a25x5794a19db2a06d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 12 06:32:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpe6b-0003go-F4
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 06:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFLEcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 00:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWFLEcr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 00:32:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:53877 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750720AbWFLEcq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 00:32:46 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1072084wra
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 21:32:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cwcJJ9aPM5TRkKzjcv9uiDTHL+uc6HUtbroZWE9mXcNUggJadguTstiv2o8Aln7iJoEHhHma86VG7XfywG7tyA45C9aRxlz0XY59fU+Ku9GFEDRbJ2mO5EhXOFGIyNyzxBxf5a9LLwUnG6+ONtjDOahOEc8T1kJlPiMvb7A++LE=
Received: by 10.54.146.5 with SMTP id t5mr5176578wrd;
        Sun, 11 Jun 2006 21:32:45 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Sun, 11 Jun 2006 21:32:45 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21689>

I was looking at some merges in gitk and lamenting the apparent loss
of the nice two-sided diff we get with -cc, and now duting a slightly
messy merge I did git-diff -cc only to get...

$ git-ls-files --unmerged
100644 f1d3843b2b2e42ba78adcf37da6440f0d321852e 1       local/version.php
100644 9352efa45cd25d9ad58df12b4ac241ac226a8ad4 2       local/version.php
100644 50da9b47903f6179f55a3f44290e7feaa08342f4 3       local/version.php

$ git-diff --cc
diff --cc local/version.php
index 9352efa,50da9b4..0000000
--- a/local/version.php
+++ b/local/version.php

cheers,


martin
