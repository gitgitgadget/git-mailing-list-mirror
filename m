From: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
Subject: git: patch does not apply
Date: Wed, 26 Jan 2011 13:41:54 +0100
Message-ID: <AANLkTi=ujfX53PXsfQXKf+1d5WQP=zMtzhKG-PSzT2_s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 13:42:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi4hI-0003x5-4q
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 13:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1AZMl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 07:41:58 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60388 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab1AZMl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 07:41:57 -0500
Received: by iwn9 with SMTP id 9so824426iwn.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ktiVd+2E5b2IP/B39PeSKXBx+8KDun2joaeBlFdQ7EY=;
        b=Vb4Q1lN3y/Aa/5sC+lEfvLGyJQG1BuYu767ALmETUI+L+0AdXL4JKvbewzSLcvXwHA
         3F7dJb63REI693PXPaLngEbmgC6SAsEfdI81G0DGogKg9Z2sos3i6wVS/z09oHtf4lt2
         IHJh9WbWrmRrqpAdbyYwE5XCwFMp4vV3l6zkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=c2Xmo8LeusDMOhW9uIctfnx2GP8ObGvk7o7CTel3VxWDqFBF98U4u/aUeNHapNz+CO
         gAS/BG/EqKTRxvVKwQXhWim34NWx3B1URpvKIzry+IWO1hodf+qArHR1s0YGcC3/LKUw
         C+p4E47opXK5RMrHQE1hvzzWbU+JVR0r+e/PA=
Received: by 10.42.164.133 with SMTP id g5mr399339icy.134.1296045714529; Wed,
 26 Jan 2011 04:41:54 -0800 (PST)
Received: by 10.42.139.10 with HTTP; Wed, 26 Jan 2011 04:41:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165518>

Hello!

I have a certain patch called my_pcc_branch.patch.

When I try to apply it, I get following message:

$ git apply --check my_pcc_branch.patch
warning: src/main/java/.../AbstractedPanel.java has type 100644, expected 100755
error: patch failed: src/main/java/.../AbstractedPanel.java:13
error: src/main/java/.../AbstractedPanel.java: patch does not apply

What does it mean?

How can I fix this problem?

Notes:

1) I posted this question on StackOverflow and tried out several
things suggested there.

http://stackoverflow.com/questions/4770177/git-patch-does-not-apply

However, I don't have a working solution yet.

2) I'm using git 1.7.3.1.mysgit.0 under Windows 7. The author of the
patch uses Windows XP.

Thanks in advance

Dmitri
