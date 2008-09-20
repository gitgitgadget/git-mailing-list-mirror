From: "Sean Davis" <sdavis2@mail.nih.gov>
Subject: Problems with git over http
Date: Sat, 20 Sep 2008 13:13:53 -0400
Message-ID: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 19:15:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh62y-00046z-23
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 19:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbYITRNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 13:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYITRNy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 13:13:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:48633 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYITRNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 13:13:54 -0400
Received: by yx-out-2324.google.com with SMTP id 8so141283yxm.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=nFkKfEX4HSU1HewIz+rV03mGgjlHPZjLxzLObNT4gno=;
        b=WZ3ROyawg30IfEs/gv6dTWnzC2JOmSWrQQIZ76w9P4CxPVAc8Gh2Lu16jQGu6fXFLO
         G3DYYJp8rmSRNdJmXPFJpgFGsJx7voTEXoi8P6KiVvJlxR1/0q4tPoAN9n7BEx+yIddq
         7C3VPWRcTsdKf28iiFOIpxLUXQGt3R/qczBLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Tym6dVnskmtPEZsX3EleaaYiJfH4zRdGfmQ01c5uX+AzjJIRhjKaoPdv5a3KxLZjnd
         whjo931viOy6fdL5DGrSZOHWy+Qo+mwqE+JrqB7o6guipPY19IVMv5ITnzh+FpfriXFo
         oMRwxb9Zmvc6QAGUpdztXJpotE653R+2poK3o=
Received: by 10.100.140.15 with SMTP id n15mr1428865and.69.1221930833061;
        Sat, 20 Sep 2008 10:13:53 -0700 (PDT)
Received: by 10.100.197.2 with HTTP; Sat, 20 Sep 2008 10:13:53 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 4d294e1a19be855b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96357>

I am new to git and trying to set up a remote repository over http.  I
have configured apache2 and the bare, empty repository.  Using curl, I
can get the file HEAD without a password (seems .netrc is correct?).
However, when I try to push to the repository, I get the following:

sdavis@lestrade:/tmp/testing> git push
http://sdavis@watson.nci.nih.gov/git/sean_git.git/ master
fatal: exec http-push failed.
error: failed to push some refs to
'http://sdavis@watson.nci.nih.gov/git/sean_git.git/'

What can I do to try to debug this, as the error message isn't helping
me to sort out what is wrong.  The client and server are both running
git-1.5.x (although the minor versions are a bit different).  Any
suggestions?

Thanks,
Sean
