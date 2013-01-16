From: Timothy Kretschmer <timothykretschmer@gmail.com>
Subject: Unable to convert a subversion repo to git
Date: Wed, 16 Jan 2013 09:06:58 -0500
Message-ID: <CAO2=c4nr8PsbHmyKptWewQMmpqWP=YasKZSnCuB9CCkExpSF8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvTeX-0000AE-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 15:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab3APOHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 09:07:21 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41040 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab3APOHT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 09:07:19 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so2505215iea.10
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=1RfFbB7gj4pxmbLfOAN/96/WIpk6PzOryIezzQAFDOQ=;
        b=aiNgo+u6bGqnsAdEPWVPLWf42L64CgqB4YHZrLb+YS1UBUZkpTGSXt2ptfZ4d5kYNc
         gm0lbs5ndylUdPKWDpTk3TCei7VmcwtLx6Byn4BdhBsqYFRI9djqNjRXu0yjCqcy20JO
         KHVwiFO9V9z8rdUPYhcoXj7MSj/OKKaVB0KVButHlhrBUlweFVoqcVuX8lXv25A21Nox
         l9lbK5zJdKEsX6wklCgrMT3YB8Ep/g6wLSUYcqjGp6cjvmtmIqz/R9F1yRphpIHdQBdT
         l/4iMkqypEqePy9+V8rrkYEGqyYO8vpyV6ttjWyrozSpUZJS6MzoUBgfWHPBsEoO93oS
         dkjQ==
X-Received: by 10.50.216.200 with SMTP id os8mr833435igc.74.1358345239345;
 Wed, 16 Jan 2013 06:07:19 -0800 (PST)
Received: by 10.64.92.34 with HTTP; Wed, 16 Jan 2013 06:06:58 -0800 (PST)
X-Google-Sender-Auth: 0_xaIk1oC5ajdhSyO24CpFM7Piw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213755>

I am seeing the following output while converting a subversion repo to git.

 >Found possible branch point: <repo-url>/trunk =>
<repo-url>/branches/CMT_PHASE3, 18441
> fatal: Not a valid object name refs/remotes/BlueSimViewer 5.0 20110316 Branch
> cat-file commit refs/remotes/BlueSimViewer 5.0 20110316 Branch: command returned error: 128

The command I am running to convert the repo is

> git svn clone <repo-url> -A authors-transform.txt --stdlayout bluebox-git > svnlist

I am running git version 1.8.1.1 on an Ubuntu 12.10 server. I am happy
to provide any other information that would be helpful.

I appreciate any assistance you can provide in this matter,
  -Tim
