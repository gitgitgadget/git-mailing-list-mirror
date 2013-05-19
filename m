From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] for-each-ref: add %(tracking[:upstream]) for tracking info
Date: Sun, 19 May 2013 17:18:17 +0530
Message-ID: <CALkWK0m8HbYRAJdPgN7CnX_VMTX36GG-=BcqM+NTKwxX_0xqzg@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <1368959235-27777-6-git-send-email-pclouds@gmail.com> <CALkWK0k5qM3CZoivC1GJaBfwxWwvpDVtU7mHmm3feiLKr4kxXw@mail.gmail.com>
 <CAMP44s1a5JH1T-ckvmFomoKKhFCE61CQ79YFxi4RiQLqeqhgTw@mail.gmail.com> <CACsJy8DSH2Uq9-KhLVS=6Gu5L2q_gbHtrqmaQWE4_DJ6J2zQmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue26o-0003H7-W3
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab3ESLs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:48:58 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40530 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab3ESLs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:48:58 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so12224753iec.36
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b3g+o8xea6Elk/feY4Pyd45WFhBRwLJMAI0FmTwS9mE=;
        b=uN9YIUq4hPQ7Mf/Fxj9jbdyRRnAeNC/It9LB5bAyNw/S/aqhuS8HkkOeEZndcLpF0d
         YJwR+WyRzDGs9Wqly7zkaCWNhnefPQ7PBqAem+oWYQ5Qv6C9ldHGJDgLK3EIKiWRbywg
         ix1FmlE9u7bITcR+M5pXlVrZpnluX3wSvsSHu7xYXK+m9MAULNMnGgrnRJpTRYBJ301T
         KogtIeb9tEtUMJW6hKTEPWxa8GJ9rh5vBilii6dU1uOvECM9nHirLbhVepvZBx//rUu5
         1C6CdxN3xIOktIWz8w831gOliCdjqLn5Nze201XMRLbzg2B/gZJb0tHNa3NdefDlc5nN
         LiBg==
X-Received: by 10.50.120.68 with SMTP id la4mr2560966igb.49.1368964137763;
 Sun, 19 May 2013 04:48:57 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:48:17 -0700 (PDT)
In-Reply-To: <CACsJy8DSH2Uq9-KhLVS=6Gu5L2q_gbHtrqmaQWE4_DJ6J2zQmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224863>

Duy Nguyen wrote:
> Exactly. I already explained why %(upstream) can't be used in 00/09.
> "tracking" may not be perfect. Somebody might want
> "tracking:upstream:short". It does not look quite nice.

Which is why I suggested keeping upstream, upstream:short, and
introducing upstream:diff and upstream:shortdiff (or :tracking if you
prefer that) in [0/9].
