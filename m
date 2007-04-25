From: Andy Parkins <andyparkins@gmail.com>
Subject: git-ls-files -m lists the same file multiple times
Date: Wed, 25 Apr 2007 10:35:26 +0100
Message-ID: <200704251035.33713.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 11:35:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgduZ-0001hv-2c
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 11:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992485AbXDYJfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992486AbXDYJfj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 05:35:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:23975 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992485AbXDYJfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 05:35:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so382259uga
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 02:35:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ajh007IbT321Iw6Hx2hK1N+KqS6owfJEaWXXVPrpxgelPbPj82XYnf6afNY8Sz3aVbLsnbI9fVw/t1ogxLbv3UQqp73ntjHKlB9ZwI7s8SFQCUdYevxVEzDf6Youynz98SIJvZTziG0INrAd0DqU1RZye+r2jkZnyOFLZFeJHnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HaVWBMJo81NDqvFKftNEPJa81glFbYfEvdRHYEihpUkazvrXzF3Bik18AVXNofugyHeICHrqI/Eq+Cp9gJIVylFsiz2C85XNKk4KNQE88x1DRIiqqaEIAE+jXkNyowPe5MjGNeR5WDwyOLF3cK3GHNfcinTuv7slNQW51CLwCQg=
Received: by 10.67.105.19 with SMTP id h19mr1280558ugm.1177493737051;
        Wed, 25 Apr 2007 02:35:37 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id 5sm2250375ugc.2007.04.25.02.35.36;
        Wed, 25 Apr 2007 02:35:36 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45516>

Hello,

I did a merge, which had conflicts, and then fixed the conflicts.  To see what 
files I'd changed I did git-ls-files -m.  This listed the same file multiple 
times.  Some of them twice and some of them three times.

I guess that it's showing different stages; but as the list is just filename, 
there is no way to tell which is which and it is just confusing.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
