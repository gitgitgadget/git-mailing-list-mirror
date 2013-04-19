From: Sadystio Ilmatunt <urkpostenardr@gmail.com>
Subject: Help with git-svn and SVN symlinks
Date: Thu, 18 Apr 2013 17:07:26 -0700
Message-ID: <CAELx_2MamBzFZ3ZfA_08RTC56QHdCjNNsz0w0yYv4iCSZQNbPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 02:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USz84-000392-77
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 02:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967621Ab3DSAYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 20:24:25 -0400
Received: from mail-we0-f195.google.com ([74.125.82.195]:56456 "EHLO
	mail-we0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967537Ab3DSAYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 20:24:25 -0400
Received: by mail-we0-f195.google.com with SMTP id i48so729837wef.10
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 17:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=ow/Yfwqlpqnw0CafJNNuGqnCubXIrrnFyrNCGMdZ+Wg=;
        b=eoOJaQxB14NNzwSMxICmsH75JWTIpLbNQehAs0GGXIne1EZF4JhRIMcIzWn4C2Du1R
         8oxxcyTLWeEKcuSZ8AoZLD8uKCTT2tzV3lTdZlbH2JQHvzsTD1VROGeV2ssB88DjP32y
         PuPd4x3JijGVJYgeZLonJRbu8LRiaKoH3oOu+Z4Ikrih7LidY2HCJZZkyXHcPqqOPADe
         UcX1D6uRmWPgTlp1l2Frmv5nPgXoJtJNveKiZe6AmxCaMIXteNWbK4Het+jtayF7mZUx
         7NAH8GOk40QLYJDAGxWRcwL/uNrPnm1YfePRDXQJs0Y2BvZEbY1lcYCxiO4/xNecXAAb
         laUA==
X-Received: by 10.194.178.100 with SMTP id cx4mr22203619wjc.47.1366330046567;
 Thu, 18 Apr 2013 17:07:26 -0700 (PDT)
Received: by 10.216.124.193 with HTTP; Thu, 18 Apr 2013 17:07:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221720>

Hi,

I have been using git-svn successfully for last 1 year.
But yesterday somebody checked in something in SVN using svn client
and It caused inconsitency in GIT-svn repository.

In one of SVN Merge commit, Some symlink files were not made "svn
special" by mistake,
So there was another SVN commit with only property change to convert
these files into symlink.
Git-svn should have picked this commit and converted these files into
symlink but I think it missed it, Now I have text files in Git
codebase instead of symlinks.
In SVN repository these files are symlinks.

How should I fix this?
