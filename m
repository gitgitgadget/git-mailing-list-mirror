From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: git-svn: incomplete data after terminated "git svn clone"
Date: Tue, 10 Feb 2009 12:50:36 +0100
Message-ID: <40aa078e0902100350m2d885516o853b1ec56eb43ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 12:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrAD-0006VX-Mg
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZBJLuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZBJLuj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:50:39 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:64947 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZBJLui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:50:38 -0500
Received: by bwz5 with SMTP id 5so2549584bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=R4D2dosFa+PTxdvyOadx5roHtKx+FQo1O9766OGVyKY=;
        b=CcGMPSJwZo/MmiFAVKlAfgOj/D2VldAQreTvJh1NRjt82zkXDfM31kvg+E5b/BSp9z
         xD1WtCNf8yZsUyCzn1Stjq00ZGc+9uPUEC6+sB9GXCZ3Mx+Dvtg50Vz4ALtEDWm1WqbA
         tubXUFA+Fx8YR5AosQqyTPNaCc74iEpm6qtH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=c16lIRaVj4GpRz++XDjIg7UAO4NHinSxA/J3ayGTomBc/cLFFprR2zFBjnM1HHyBwz
         dqW+iFREceH24hmKPMVeyjh9D/Xn+9J2Ps0zGiSzmOFNcZsk/XrIsYfp8Vg0nzrRY5gu
         fs+pfMxhz9q0yqpOk4WF1EvoIeuoARTSnzC3c=
Received: by 10.181.199.19 with SMTP id b19mr2201703bkq.191.1234266636237; 
	Tue, 10 Feb 2009 03:50:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109216>

I'm a novice at Git, so bear with me even if the answer is obvious to
experienced users, please :)

I recently tried to clone an existing (very big) SVN repo by using
"git svn clone <repo> -s", and by mistake I pressed Ctrl-C after the
clone operation had been running for ~16 hours. When trying to
re-issue the clone, I got the error message "Incomplete data: Delta
source ended unexpectedly at /home/erifay01/libexec/git-core/git-svn
line 4249" after git-svn fetching another 8 or so revisions. Now, I
realize I shouldn't have done this, but I'd still prefer avoiding to
have to re-do it all.

I already tried re-building the svn metadata by moving away ".git/svn"
and re-issuing the clone command, but no luck. It quickly re-builds
everything up to the revision that git-svn broke at, but fails with
the same error message.

Now, I'm wondering if there's any way of going back to the state
before I pressed Ctrl-C, so I can rebuild from there. I know what
revision I terminated at, and I have the corresponding SHA.

--
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
