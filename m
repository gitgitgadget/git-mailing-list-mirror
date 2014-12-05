From: Michael Blume <blume.mike@gmail.com>
Subject: Accept-language test fails on Mac OS
Date: Fri, 5 Dec 2014 14:35:51 -0800
Message-ID: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>, EungJun Yi <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:36:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1U2-0003TX-31
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaLEWgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:36:13 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:62685 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaLEWgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 17:36:12 -0500
Received: by mail-oi0-f49.google.com with SMTP id i138so1138991oig.22
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 14:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=2BdP0Z9OM9jHYj/iu4Q7SUnGEg6tnPNWktMmvJ6ncWA=;
        b=izXAs/n+Qj2MLwT5+1DCAJ8FIwCgfn4Fa4r88crMH8S3mmgmEVR69I/3sg2oaakP5O
         iu14qe4AUXQBtzwQX0IGNxHHhz15nVj1rLiuAI1APdVhDA/nHdlltAzR2ZZ9DOgA+1Wb
         QJrRFrJtQgDUJKTiyVLmq4zMy2iL2AmwXRXPmNxp5HLA4zDAiE/d/V2XnJhFhQDNzEHT
         cMYZujw3Rie7SDA5sQx52w/4W7+DsRcQv9YtuymJP96r1ovxctr6I9DAdY9V9JVXC3LC
         fyP1tVfEUy41ZHyDfrf7sTMALDsCQdwaN/Jwr8c1XOuE30vCYSJ9ijw+hTU2b9nLEA78
         QC/A==
X-Received: by 10.182.252.225 with SMTP id zv1mr12018551obc.37.1417818971724;
 Fri, 05 Dec 2014 14:36:11 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Fri, 5 Dec 2014 14:35:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260903>

Test #25 'git client sends Accept-Language based on LANGUAGE, LC_ALL,
LC_MESSAGES and LANG' in t5550 fails consistently on my mac, and has
since the test was introduced. Test 26 and 27 ('git client sends
Accept-Language with many preferred languages' and 'git client does
not send Accept-Language') seem fine.

I'm building git with NO_GETTEXT=1, which may be an issue? But in that
case the test should probably be gated on gettext?
