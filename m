From: "Johnny Lee" <johnnylee194@gmail.com>
Subject: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 15:00:52 +0800
Message-ID: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 08:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK5xX-0000kX-0a
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 08:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbZAFHAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 02:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZAFHAx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 02:00:53 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:57152 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZAFHAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 02:00:53 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8011055wfd.4
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 23:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=vaRWgvSi0+VKBLu6+7u09U7TUCOqGwla92cValG1vao=;
        b=JWG0w6OY6zQnL5GiwLMNPhsCFO2XeFDPzBy0Tl2VbMP+/vTeJrK8+jGWCeep1FiflC
         scw2JQ7e4OfPvCQrqqlHZzV6qQXBDXWPQD8OFCq47Atm1eWJqbSeE8hTFYH5YG7fxrdb
         DWwNbp8CJ6UIZJsMKAAyX5yopdmvIhaUCgjMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=j7ayBpQP7qLy5whWTFQ9I6wfhLEGM7/Vm0D+cCkoblypycdaNunOQdqoBK11Sh2Ybz
         fJ+IMHj2xa+wB1KGDdBmtWE+KWvs35ayUpKQ4OnsCiZ1QvpEGDfcAWngw0wdR+DqQg5x
         uQUmw+29zd4zkO0L/FF1P3waadm6A7e+EGLJ4=
Received: by 10.142.139.14 with SMTP id m14mr9036731wfd.100.1231225252463;
        Mon, 05 Jan 2009 23:00:52 -0800 (PST)
Received: by 10.143.15.1 with HTTP; Mon, 5 Jan 2009 23:00:52 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104641>

Hello Everyone,

I'm new in git, and when I was practicing the tutorial:
http://www.kernel.org/pub/software/scm/git/docs/everyday.html

I've had a problem when using "git gc"

Here is the log:
git@tomato:~/golf$ git gc
Generating pack...
Done counting 121847 objects.
Deltifying 121847 objects...
 100% (121847/121847) done
Writing 121847 objects...
 100% (121847/121847) done
Total 121847 (delta 62587), reused 121184 (delta 62253)
Pack pack-44320b247756067835f5e4a789c7eb5bcc5266c3 created.
error: unable to unlink .git/objects/16/b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe
error: unable to unlink .git/objects/a1/f6672f6e5bd90acf16a43fea774ca655a3ab1e
error: unable to unlink .git/objects/a8/5cca5b91cf77e8df731827849308ef6dae4536
error: unable to unlink .git/objects/ae/64c9d0ea558e403acf139f690c804212d490be
error: unable to unlink .git/objects/b3/a4c72ea70a3bb43b1819a0a74268870849a21d
error: unable to unlink .git/objects/db/5ec507a2ed86169e4a31bba1d95067c4f3fac4
error: unable to unlink .git/objects/ef/65ed2454b8dcbf8837595d8881ca42898a491c
error: unable to unlink .git/objects/fb/92c37ccc8bdbf3c70bc3afaf8261cedbc92d71
Removing unused objects 100%...
Done.

While I'm looking at these "unable to unlink" files, it seems they are
read only:
git@tomato:~/golf$ ls -l .git/objects/16/
total 4
-r--r--r-- 1 johnny johnny 26 2009-01-05 09:25
b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe

Is there anything wrong here?

BTW. I've used git fsck with/without --full, it works fine and no
error is reported.

Thanks for your consideration,
Johnny

-- 
we all have our crosses to bear
