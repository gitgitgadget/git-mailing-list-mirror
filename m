From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Submodules with feature branches
Date: Thu, 5 Jun 2014 09:03:25 -0500
Message-ID: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 16:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsYGQ-0005ev-S9
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 16:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaFEOD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 10:03:26 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:54837 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbaFEOD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 10:03:26 -0400
Received: by mail-vc0-f182.google.com with SMTP id il7so1166945vcb.41
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=Roq61BVmVQGO/Kt4I8QVX9kGS2F8Z5zpBNIlb7N9qG0=;
        b=ljZLF4yMRLInv4uEKHGVFoVyGYFL/w/oZbDcRcNg521sb7BH/Q49ZKS8zWuqovlO7p
         dbs7kep9X3ua5dGKLO0O6EEZPti1Kzdh36AK6rtRUdNgmLnsr7szSTBuFo5guu29YXbw
         GCka210ZLzrwn6b+InamovTQBYtjQ0BoACW4wHBitjRLdnyvh67iV+yNyi66hEKKzeGx
         cYgQjx13B3phYDWlpfirSM+QMPNB0kOeNLr1VAIZdbbNHwoUf7OLvII2TCNnvaWRVssh
         yf9jgw5DD56nY3cBGtQEGOvRZBCGNCA0q/n/wLIkbLKrd2zpkI04OxrXVsu+I5ULMXLz
         aKqg==
X-Received: by 10.58.185.165 with SMTP id fd5mr1898338vec.41.1401977005345;
 Thu, 05 Jun 2014 07:03:25 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Thu, 5 Jun 2014 07:03:25 -0700 (PDT)
X-Google-Sender-Auth: XlklfrcmlikeNQr-r6QwAX9CSvI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250838>

I have a question regarding submodules and their applicability given
our workflow at the place I work.

When I work on a feature, I normally create a feature branch. If I
happen to make changes to the submodule that only work with the
changes introduced in my feature branch, that seems to complicate
things. For the purposes of the feature branch, do I need to create a
corresponding feature branch in the submodule and temporarily update
the submodule URL to point to it? When I merge my feature branch, I'd
have to swap it back?

What is a recommended workflow for this? Thanks in advance.
