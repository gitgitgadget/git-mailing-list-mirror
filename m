From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2014, #05; Mon, 29)
Date: Mon, 5 Jan 2015 11:50:45 -0800
Message-ID: <CAGZ79kbOnX7LVDB8d2Nw0629MvY+ojmy0kDWATM2Zj8NzPRgjQ@mail.gmail.com>
References: <xmqq387yywm6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 20:52:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Dg0-00086g-JM
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbbAETur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 14:50:47 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38641 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbbAETup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 14:50:45 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so19550902iec.25
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 11:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N82Sis5MlezDISEeM/tvCf7nNqNs7UUkPnmwXkd6A7A=;
        b=nTNbETh6gdG3rhOVrpMDM2e42sA4p+/mh3TEZw6VzNah/dqeFUzBPw7zj8Nj+iCd3N
         u5Dp46PBC/e9zf/+vjdmgzPB73Jb34zmE+WjevwIN7fRhBuPR/yDNcTQX/U3eh2XE3E8
         CMtsRAFJtXEm0ajhoGfWrHf7Cc3Xry9lM995K+tcOLNnANyAicBA90DVAQRd7Vvawdwy
         zesg6c4yoCvrxJP1aUYEVfqzGlVSDJMyUA8iOXLb2PKVmurQwklwXGW72+LaKX9biPem
         KYUX50faJFhIiUf98suF+fWr85gzn2Cub/sRLNY64aJZbN/oo3DtcsEwCq5ZTYqQ3v28
         4ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N82Sis5MlezDISEeM/tvCf7nNqNs7UUkPnmwXkd6A7A=;
        b=Bt3DQKIab0dQwY43hwlaxnGh+9O1m09+bx2XTec4TST16+HOwIOJfvcZW+nlC2Ulej
         UbL1NauTpgGxQW/HslWgXkQMyigoxoFV1ujkFbTf1V64Xlp1NCsgJ6eca7vGB5Zk+gBx
         w6FsrgkOYs6GFHdOdBJqiPfhL3o8DY2r5rn1nDYPf9BARV25ThctTvl4gG1GYDh6ol78
         pgOYaMR1MAqQKkEsOfBM9s7oKn2bXaE88duxRCsYUZ3Bkvapl1ctE9RBjWtLDXmczQik
         eJcBun68Mni1kxmoDfI0S6KhkBgHKoGQxwrf8QXkFBx1qRi3zBtJ8uQxZ3HrOwiqQxla
         srhg==
X-Gm-Message-State: ALoCoQmsFuMywmi6lpBSkRfNk/7odCbiMoqVQfGUMTz3qvmY1xn9YKx5cUyvLyFliXDwlq0x1fLf
X-Received: by 10.107.153.147 with SMTP id b141mr81887554ioe.49.1420487445082;
 Mon, 05 Jan 2015 11:50:45 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 5 Jan 2015 11:50:45 -0800 (PST)
In-Reply-To: <xmqq387yywm6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262029>

On Mon, Dec 29, 2014 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/copy-fd-errno (2014-11-17) 1 commit
>  - copy.c: make copy_fd preserve meaningful errno
>
>  Will be rerolled as a part of a larger series.

I am not expecting to reroll this as part of a larger series any more.
So if this makes sense on its own, please pick it up?
