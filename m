From: "Sky Patrick" <patricksky852@gmail.com>
Subject: How can i write a new protocol for git
Date: Fri, 5 Sep 2008 17:22:57 +0800
Message-ID: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 11:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbXXx-0004r3-UJ
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 11:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbYIEJW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 05:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbYIEJW6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 05:22:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:49186 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYIEJW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 05:22:58 -0400
Received: by wf-out-1314.google.com with SMTP id 27so378664wfd.4
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=XxNvnbiuyPe1S0noSI9mpgoToDP5vPtkg+1CKUWgkks=;
        b=IuQIVmdaZ0dtHqYbauQJB+hY8qjGC7/IMYgjUqDEF+Oq+sNCV2wZ1I+D354bz1vTzh
         5snqVAI9cMjeJSBJQW4jYSq7NLTSYRl4XHdPTBvENWVMd6Nku4TBPhyZn2RRBjn5ncXP
         odk9AmllOGl2q0t+Zj2H6qLCDwY59P1CMBGrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oswOmNgYsqp3xNhbxaN/KTyPm8BDGLtBMClUeVg7dvu4l5HXPFNs+ZbnYrpOaoJuqa
         Bj0inCaYDhOOAivpH4rQRIiXMRJfoPkI3PriHTw0MQ4vaZFed2twQtT47YGfjR7TWtaC
         Ay5s8N7oH8euS01mvpIR8+na1mHYd1hslmPys=
Received: by 10.142.158.17 with SMTP id g17mr3977177wfe.73.1220606577226;
        Fri, 05 Sep 2008 02:22:57 -0700 (PDT)
Received: by 10.142.225.6 with HTTP; Fri, 5 Sep 2008 02:22:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95003>

Hi,

If i want to write a new protocol for file transfer and would like to
to integrate it with git. Is it possible and easy to integrate it ?
Currently, i know that jgit may achieve it, but it is a Java
implementation and may not work with git command line program that
written in C.

Regards
Patrick
