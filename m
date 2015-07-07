From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in
 favor of --force
Date: Tue, 7 Jul 2015 19:10:51 -0400
Message-ID: <CAPig+cQ_YnVbeuYN5TGaG1AyUXzBhK31LLon2RtsEhnVifVDVg@mail.gmail.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-24-git-send-email-sunshine@sunshineco.com>
	<xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
	<CAPig+cSSooqUcR_gW6vQP5Ws5v9p47bt7JWX4HgAyD6mFZynDA@mail.gmail.com>
	<CAPig+cSz3xS-pdtsiw14A80m7UqdwfGLy6kRdguHSUyAjfnWSQ@mail.gmail.com>
	<xmqqio9w3poi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 01:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCc0v-0006X4-GT
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 01:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367AbbGGXKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 19:10:54 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34038 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988AbbGGXKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 19:10:52 -0400
Received: by ykcp133 with SMTP id p133so5555094ykc.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8xCFgf9uQc8l5CDtZ3FVOFxQEHg5I+9/QmGzlFEVgl8=;
        b=LJikNUa3PBEe3LmWZ6r/REocG5uKV2hbLAEkuyICkoQraFyOq1P4FLZFi4krfC668u
         IDHYMvbWUJOzg2JLkYN8XEp0DftvQMDigfztL8JG125sqGCH3Wdk7zKmralZ1hp+kQOn
         RYOvOWuvP7d1XKjtuNmJfQTLirkwYFn7Jk1c6Q64yvdrg/ginweGOvSXqWonhpMG3gSq
         RS0O1wPWFKG9D3yfNx9LV8J3vfKXShJq3r1lMGL7psqaZBptUMVPJrASd7fFYpZn6f3u
         1nkO4gTtL6Cd72Ly+azUoZOafdoXWOKXgEZ9+U5ZPcyh6/5aLvvpEN1JpPHjWmzBjwOa
         ScIg==
X-Received: by 10.170.220.214 with SMTP id m205mr7867700ykf.13.1436310651855;
 Tue, 07 Jul 2015 16:10:51 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 7 Jul 2015 16:10:51 -0700 (PDT)
In-Reply-To: <xmqqio9w3poi.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: _-kIgrOMZuWkJn98m5giZm5NWJ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273617>

On Tue, Jul 7, 2015 at 12:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> I would not mind "git worktree add -f" to disable the "no multiple
> checkouts of the same branch" safety, but I do not think it is
> sensible to remove "-i-o-w" and conflate everything into "--force".
> That would force people to disable other safety measures at the same
> time (e.g. protect local changes from differences between the
> current and next branches).

I'm fine with dropping this patch.
