From: Stepan Koltsov <stepan.koltsov@jetbrains.com>
Subject: bugreport: stgit cannot export empty patch
Date: Sat, 19 May 2012 00:57:56 +0400
Message-ID: <CAPk5vtzpUHgL_dfJLJHgKsaNPZodx1jbTRQpRdoj01RRPRoBfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 23:04:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVULt-0000l8-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 23:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967449Ab2ERVEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 17:04:41 -0400
Received: from mail1.intellij.net ([46.137.178.215]:60744 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967372Ab2ERVEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 17:04:40 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 May 2012 17:04:40 EDT
Received: (qmail 28337 invoked by uid 89); 18 May 2012 20:57:58 -0000
Received: by simscan 1.1.0 ppid: 28304, pid: 28328, t: 0.1207s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO mail-gg0-f174.google.com) (Stepan.Koltsov@jetbrains.com@209.85.161.174)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 18 May 2012 20:57:58 -0000
Received: by gglu4 with SMTP id u4so3277941ggl.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 13:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=agBPSBHE/ZJVbv5OhWfSvIrbunVTfTsBLxmi+oHUsL8=;
        b=cYvCwqt0qJSvMLn1o7OwC44V5Nrm3Du8z09NyNyvDROJ0m05al5pMvxGlSWgWCdpyD
         77ITB1iouiDPgim4HT6AbtReK7kBPbAJN+zpM/G9+UJD8p6kOdyhEvfrYo6hClVpdFQ0
         1vmZPulFZlvktH+Cu2459HlR3mT8YTD5TNtYfTgN9Ad7FPcoycaa81rDsVXO16/O2H+x
         9D5lJM2zRi3NTvmvof1xDemglN24STtilw427RQnD3n4REHdMMtqJiC0ruQFc4Mn+OUx
         OCTq6K5CoznlUqAy7B0Q5c4Pzlv/g/MXBLm/p2tjbCONiNu+WM6S+ffrPqd1bG3QxFws
         Io8w==
Received: by 10.236.108.199 with SMTP id q47mr13604182yhg.76.1337374676668;
 Fri, 18 May 2012 13:57:56 -0700 (PDT)
Received: by 10.147.115.3 with HTTP; Fri, 18 May 2012 13:57:56 -0700 (PDT)
X-Gm-Message-State: ALoCoQmtnGDeOaIo56XKoAD+kO/AijVtzMxSrzu3TRxv1Cmlc92Ua1npnaf4pnQztPAff4S3zk9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197972>

Hi.

stgit fails to export empty patches:

% stg new empty-patch -m 'asasas'
Now at patch "empty-patch"
% stg export empty-patch
Checking for changes in the working directory ... done
fatal: unrecognized input
stg export: git failed with code 128
zsh: exit 2     stg export empty-patch

% stg --version
Stacked GIT 0.16-3-g67cf
git version 1.7.9.1
Python version 2.7.1 (r271:86832, Jul 31 2011, 19:30:53)
[GCC 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2335.15.00)]

-- 
Stepan Koltsov
