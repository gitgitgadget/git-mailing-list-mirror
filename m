From: Cristobalito Cristobalito <cristobalito79@gmail.com>
Subject: Bug Report: Minor bug in contrib/fast-import/git-p4
Date: Wed, 25 Aug 2010 23:20:05 +0100
Message-ID: <AANLkTimg=0bEGrn6Vy6a3WTx5S1Cjk+JW7jZJthFN3HD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 00:21:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOLE-0006w4-IG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab0HYWVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:21:02 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60638 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab0HYWVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 18:21:00 -0400
Received: by ewy23 with SMTP id 23so783433ewy.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=9dq4z0D4AVBRXxztOcEk4iDQJjLQPq3n/OcnP7s9rNI=;
        b=msVpN79uGtopWvFsnnzV21SkPyYqjKQ5Ske02GsMcEo2GK83nYLAOF4jCGSqm7n0qm
         fniZ9VUyhR4Vvc3Q9TNeaPbGoRtEfiIyKHPHkhmZNCMJhQqlmHhQZaJv7nOwKCeEcqu9
         HSfR8b058sRGi4gceWejEa5ND2jwhBwiUCcII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UGLSopdPV5HyNk6SXRmnN+H6+1F092hMC1uQAMWpkZJ4Oc6zywVauAPwH2HZ1XytPQ
         mHOAM4Jhu2UX6T87cOi/c2VICDYn/b2ilX7Blcnb/IXCbjrsFrRa+keZdhq+ngak/3RU
         UF2+2g3Oj5+oa/wS6OSf+9VfWF36WVGhzAAi4=
Received: by 10.213.3.73 with SMTP id 9mr6444120ebm.6.1282774805377; Wed, 25
 Aug 2010 15:20:05 -0700 (PDT)
Received: by 10.14.24.84 with HTTP; Wed, 25 Aug 2010 15:20:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154488>

Only a very minor change and I wasn't sure how to submit an actual
patch but I've copied the diff and local commit message below.
Hopefully someone can commit the change on my behalf.

Thanks,

Chris

<PATCH>

As specified in the perforce documentation
(http://www.perforce.com/perforce/doc.current/manuals/cmdref/o.gopts.html),
the host is actually specified with a capital 'H'. The small 'h'
displays the help message.

-------------------------- contrib/fast-import/git-p4 --------------------------
index c1ea643..d89d06c 100755
@@ -38,7 +38,7 @@ def p4_build_cmd(cmd):

     host = gitConfig("git-p4.host")
     if len(host) > 0:
-        real_cmd += "-h %s " % host
+        real_cmd += "-H %s " % host

     client = gitConfig("git-p4.client")
     if len(client) > 0:

</PATCH>
