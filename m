From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 22:03:36 +0000
Message-ID: <CAH_OBif=Zr-3GO3CE4D6O3wJJZysB6=vvmA37K6ujTHTr-un7w@mail.gmail.com>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
 <m2mwz3odys.fsf@igel.home> <CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
 <m2fw4vod81.fsf@igel.home> <CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
 <m27gq7ochp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:04:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJvJ-0001ej-U0
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965584Ab2J3WEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:04:01 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:63187 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965440Ab2J3WD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:03:59 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so599920lag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JKf+An9jFoBTdfEbO9udGCyTT22wKqUBRi3XWJ+M9Ts=;
        b=julN/YPBBP7u7BKdNLq0FHpCLA8vvuazFA6fsC041TquidtXLEEJbXE1prd+pXtsc2
         w1pzzN6WiX/bqtxRIr0ezSX8IIzRuGxTFAYjSoefg5YZWHcbe/u26yRwhj0C1/b3brcL
         iTB43ieYjLf7QGyG9T4zj9hW/J2sIt/+P/KoKdLB7CxDiDgWWTCt+/OmRqfmgYyrexOJ
         w4mwmyX0RJa3MO/MV2G3QQjmJVUkv690j6mEQxMhW2Ia/oSOYzbKl1693ZyMu44vwk7L
         Ja0lXPwVDxBNnNgJBIgbwGGST4wTKIVd65fi/MAXM6gmWs/2nvoK2p1iRD3UcES0Jp+K
         ufxg==
Received: by 10.152.114.100 with SMTP id jf4mr32097795lab.47.1351634637574;
 Tue, 30 Oct 2012 15:03:57 -0700 (PDT)
Received: by 10.114.63.42 with HTTP; Tue, 30 Oct 2012 15:03:36 -0700 (PDT)
In-Reply-To: <m27gq7ochp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208755>

On Tue, Oct 30, 2012 at 9:50 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> shawn wilson <ag4ve.us@gmail.com> writes:
>
>> why is this different?
>
> You didn't tell git about t2/one/test.  You need to add it first to make
> it known.
>

and once it's added, status says:
#       renamed:    t2 -> t2/one/test

that's not exactly true, but...

i guess the point is to only track files? if this is the case, i still
disagree with what status is reporting but i suppose it's fine (from a
bug point of view).
