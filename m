From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: performance on repack
Date: Sat, 11 Aug 2007 17:12:24 -0400
Message-ID: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 23:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJyGE-0000e9-En
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 23:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031AbXHKVM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbXHKVMZ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 17:12:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:51205 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756661AbXHKVMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 17:12:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1323397wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 14:12:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pMNLxLB+VYKYAmEWJ8110TM5gLsXGyIhed1VXpH0q4lnf3oIzWeDQgLBm+4bnQ2Wbc8ogveAs5Tl9/pTWSuaJvoqoJHHljwpi1p7fz13xlrXWV9AvrT37dmtluTkOZUGHqc/jWSRvSEfppPcxjQo/PABelWb8KBqW7Htka6jH90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KNJPNVQ2mWzXt8BJJ/zbONosniCoBHAEs3eLLMSRCCK70H31DCD59y5ynDr/gIvHA4X+orLHa18TnYSXZW4/X//TvWRtZv8HgPYLAkOR1w9+GPlBvFCGgnLSkrXaEYrjLPolT0uHhDLWL5tJARgvLZUzMGe0shXLybSvkJcxqrc=
Received: by 10.114.152.17 with SMTP id z17mr276348wad.1186866744553;
        Sat, 11 Aug 2007 14:12:24 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sat, 11 Aug 2007 14:12:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55634>

If anyone is bored and looking for something to do, making the delta
code in git repack multithreaded would help. Yesterday I did a big
repack that took 20 minutes and it only used one of my four cores. It
was compute bound the entire time.

Dell had 2GB quad core boxes on sale for $620 last week. I just had to
buy one. I'm surprised, it's quieter than my old P4 box.

-- 
Jon Smirl
jonsmirl@gmail.com
