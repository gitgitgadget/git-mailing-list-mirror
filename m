From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git on ancient compilers.
Date: Fri, 9 Nov 2007 18:14:08 -0500
Message-ID: <9e4733910711091514k55473201jf29434961f01e46c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqd3S-0006by-0w
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbXKIXOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXKIXOK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:14:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:43272 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbXKIXOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:14:09 -0500
Received: by nz-out-0506.google.com with SMTP id s18so635353nze
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 15:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=o7yDx7aA66f5kjCa/1Kwxq00pwKsvov5kQ8op0uasVA=;
        b=hlAtG3F1DQqWTEbIJ5wfLTrbxua66F0JW5O+3XpLMwps8gZgudTwsFxLInF91kq5fG6WVKeMb0uwz65CoQybOTPbThs3n3Uj68BNXORO6FVvpnRZ/O5Qt7m452q7e+GfRlXOPB59RHCiOn7wUUXJXCWC3N+npNEy0V7P4/kbMsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ubt83fq+iAZlR+nRKvf1X5sTgKz/o3I7IuCWxWviNYMvYUkgFnvUKsS1FvqB3TLVSKuu99BG19BVfp2ZPPEUAdoTPvsOL38dJ39euHFoSCR3QfTNAvqzf+EDfYc6E9VLMb7hORHQLSEqHG054brOgeuxrPdS7VOBsICIUgS4wu0=
Received: by 10.114.209.1 with SMTP id h1mr123405wag.1194650048496;
        Fri, 09 Nov 2007 15:14:08 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 15:14:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64271>

My hosting company is using: gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)

git is using a link parameter not available in 3.3.5

   LINK git-mktree
gcc: unrecognized option `-R/home/jonsmirl1/lib'
    LINK git-patch-id
gcc: unrecognized option `-R/home/jonsmirl1/lib'
    LINK git-peek-remote
gcc: unrecognized option `-R/home/jonsmirl1/lib'
    LINK git-receive-pack
gcc: unrecognized option `-R/home/jonsmirl1/lib'
    LINK git-send-pack
gcc: unrecognized option `-R/home/jonsmirl1/lib'
    LINK git-shell
gcc: unrecognized option `-R/home/jonsmirl1/lib'
    LINK git-show-index



-- 
Jon Smirl
jonsmirl@gmail.com
