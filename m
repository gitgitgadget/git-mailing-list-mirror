From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Tue, 28 May 2013 19:58:49 +0530
Message-ID: <CALkWK0kv-5vAMsrtpPffBaSZrHfm98KNDL8Jw6_pSLsL=8=8iA@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com> <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 16:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhKu6-0003g5-RP
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 16:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934299Ab3E1O3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 10:29:31 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38475 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934123Ab3E1O3a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 10:29:30 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so7330268iee.11
        for <git@vger.kernel.org>; Tue, 28 May 2013 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BREh2u0qJLq45tqBRb7S7JTO8RRJqt4aXz+Goy1kdr8=;
        b=uxy+wH5ET4QcrIT9k60+gF8oTl/DwmS/FrCLaEz7kQAvO0OcpUCsF5OctFeusTUYxr
         eRswtxatJs5ocTQKLmTZh4lyYhXFSohBiC/tTttz7XEsZwG7izVEMlks1lxjDXtWS9H3
         QjDvYdrk0iOVYLN+VMoXHWDGQIwIEfXamwDk9EkeydzxoKHcD/RGT2Ne3zNclmq6aTVk
         TG/dgJhhlL9YOBC4M0KratBHGPgP3t0gtk2WOI3mfmG1KJ862hhKjP6i3BwQZoGkvEzb
         6EHTgdPQG+RkbSmpN7SgmdwoqfDmA0tIqBLbHh4TakuQK7Ye2aQxD38JNPfzd1pQo7tF
         k7Kg==
X-Received: by 10.50.153.6 with SMTP id vc6mr6951000igb.57.1369751369972; Tue,
 28 May 2013 07:29:29 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Tue, 28 May 2013 07:28:49 -0700 (PDT)
In-Reply-To: <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225656>

Ramkumar Ramachandra wrote:
> %>(N) doesn't work properly with f-e-r, and I'm not sure why.  I'm not
> talking about your last patch where you compute * -- that works fine;
> it's just that %>(N) doesn't when N is a concrete number.

Try this:

%(refname:short)%>(30)%(upstream:short)

(assuming that you have lots of branches).  I'm noticing random
alignment problems.

However, %<(N) doesn't seem to have this problem:

%<(30)%(refname:short)%(upstream:short)

I'm not able to figure this out.
