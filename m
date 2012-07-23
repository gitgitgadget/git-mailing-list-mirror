From: "abhisekpan@gmail.com" <abhisekpan@gmail.com>
Subject: Cannot delete weirdly named branch
Date: Mon, 23 Jul 2012 14:32:48 -0400
Message-ID: <CAGhmpEGEZchXc4DqZ21BAKxf6_mHRp=TOUH8s=GG0vPscz1kfg@mail.gmail.com>
References: <CAGhmpEFg2ZcwqO=wDNPLfPCnrobq4oOcwvFCm27vrEuiES2XbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 20:32:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNR8-0004Fj-G3
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab2GWScu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:32:50 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42641 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab2GWSct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:32:49 -0400
Received: by bkwj10 with SMTP id j10so5600298bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=k5P93qznXyTBQ/WCSDvMR+MHwYEK1NjY0ZZSwfW4tOs=;
        b=IQw0PDYOryRc6rJ3SlgpXS9fMi1UK7CIZ74QpsuGPEAgqhLxx0lGIouWGuJ9cAzUcD
         yH5AG1Dm7plv/k1vlEghd1OdfMoUnuy2A0H14QSATziD+jVbyvQnLTAsePl1cnz6GiCL
         YKXWRKtbu6yHAo2X42AqgBlylOkd5Y5Xz3cXcIPHfPoYaBIgX5Egk7/RFRn/Yej4gszO
         MnmYljai4LBHvU8mKSDfx4UDIy6Sh3R1IP2AnXFVv9XTXc5noUSFniIqCRUBE83j5BKq
         GSjtTIJseSVTCRBBho65vAD4ELiQ75S3vbH9aSATbwHns7PWWDEHFhheJCpcd/mabfZh
         94pg==
Received: by 10.204.155.146 with SMTP id s18mr8633833bkw.23.1343068368054;
 Mon, 23 Jul 2012 11:32:48 -0700 (PDT)
Received: by 10.205.40.137 with HTTP; Mon, 23 Jul 2012 11:32:48 -0700 (PDT)
In-Reply-To: <CAGhmpEFg2ZcwqO=wDNPLfPCnrobq4oOcwvFCm27vrEuiES2XbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201953>

Hi,

I am a new user to git and I found an interesting behavior in git. I
am not sure if this is a bug, but I thought I would report this
anyway!

So I can create a local branch called "--tracking" like this:
git checkout -b --tracking origin/somebranch
I messed up the syntax while trying to create a tracking branch, but
this resulted in a local branch called "--tracking".

Now I cannot delete this branch. Running:
git branch -d --tracking
gives an error: unknown option `tracking'

Using quotes around the name does not help. Is there another command I
can use to delete this branch?

Thank you!
--
Abhisek
Live Long and Prosper
