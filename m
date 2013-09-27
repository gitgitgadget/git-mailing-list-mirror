From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Bug: [hostname:port]:repo.git notation no longer works (for ssh)
Date: Fri, 27 Sep 2013 10:31:35 -0400
Message-ID: <CABURp0pNcLEELwg-putH_Wtab-gTrMXTB7uGPMZSLfgXnFttew@mail.gmail.com>
References: <87vc1mg01t.fsf@aeneas.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Morten Stenshorne <mstensho@opera.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 16:32:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPZ5M-0006RQ-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 16:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab3I0Ob5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 10:31:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45520 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab3I0Ob4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 10:31:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id hn9so921765wib.11
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=764L8m2+knv7x7wiUUSmR1PdCEXV+bvtLDglC7Ok+9o=;
        b=uCkFaWh6/kxCZ3pGoIDkurzBnH0j/ShG+6gATXQLW0x11HNsjKobhQjYcuB0MDH9i8
         h1ESrq7dzxU80kP86SpV0S/TVjmWjQs7ZkcjCBplhKLu6JScrj00gqvc67MS8U6uamSv
         0+1UvqcF+80LbXy0uTVNZ06VuRBqsR2NYznX5GQN92KR8tzCnW/1eQxL/gKyNKBOPQyM
         KCMbZvNHfj2hcGKMb0OySPtOSosmbxuNCAUY0k3hHtYWAS71Bo2F2xh4QdEIPEGws2RS
         wu3MMNx9YSRSWHiHGWb9yxUPPY9Y0W2YCAj+kdk/PgqOxUB+Kt3iTyacaRxUlbUuoY+z
         uYMA==
X-Received: by 10.180.73.65 with SMTP id j1mr2984422wiv.10.1380292315437; Fri,
 27 Sep 2013 07:31:55 -0700 (PDT)
Received: by 10.227.145.73 with HTTP; Fri, 27 Sep 2013 07:31:35 -0700 (PDT)
In-Reply-To: <87vc1mg01t.fsf@aeneas.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235464>

On Fri, Sep 27, 2013 at 4:07 AM, Morten Stenshorne <mstensho@opera.com> wrote:
> If I don't go via the ssh tunnel (I finally have some VPN stuff these
> days, so I don't really need the tunnel thing anymore, but that's going
> to be a lot of remotes to update, so I'd prefer it just worked like it
> used to):
>
> -            url = [localhost:2223]:blink.git
> +            url = git:blink.git
>
> ... it works fine.


Until you get a proper fix, I wonder if this will help:

  git config --global --add url."git:".insteadOf  "[localhost:2223]:"

See "git help config" for details on the insteadOf config setting.

Phil
