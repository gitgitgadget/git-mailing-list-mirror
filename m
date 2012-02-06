From: Adam Mercer <ramercer@gmail.com>
Subject: git describe relative to a given tag pattern
Date: Mon, 6 Feb 2012 16:03:32 -0600
Message-ID: <CA+mfgz0VB9qMHHtoT76zCOiUaH=8egdMDrneQVRBug2waQsGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 23:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWff-00016K-C1
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab2BFWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 17:04:15 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52168 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab2BFWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 17:04:12 -0500
Received: by pbdu11 with SMTP id u11so5332429pbd.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 14:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=KbaIAxGG7J2h+Q2bg2ndGAejxFV83xBhzURLJ5sTZeY=;
        b=n+DWgPEGxUr/aA0i+uSopF3g19iwr4h5gndFAD6X7YH+jwK8CG3z7bqgk/jZq2vQVq
         +EL6KS8qWgYhfpPV10xfKREQwK5aD+5PWM3SynV2SNI4Gyp/iW+gYlmsJvChiCEawUPJ
         PBoYOPcBSVX2wwL9caSXDDzazwnCIHeNs2SVY=
Received: by 10.68.74.170 with SMTP id u10mr50704645pbv.99.1328565852337; Mon,
 06 Feb 2012 14:04:12 -0800 (PST)
Received: by 10.68.232.170 with HTTP; Mon, 6 Feb 2012 14:03:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190111>

Hi

I'm trying to use git describe to describe the current status of my
tree with respect a given tag, or more specifically the latest tag
matching a specific pattern.

My repository has the following tags:

$ git tag -l lal-v*
lal-v6.6.0
lal-v6.6.0rc1
lal-v6.6.0rc2
lal-v6.6.1
lal-v6.6.2
$

And I want git describe to use the latest of these tags, so looking at
the git describe man page it seems that the --match option can allow
me to specify a pattern. This, however, doesn't seem to work:

$ git describe --match=lal-v* HEAD
fatal: No tags can describe 'cee13cbb25d0fa38f6e3bc6622bc751ebf35d2f0'.
Try --always, or create some tags.
$

quoting the pattern has no effect, what am I doing wrong here?

Cheers

Adam

PS: I'm using git-1.7.9
