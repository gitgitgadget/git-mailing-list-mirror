From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: send-email and in-reply-to = n
Date: Tue, 14 Aug 2012 13:51:11 -0700
Message-ID: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
References: <CALaEz9WQJBQ+OtDOhjH7Gz5Uw9Hu+82fOikf20WuTZy4RJsBPg@mail.gmail.com>
	<7vfw7qbb7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1O5G-0005dX-MX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab2HNUvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:51:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55227 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401Ab2HNUvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:51:12 -0400
Received: by yenl14 with SMTP id l14so969051yen.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oO41VXA3E47cie0ITS4p97dRK3Cv7B8cQHgkHq9+5gY=;
        b=PpWLfb8R+wdqB+MVf15YtqlNGrGlawHLSuhWkDSB/sGVJvJ4d2YQ6CpdrhkaIWJb3j
         1MFeQ5yMWReTJiHDJpJEAC8LzlM2FM38JxcWmUwQe8IVWx5OHxnuEh3j7HMZHJLm42fW
         pz8kL7pN6HtJgtF1140MYiaBjYJEDzxfpzCKZgMk1LN+mYMfSk0jnyUyyDMyrc2JoX+L
         MIto7aHdu1/4lISHGJ2zNZwdVABDytQkQs+ybj7jRRAg/oaWSDRFeP0+fgbnX5Hln5wf
         3WH9XF3ufZbo76oeWnzSs3bXBhRPtccYYV90ivt3U4URvW3hM8gHzh/rPP/mbb2YfrNG
         iF3g==
Received: by 10.66.89.70 with SMTP id bm6mr18615617pab.41.1344977471076; Tue,
 14 Aug 2012 13:51:11 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Tue, 14 Aug 2012 13:51:11 -0700 (PDT)
In-Reply-To: <7vfw7qbb7y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203451>

On Mon, Aug 13, 2012 at 4:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>> Can we throw up a big warning or just outright fail if someone types
>> 'n' or 'y' and hits enter for the in-reply-to question in
>> git-send-email? I saw a git-send-email sent patch with an In-Reply-To
>> header containing n on lkml today and it makes threading in my mail
>> client get confused.
>
> Yeah, I think it is a good idea to minimally sanity check the answer
> to in-reply-to (and possibly other fields); perhaps "does it have @
> and dot" would be a good enough heuristics.
>
> Please make it so ;-)

And if you do, please include the check for the value for the From:
header in the "and possibly other fields". I made the same mistake
when asked about that value just a few days ago.
