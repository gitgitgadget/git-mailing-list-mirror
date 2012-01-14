From: Jonathan Seng <nekenyu@gmail.com>
Subject: difftool / mergetool waiting
Date: Fri, 13 Jan 2012 21:13:44 -0800
Message-ID: <CAG=s6FnG=3hO5jykc8s40SrCPfvJSvtEMVNBSihX5Y7T3b9SMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 06:14:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlvwR-0005Q7-92
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 06:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784Ab2ANFNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 00:13:46 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45855 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2ANFNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 00:13:45 -0500
Received: by bkuw12 with SMTP id w12so455258bku.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 21:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KxEz3hrDFfN8ve9hqpjPcagJMlMtvcSXUviqE3Ssl6U=;
        b=iKp1X+pEfTRIQkEm9vxqk66HPZocYg2/FhEGmCkwqVWRM+fpkvkBj4ImzGwmHqOtOk
         a88SbpWYkxMiswG32SZpSUECvhNc8xnv7teiM0Vux1cHjV8jzhEZlLe69XLcD/qRzte5
         Nsf03JtnQ4mzXsarTPmjUqlsnNQy541mMEMxo=
Received: by 10.205.127.2 with SMTP id gy2mr1448675bkc.87.1326518024408; Fri,
 13 Jan 2012 21:13:44 -0800 (PST)
Received: by 10.204.51.133 with HTTP; Fri, 13 Jan 2012 21:13:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188547>

Hello,

I would like an option to difftool and mergetool that would control
waiting for a return code from the difftool: wait.


Like prompt, wait would be configurable with the difftool.name.

Like prompt and for backwards compatibility, wait would default true.


If wait is false, prompt would be overridden to be false.

If wait is false, git would fire off the tool command and proceed to
the next then exit cleanly.

If wait is true, git would behave as now: it will wait for an exit
code of each tool execution before proceeding.


Thank you,

Jonathan
