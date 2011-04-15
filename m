From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: git-p4 issue
Date: Thu, 14 Apr 2011 23:00:43 -0400
Message-ID: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 05:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAZHA-0002V6-K5
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 05:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab1DODAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 23:00:45 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35862 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1DODAo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 23:00:44 -0400
Received: by qyg14 with SMTP id 14so1473836qyg.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GqZ6FhoyDArc2buGAiOd8BEypEec5YE+u2imLh0MwLo=;
        b=UbEmSHkhb4lOy9WH2DxrB3ki6e90G+VlXi9SdHIfoGSZ7mFxr8DKJUu2OwRZ/OVmVe
         pqtoL6bAYUU0y0txM7pjM4MrXQgEKwHgChqrX++b/5pwloayS+/DorSBIcDO5yMyDC+e
         eLiEYD5r0Wf8LB47cNPGESxnzybHhnTlyHltw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=VhPjFS18JvIW9AIzrlxMar0WJHzPlYzvjwvGaHnqM4wEqxWnPMjsuiKP+ZRRlelX5C
         U1OasuEsFX9/pJm5youR445q7UMpi+f8dkqxqW+IMec4jr5YxYpTg3UPpZWu4xCVXM2m
         vFBTthzm1Xljx59c6C2syjYRV6Zxv61OgNww8=
Received: by 10.229.33.9 with SMTP id f9mr1174725qcd.4.1302836443433; Thu, 14
 Apr 2011 20:00:43 -0700 (PDT)
Received: by 10.229.247.204 with HTTP; Thu, 14 Apr 2011 20:00:43 -0700 (PDT)
X-Google-Sender-Auth: NHJPLEiHByYDgeluuU7JW29hiQ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171582>

Pete,

I was hoping you could help me out again.=A0 After using git-p4 for a
while without a problem, it has suddenly stopped working for me.=A0 I a=
m
using the latest master.=A0 I haven't seen any recent changes that I
think could have caused this, but maybe you'll have some insight.

The issue is that when I do a git-p4 sync on my existing repository,
it reports success, but seems to do nothing.=A0 It does not download th=
e
latest changes from p4.=A0 If I delete my repository and start over, it
will download all the latest changes, even the ones it was not
downloading previously, but if I try to sync again later, it does not
do anything.=A0 I tried running it with the "--verbose" mode, and I see
it says it is loading each of the changes, but they are not ending up
in the git repository, and it is not reporting any errors.

Any ideas of what this could be?=A0 Is there anything else I can run to
help debug this?

Thanks,

Mike
