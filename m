From: Kirill Likhodedov <klikh.list@gmail.com>
Subject: Re: Tracking cherry picks
Date: Thu, 20 Oct 2011 19:00:23 +0400
Message-ID: <37162B20-4758-433E-B11E-CE4B7FF27FBA@gmail.com>
References: <4EA02E6C.2040608@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 17:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGu6k-00007h-Cn
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 17:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab1JTPAa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 11:00:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64225 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab1JTPA3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 11:00:29 -0400
Received: by bkbzt19 with SMTP id zt19so3647492bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=qaUSJTTnl2u84cak60bdaWhN0hUmP0pdlULyQ5ZlHs4=;
        b=qeHlR77aH+do8Aply1TBxtnQ/fNjGGniyvMhmBZQQraWKMBL1Tr8uPukjJYgqDJeRC
         ad62dgJYFCB4F5qCjOzLPpyj6xPPABVzQk8m0ei3w7/7PFdmgR84ue1Zf+LjKFOXFlGy
         vzk8Ll/gDhf2Jlr8D1dq2RNbpsXkOINjtXKUY=
Received: by 10.204.152.201 with SMTP id h9mr8165994bkw.99.1319122828185;
        Thu, 20 Oct 2011 08:00:28 -0700 (PDT)
Received: from loki.labs.intellij.net (gw.intellij.net. [195.5.138.42])
        by mx.google.com with ESMTPS id u18sm10115948bkn.6.2011.10.20.08.00.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 08:00:27 -0700 (PDT)
In-Reply-To: <4EA02E6C.2040608@cfl.rr.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184023>



20.10.2011, =D7 18:21, Phillip Susi:
>  Why doesn't git-cherrypick record the original SHA1 it was picked fr=
om in the commit?

It does if you specify "-x" option to cherry-pick
See the man for git-cherry-pick:

-x
           When recording the commit, append a line that says "(cherry =
picked from commit ...)" to the
           original commit message in order to indicate which commit th=
is change was cherry-picked from.
           This is done only for cherry picks without conflicts. Do not=
 use this option if you are
           cherry-picking from your private branch because the informat=
ion is useless to the recipient. If
           on the other hand you are cherry-picking between two publicl=
y visible branches (e.g. backporting
           a fix to a maintenance branch for an older release from a de=
velopment branch), adding this
           information can be useful.
