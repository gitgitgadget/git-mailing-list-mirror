From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git-contacts questions
Date: Tue, 29 Oct 2013 09:34:19 +0100
Message-ID: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Oct 29 09:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb4kx-0003WO-P5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 09:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab3J2IeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 04:34:25 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:61016 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab3J2IeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 04:34:20 -0400
Received: by mail-la0-f43.google.com with SMTP id el20so6167166lab.16
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 01:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=k5Ujcoe+IQI9L+GumgKZ5dbhrvh4jxZX6r+Ql7pzXNo=;
        b=gXqPiRxgFmihr3qQmjyGv0N+2EriMWIJITy1dwZkLqWx53M4H+sIN5Uu/SBcS30CcU
         3hcqcT6+dAPfNlcpLOT1SKlmycmd0lKWeHQeUtf43w0Pgf390Ykv9zxQy8bGjr02WjCZ
         O9fBBZUMPa1D3bmoCujDnQjH7Mno/4gerzkfB0fopS9xVOh4DAyCdh13n5C50DC1JIY0
         7J9XcaeojobW/6+dLRNWrv2wRK4IRExQxS46NC3k0/T1ke4Id3nA1MvtQ9x4extcosft
         ufJ3co+YPcc8BNh0el+BGzDXprU2R1sKC78boz69YHy7GQOKzUav3KixnjjxOfDu1+5y
         GQ5A==
X-Received: by 10.112.145.105 with SMTP id st9mr946002lbb.46.1383035659107;
 Tue, 29 Oct 2013 01:34:19 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 01:34:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236914>

Hi,

I'm currently trying to get git-contacts to work under Windows / MSYS.
I have a few issues that may be due to me using the script in a wrong
way, or the script having some bugs, so I'd like to ask you for help.

1) Passing just "HEAD" as a committish like in "git contacts HEAD"
does not output anything for me, but using the SHA1 for HEAD does
neither. My HEAD commit does not add any files, but only modifies
previously existing files, so I would have expected some output. In
case it turns out to be correct to have no output in my case, could we
probably say that in some message to the user?

2) For some commits I get error messages from "git blame" in function
get_blame because multiple -L options are specified:

$ git contacts b0783baacd20be7007df40cf274985c4863d63fb
fatal: More than one '-L n,m' option given
fatal: More than one '-L n,m' option given
fatal: More than one '-L n,m' option given
fatal: More than one '-L n,m' option given

>From reading git-blame's man page it indeed seems to me as if only one
-L option is allowed, so is this something that needs to be fixed in
git-contacts?

Thanks.

-- 
Sebastian Schuberth
