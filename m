From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #02; Mon, 6)
Date: Tue, 7 May 2013 15:32:56 -0500
Message-ID: <CAMP44s3+6Yaau8c=RYF8B_Quvnk9X34Umyjtnne=E_MKeYEd9g@mail.gmail.com>
References: <7vip2vmg0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 22:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZoZL-0007mE-E0
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 22:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759294Ab3EGUc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 16:32:59 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:63075 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758153Ab3EGUc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 16:32:58 -0400
Received: by mail-la0-f48.google.com with SMTP id eg20so1024203lab.35
        for <git@vger.kernel.org>; Tue, 07 May 2013 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZuujPbQDc0PDxqQ945KiOiUmVmMOWvCvxWh08LNZjHA=;
        b=bpSozvaesMHiJz8OboKtpPNcaR3cNhvHr9M8a70nY4+m2L5XvKkt9vH2aUm1PpRvbs
         LfBCzy8yNLTs31jx6af8XrXNEEUOGLsVUhwm5SYSKcpypRy2gYWOVYS72zEnODiBABzv
         U5B08bzZtTYP/x5US6CjBA2qIGTC2W30efVd4GD/MZNIGOCNIX3c2f5amOzrNqua1GKc
         tWLKf8kISqTO6+7VluefhbwasRGjGxb+7WJkp4jyXCJKSfFsydlsLEty0XQoNYLKYk8c
         s83kEI7sGL6pB/yqFsvbv/dX+q2F3vZzHe3QLIY6snTSIk7D1XjZZmYVtafBGp7BWxC0
         sx2A==
X-Received: by 10.112.125.130 with SMTP id mq2mr1705083lbb.103.1367958777010;
 Tue, 07 May 2013 13:32:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 13:32:56 -0700 (PDT)
In-Reply-To: <7vip2vmg0k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223599>

On Tue, May 7, 2013 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/at-head (2013-05-02) 5 commits
>  - Add new @ shortcut for HEAD
>  - sha1_name: refactor reinterpret()
>  - sha1_name: compare variable with constant, not constant with variable
>  - sha1_name: remove unnecessary braces
>  - sha1_name: remove no-op
>
>  Instead of typing four capital letters "HEAD", you can say "@"
>  instead.
>
>  There was another series from Ram that looked mostly test updates
>  but I lost track of which one was which.  In any case, are people
>  happy with this series?

This series has cleanups and features that are good as they are.
Ramkumar said he was going to resend his cleanup series, but he
didn't. I'll try to gather all the patches and split them into
cleanups, and features.

Cheers.

-- 
Felipe Contreras
