From: Charles Rudolph <charles.w.rudolph@gmail.com>
Subject: Additional plumbing commands
Date: Tue, 6 Jan 2015 08:05:42 -0800
Message-ID: <CA+SVznFFPED+ms=4abNpvNQx-nt6imDMJtYKuNBTTLzCJ547Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 17:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Wdj-0004AJ-2x
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbbAFQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 11:05:46 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:47259 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850AbbAFQFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 11:05:45 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so20649060lam.33
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 08:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=RqQjVGT4JjmGdt6O/hrtNpCyhdGm0ucO9ES/IHqLSvc=;
        b=INgbE649qCZcyJ5NEZAl5WoPQx4+jQD8w64FDhJJiXMKixM/BxMyMzKLs2L0D3gRg4
         +upsM2ZIDjBl1JBQROE0P/B1RAVxVFghBb7JNrEHjMjJP2MD5NTtnXI5vtvAWmlsyrW1
         mdPKE+UffpIJUJd7GvjLVdqwTo4T5YhwJWX/nQoHftFLUwLH4l6cofaV7aID8YEmRZ4D
         ax+r9b1XhAZ/xx/yE1cP0efJesFxct2opjN0XKcVk6fEOLTucMj20iHN8hjRzBR50KEt
         h40Z28RALj1ayn0TE4S+3KFPaR4scBtm/VUSYAMEVmiDbCziuPAJeXQsz7PRyMA1fyS6
         7QbQ==
X-Received: by 10.112.140.196 with SMTP id ri4mr69954384lbb.55.1420560342249;
 Tue, 06 Jan 2015 08:05:42 -0800 (PST)
Received: by 10.112.34.101 with HTTP; Tue, 6 Jan 2015 08:05:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262072>

I am writing some higher level git commands for
https://github.com/Originate/git-town and would like some additional
plumbing commands that can tell me

1. is there a merge in progress?
2. is there a rebase in progress?
3. is there a cherry-pick in progress?
4. are there unmerged paths?

Currently the only way I know how to do this is with "git status" and
looking for specific text.

Thanks for any and all comments.

~Charlie
