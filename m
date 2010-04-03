From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Problem with add folder to a subdirectory
Date: Sat, 3 Apr 2010 14:43:37 +0530
Message-ID: <h2yf3271551004030213u1441cf4akd0898aa3a418eda9@mail.gmail.com>
References: <28125580.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Aris Bezas <igoumeninja@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 11:14:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxzQZ-0001Gv-W4
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 11:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0DCJN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 05:13:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63414 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0DCJN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 05:13:58 -0400
Received: by gwb19 with SMTP id 19so497894gwb.19
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=kvuthrXYDSKxfQBq/Z6WDLPzsu5jSwMJJanlMXTkq5M=;
        b=W6Hy/YT6D5A76wvLqOHzi8slJnUt2yUwTHsWzjuXcdH1GgdMnqHUW9hVIosk0xfe79
         Ce15fMkX+joj5lggugTPqwLrgB+GrkNJ+0fnvBUb7O+1/ChFXeKP9PIbqrvIiPQwsltl
         dDZoFdcOVZTmj9WR5dZ2M5ZqQ/uvbnCddhOjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gJWJZA2yqjSQ5USeu1OX/eXQkoKMmGzEVer93U9Yfh8rjdqy2EEPbWg1fZgKX6pU04
         fQkoQ+sAnzzAJf2FD2ko/5xgeStfcEVJ2kMvENGAFbGy5Ja0JDiQqqDaak8Dnkk9hzfB
         IjzVO6pqzWEGWg0O9UcZkBslm5/3NKM5Z/URU=
Received: by 10.90.69.14 with HTTP; Sat, 3 Apr 2010 02:13:37 -0700 (PDT)
In-Reply-To: <28125580.post@talk.nabble.com>
Received: by 10.91.163.17 with SMTP id q17mr4287228ago.36.1270286037105; Sat, 
	03 Apr 2010 02:13:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143883>

On Sat, Apr 3, 2010 at 1:56 PM, Aris Bezas <igoumeninja@gmail.com> wrote:
> i tsake no result
> (nothing to commit (working directory clean)).

I suspect that you're trying to add an empty directory. Git tracks
content, not individual files and directories- so try adding some
content (read: a file), and then git-add'ing that.

-- Ram
