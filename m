From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: [git-p4] Can't submit: Something I do in a wrong way.
Date: Thu, 20 Nov 2008 00:00:13 +0300
Message-ID: <49247E5D.7070601@gmail.com>
Reply-To: lolkaantimat@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 22:02:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2uC6-00079S-9W
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 22:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYKSVBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYKSVBW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 16:01:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37734 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbYKSVBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 16:01:21 -0500
Received: by ug-out-1314.google.com with SMTP id 39so91246ugf.37
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 13:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=LGT5N6lSB6btNUPc2/74a7MEgvmtQCUxIdrPCUzRLQk=;
        b=AXfTE9gQRUXu0ztPq9+ZcIuxhT6jWzOlZ9lxNU9muDdA01AJ6oQARz+eEnE4Zt0t5A
         25/ybpr181sDB1gnNWxTcFzGJZlKnXFAReM6z6Ml/KnYylyJoreW3mysYavA/mFIm8Ap
         rY9rDojtL+0T4bI2NCAUrjccpHEZTblC4phgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=O1+GuBzkYsfKUEaX4fXpC/c0D+XHRawdk+Wla+R/0ryZtmUnYnPXuJmBwTMckGdrNj
         cL+NiPCkwX4aISaTFmK4gfXtDBNG7ysrPkOCwZHdDdRtc3NgLTd6sxzcEOPr8ShqyIGv
         N9ZvWFS8GQIoCz+YTvwT4catPDM1kV1PRUKIQ=
Received: by 10.86.91.12 with SMTP id o12mr991488fgb.16.1227128479535;
        Wed, 19 Nov 2008 13:01:19 -0800 (PST)
Received: from ?93.81.248.228? ([93.81.248.228])
        by mx.google.com with ESMTPS id 3sm1515439fge.3.2008.11.19.13.01.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Nov 2008 13:01:18 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080922)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101376>

Hi list,
I need a help with git-p4.

There are //1, //2, //3 in perforce's depot, and /dir1 is a client's root.
So:
Root:   /dir1/
//1/... //client/1... etc
I've checkouted //1, //2 and //3.

In /git I did "git clone //1; git clone //2", So I have /git/1, /git/2.
Now I run in /git/1 "git-p4 submit commitBr" and choose 'y' to sync,
where comitBr has one more commit than master.
I get "Path /git/1/... is not under client's root /dir1/". Without
syncing it says I have opened files, but when I do in /dir1/1 "p4 -a
revert" I get: "file(s) not opened on this client".
Looks like "git-p4 rebase" works fine.

Also I tried to keep git in the same dir as perforce workspace: I did 1
commit and then failed to do anything, because got strange conflicts.


P.S. Please don't forget to keep me in CC :)


-- 
Cheers, Evgeniy.
Key fingerprint: F316 B5A1 F6D2 054F CD18 B74A 9540 0ABB 1FE5 67A3
