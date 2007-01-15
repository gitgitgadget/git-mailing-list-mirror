From: Andy Parkins <andyparkins@gmail.com>
Subject: Commit signing
Date: Mon, 15 Jan 2007 10:00:57 +0000
Message-ID: <200701151000.58609.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 15 19:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vi3-0006cL-GA
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:27 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9U-0003eK-QJ
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXAOKBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbXAOKBF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:01:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:63673 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbXAOKBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:01:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1304907uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 02:01:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZuFo5JTRpkT6aXxoddBR0Kktl03kE1jVBCAQjXfylNNgfMU9PHi0s0GbZz3CGQE96Khg2KyG8tgcx8DDIZTJVHoNSVR8ADuBH9Wlun2o5ins2rEyoEi6NZIixEZBpuB8evScE6lcYETACOK2SiJ4r238fvMU49nA/r1iU2TJfS4=
Received: by 10.67.97.7 with SMTP id z7mr5130556ugl.1168855262930;
        Mon, 15 Jan 2007 02:01:02 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id o1sm5299385uge.2007.01.15.02.01.02;
        Mon, 15 Jan 2007 02:01:02 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36810>

Hello,

I was just talking to another developer in my office about version control.  
He's working with Windows so has chosen Monotone for a version control 
system.  I didn't have any huge objections, as I'm sure monotone can be 
migrated to git without much trouble (they look to support the same features 
from my brief reading).

Of course my favourite is git, but we were talking about the certificates 
needed by monotone for each developer.  I assume that monotone therefore 
signs every commit.  It obviously crossed my mind as to how one would do that 
with git?  We obviously already have the ability to sign a tag, but is there 
a way in which one could sign every commit.

The more I think about it, the more it could be a reasonable question.  In my 
own repository I can obviously create whatever commits i like, claiming them 
to be from whomever I like just by altering a few config settings.  If I put 
a few of those in my own repository and then managed to persuade Junio to 
pull from me - wouldn't I have faked commits from another developer?  
However, I wouldn't be able to fake a gpg signature.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
