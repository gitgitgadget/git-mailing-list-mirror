From: Tim Visher <tim.visher@gmail.com>
Subject: Error Building 1.6.2.2 on Cygwin
Date: Thu, 9 Apr 2009 15:10:30 -0400
Message-ID: <c115fd3c0904091210u398ea4bag62eac3a6deaffa5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrzfW-0001R3-Fo
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 21:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765955AbZDITKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762092AbZDITKc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 15:10:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:34012 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbZDITKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 15:10:32 -0400
Received: by yx-out-2324.google.com with SMTP id 31so789881yxl.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=w4wSaVRqERDtQ9auJ/aoRAwbxs4lnt8kH6CL3vRuF7w=;
        b=qWfbT0qaUYPdi+YKr2cR9KYnOwrAsgeny4CXkie4KsdPgAhwaf51OmeHdjgbqgk9At
         cuDsqzRfpubv7iwAMrhrR71PDzupNFpj9p1W0BdmRnXTArElzuzhVsiyLioJVfUD846H
         io/KA20GLpFtVbkk3Ljik0JZG7ip8GmrcUVMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JXFmFyiLJfU6S5HiKEzPzzDmiCXLVPpKhkb6fMKLCKev0FGiC0tskuIkrFGwnaRJJH
         dbejHbsKMzWZDJk2YAHZY4Dd3lp7AUjHiTsI0NQT7G3SRv7tdkIKFTm2qioMPUI41dps
         EIOc5pzRx1Olz9NFu0OUIR0xV8aqgJQN4UKx0=
Received: by 10.100.152.19 with SMTP id z19mr867152and.16.1239304230178; Thu, 
	09 Apr 2009 12:10:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116199>

Hello Everyone,

Trying to build 1.6.2.2 and I'm getting the following error.

    LINK git-fast-import.exe
    cc: unrecognized option `-pthread'
    /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../i686-pc-cygwin/bin/ld:
cannot find -liconv
    collect2: ld returned 1 exit status
    make: *** [git-fast-import.exe] Error 1

Thoughts?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
