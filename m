From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt string
Date: Mon, 13 May 2013 19:51:50 +0530
Message-ID: <CALkWK0=zqG6cyeZhK65nVQZunQinf=Ub=BPTJHx+ZWgAs2thag@mail.gmail.com>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
 <1368289513-8700-2-git-send-email-artagnon@gmail.com> <7v61ynsci8.fsf@alter.siamese.dyndns.org>
 <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
 <20130513091718.GA21636@goldbirke> <CALkWK0m+mG39W7RqU-9KfPWLnaey5pL+jvfdZg49ixsASE+QoQ@mail.gmail.com>
 <20130513110551.GT2331@goldbirke> <20130513111143.GU2331@goldbirke> <7vvc6noubf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubte9-0001Io-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab3EMOWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:22:33 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:56471 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab3EMOWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:22:32 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so11741063iec.8
        for <git@vger.kernel.org>; Mon, 13 May 2013 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HbS/vDSnFvZv+ud5ENL2QfWTZG8OGJ8+mhyEpmuYNfk=;
        b=0gawYgDScIo4QOhs+1fMp7FoLecRKkGQuCn/EXxZc1FWfe1e1AxZpOfAbRSkaBg76S
         Iof3kBuWT9asbtf3EQBxs7Bf3sTu2lBDnIukQGAzTQkuM72DPK5Q3MNN9P3iXURli44q
         Xv6mDpUcrmsIeysSK4Aqfmpjcgj+KpVJA7vYAzvAz8eblhwpMG38zyjcXCAw/tszWcCf
         ab1Clv3Lp2Sf4uOiswlfTXQQFQ2iOVIu4ZIqc4i9juJU+ZVpH9oIKEYc9uWcjtfCHgcr
         ABmKuWcIvaZ9MHr7ojNm24ZZZJwVt9zTrhqMdTv4aOdBKWv1GchiRQcMdvC+DiRpGk6+
         PI1A==
X-Received: by 10.50.66.197 with SMTP id h5mr9912540igt.63.1368454952095; Mon,
 13 May 2013 07:22:32 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 07:21:50 -0700 (PDT)
In-Reply-To: <7vvc6noubf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224151>

Junio C Hamano wrote:
> If you restructure the code to formulate "gitstring" to call a shell
> function to do so, people can override it and come up with whatever
> format they want to use, no?

The user would essentially have to implement her own
__git_ps1_colorize_string; a function that takes a lot of arguments
and stitches them together with color.  Much too painful for little
gain.
