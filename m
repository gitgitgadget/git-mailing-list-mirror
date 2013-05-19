From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sun, 19 May 2013 17:56:17 +0530
Message-ID: <CALkWK0=poS43aGYuMzEP9K7e0P0khFRnzQxihtgAvh3rtb9Mdw@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com>
 <CAMP44s3pZYw87awogjjOdFRP39Ou0=td2erhV2-aC-9_A_Z75A@mail.gmail.com>
 <CALkWK0nQzEK6-E7aMnGg6eYZJ_=XsE6FBmRgu9_8jBGkYmJe+Q@mail.gmail.com> <CAMP44s1rV+Pe_58qZLvTDt-r7XkDAinh3npY-dr+W5vnfNk4NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:27:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2hb-0006ZJ-II
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3ESM06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:26:58 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:39179 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3ESM06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:26:58 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so12252787iec.36
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iEAmN+FyTW1paXzwYsukhbQZL2UV9GDgtbdShItyrcM=;
        b=p0v4/r6kk39T7QDrcSaIF0bqg8JJWLOm0sxsQLYSpBl0Ek4OCM0NfMEEwZrzrJtCW9
         05b8FUZU7HZ7uTzrmY5BcgmO/Qm81V3mngrONFFXEPFgpDOejsXTXvwqjwliXU33QTXu
         SVSKjLXQBARpn3JPQO8ImHgV0s8KrnfRkdhJ5pggmDxTly63RwkQfA9aIWayJ/D83LG5
         JP4qq+sq3+1iqEwL5HWxgM+nSsTfpchAaqCrhlZTsFS03UPVRegLwGnQNVaNDiNvbZvp
         3SuzYH1Hw6s9FFqLJWiyoE8UD0wK9pGuQsk6iQI/zMywSCLYjcEeQLbgbuDpzx2fMkpw
         JuGg==
X-Received: by 10.50.120.68 with SMTP id la4mr2617368igb.49.1368966417773;
 Sun, 19 May 2013 05:26:57 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 05:26:17 -0700 (PDT)
In-Reply-To: <CAMP44s1rV+Pe_58qZLvTDt-r7XkDAinh3npY-dr+W5vnfNk4NA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224881>

My itch is very simple.

Felipe Contreras wrote:
> % git checkout fc/remote/hg-next
> % git rebase -i # rebase to master

% git pull # I want: pull from origin

> % git checkout fc/remote/hg-notes
> % git rebase -i # rebase to fc/remote/hg-next

% git pull # I want: pull from ram

> % git checkout fc/remote/hg-gitifyhg-compat
> % git rebase -i # rebase to fc/remote/hg-notes

% git pull # I want: pull from felipe

With your series, rebase works and I like that.  But, by specifying
branch.<name>.remote as '.', I've essentially lost a way to specify a
remote I want.  Why can't I have both?
