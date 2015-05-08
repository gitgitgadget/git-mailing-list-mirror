From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 8 May 2015 22:57:08 +0200
Message-ID: <CAN0XMOJ6XnA+WAnpvMANSh_FnLoDyZ++5v9M2R-ZdOLHbSiJLg@mail.gmail.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	<xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
	<CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
	<xmqqa8xekeb2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:57:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpKu-0004Ej-D6
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbbEHU52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:57:28 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35829 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbbEHU5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:57:09 -0400
Received: by widdi4 with SMTP id di4so43431859wid.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ftH2110EIHFT65gKF3CnzMgg0pVeWwZTtkCHw6LNwOA=;
        b=UA7ezUXz1uETtY2pGCxC1DHFDO/KWPcN/2tXjwb2M3JB9WQ5ad2U0zVDbi1ZqrL1CB
         32uJ67OyWcGcxGnKtjamQdi5nx9MhmKC0MAmK4eceseG4qxx22ZLGiGMPpqf93S0vSTc
         tEGHBTi3obRXuPGdmMP12dmKCcbUBzR8RHoK8sJbk9nym3QGUu5sE4crBMWMjgEoBjpk
         kSsuZrAlwZYi7cVgJPx8HVLoaaxX4vRVVIwoaKVRwLa5KlJSSyPtGixhlAVkH31jLjuf
         YLShMbOAkak1yZRW4cw0HHou7/XQ/txzGRs/aHcoZTa3rz55PFYpdjnqE7oijNJEtdFk
         BSFA==
X-Received: by 10.194.97.196 with SMTP id ec4mr10907923wjb.3.1431118628461;
 Fri, 08 May 2015 13:57:08 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Fri, 8 May 2015 13:57:08 -0700 (PDT)
In-Reply-To: <xmqqa8xekeb2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268667>

Junio C Hamano <gitster@pobox.com> wrote:
>
> I am not sure how that changes anything.
>
>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>     error: that commit is a merge and you didn't give me -m <which-parent>
>
>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>     error: the commit 38e707... is a merge and you didn't give me -m <which-parent>
>
> Puzzled.

It doesn't change anything, obviously.
The patch was about showing sha1 in 40 character or 10 characters or so,
in the current messages.
