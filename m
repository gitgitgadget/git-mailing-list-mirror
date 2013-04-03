From: Mathias Lafeldt <mathias.lafeldt@gmail.com>
Subject: [ANNOUNCE] Sharness v0.3.0
Date: Wed, 3 Apr 2013 17:06:28 +0200
Message-ID: <CAMFa-2iqKaNm2c1EJBVQp4noKFvXMjpxa6YTbd=Sn5Dhrj0WkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 17:07:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPH8-00074Z-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760396Ab3DCPGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:06:30 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43798 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758791Ab3DCPG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:06:29 -0400
Received: by mail-wg0-f42.google.com with SMTP id k13so4335034wgh.5
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=s0PP4STXYBG9u1/stjvUEjm4UfITgAuqRujjcMY+HVM=;
        b=NxPnn75U/wA0x41XHsJfD/dc25GdUb+a7r/NDNWbW7SDgrTPjdJX12/IZ9himRsP+r
         y0QtiLUf6zawebTKSLoAZ6bjcHXSos96Ueo6j/SANr+h7S1iOJ/aoUkxTysOjTK9+PX/
         vhYPVHeQGQG210mbd99GVPCihAglNByAmZZJVI7jjbRZ0PyirEPR54nIs2GemquS47eW
         ik38bAjE9CT2i9vrJYM8Dbo3DrCQ0Dc9UVaiCFXrpYCGJ9tU4rULcc1i8o8MxBwyyQ2g
         hFv2aE94W0jFoAaIruUDvK12jJK3jvFaQZZysgPkSwIk082hAh1s5NxwU3W5h8cj2h6X
         67Zg==
X-Received: by 10.194.95.198 with SMTP id dm6mr3545056wjb.6.1365001588312;
 Wed, 03 Apr 2013 08:06:28 -0700 (PDT)
Received: by 10.194.32.4 with HTTP; Wed, 3 Apr 2013 08:06:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219944>

Hi,

I've released a new version of Sharness [1] -- the test harness
library derived from Git's test lib [2].

This release is all about bringing upstream fixes and improvements
from Git to Sharness [3]. Now Sharness only lacks a few of the generic
functions provided by Git's test lib, e.g. test_declared_prereq,
test_lazy_prereq or test_pause, which I might add in the future as
well.

If you want to test your Unix tools like Git does, give Sharness a try.


[1] https://github.com/mlafeldt/sharness
[2] https://github.com/git/git/blob/master/t/test-lib.sh
[3] https://github.com/mlafeldt/sharness/blob/master/CHANGELOG.md#v030-2013-04-03


-Mathias
