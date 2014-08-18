From: =?UTF-8?B?QW5kcsOpcyBTaWNhcmQtUmFtw61yZXo=?= <asr@eafit.edu.co>
Subject: make profile issue on Git 2.1.0
Date: Sun, 17 Aug 2014 21:35:29 -0500
Message-ID: <CAOUWSGA+6gX8ZBv3Wo8FgUdyd99TYWOybTwGT6ADv_HtNFsFMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 04:36:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJCnv-00013q-7i
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 04:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbaHRCgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2014 22:36:11 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:63855 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaHRCgK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2014 22:36:10 -0400
Received: by mail-yh0-f54.google.com with SMTP id v1so4094494yhn.27
        for <git@vger.kernel.org>; Sun, 17 Aug 2014 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=NchEhR9HgUUXDv2YMW88z4VyMT6icQes2OBgs0OAexI=;
        b=vs/rlI51+9nBEl+iNLE9nJigCEQS0c6xZ3oT0c1hvW9rSqM0rJbJzqQ5K73Ikz1XuP
         sswxikxZ/jc5hSgcqlbYdTqQcbWDCy6Y6nD8e2mhJxx05BPCSiEBvZpD59/LLhhFTpXf
         dMzvSggKBIQU2rq/+Iz8tqMHRSsxjvUv7hfTTW+IrTxZtg8/VToSxEcbksPtVyr87hbB
         /tMtEA/6fdxbZNCKFiosGz+MtU/SIz45c4DL8s+HiT/FWmr5EH+eui7SV0uqbPhaKYlW
         5uL5Yh1ZL9ehj55Vzd+4VdDZ4eGlO5rSCubyMGrsuBp2BmHOFg+ck4Gp1ijj52EVEJma
         9KCA==
X-Received: by 10.236.10.66 with SMTP id 42mr50225167yhu.68.1408329369851;
 Sun, 17 Aug 2014 19:36:09 -0700 (PDT)
Received: by 10.170.91.11 with HTTP; Sun, 17 Aug 2014 19:35:29 -0700 (PDT)
X-Google-Sender-Auth: izSq0q2_WWigqVXGpDUaYHPAJWE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255380>

Hi,

I have the following issue on Git 2.1.0:

$ make prefix=3D/some-directory profile
=2E..
make[2]: Entering directory `/home/asr/src/git/git-2.1.0/t/perf'
rm -rf test-results
=2E/run
=3D=3D=3D Running 9 tests in this tree =3D=3D=3D
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
error: No $GIT_PERF_REPO defined, and your build directory is not a rep=
o
cannot open test-results/p0000-perf-lib-sanity.subtests: No such file
or directory at ./aggregate.perl line 77.
make[2]: *** [perf] Error 2


I hadn't issues running the same command on Git 2.0.2.

Thanks,

--=20
Andr=C3=A9s
