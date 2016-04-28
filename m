From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:34:31 -0700
Message-ID: <CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:34:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avrhs-00020Q-7u
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbcD1Ted (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:34:33 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37305 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcD1Tec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:34:32 -0400
Received: by mail-ig0-f173.google.com with SMTP id s8so1576806ign.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cdCvmAk/fX5PJBOsdcZOz8+pMEWP2kA4qrWHq3xhXeo=;
        b=pwFmEIgtz87tA5KxegN19wuPLAObqOuIvaF27yEeC0qx/5AIiL8I8xENyP2uixrfDt
         3eLrBi4FG43//NZf+ZMbPqPPeyfRQkFbE+YBLIHZp/EH/Sy8ueSubV+DV1LCNMAh8kjq
         Itp9WDbJho9iqDb+rJfSmgrEDsX5lf0BlH2vGnXWEwOS2f8ONosizjl9KOCXx7YqK5zD
         fERDp4BWGetBBIRLdDZ2WOYBt6chwtCy5Tz4LDeekVStmiCrcQXc/4NGf/bAiXX/N/QM
         gWyIEFkBaeJSBagMXItungtxxN+DbGMQABrjNwt5ph4getPNR672tZyGxNnIyYI5KIQH
         cblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cdCvmAk/fX5PJBOsdcZOz8+pMEWP2kA4qrWHq3xhXeo=;
        b=UczWzQt29iySl8opZXBrSJs7zK59B9TYtZ6qO+KDlsUIIb8MuzkpYgLMJZQwJXARsi
         6ad9T3eb2XXb/0Km46P8D/Xtg+axVZ0T05ouKIHqTurr8AeTRXRgaRQfZpE+qPmpL4LB
         ZpbsaNdwokb2MooKSzmkTiKKQ0VX6bFNe0JH0DJExF9IBO4KzyE8/Uor9snWctpinyJV
         qEfrV/HaSaJfnm01P42utoHqhm9KLXuK6pGGXilOb/j8AU6k8hPwzwNkoO9GN7rtM811
         xQMkBURrHBQclxs3srmL3bUtdpcJv7Ve79pswxBRQvlnesm9LzidCwfFioM5c1oJ6fxy
         wUpA==
X-Gm-Message-State: AOPr4FWby+6HhzNemJBQiqgrRUCeQDVYk6o7SsLUTsX2pOj18DiIwtxkrZAveeum8VW3GN6HVvzFnHj8GQAWWq/V
X-Received: by 10.50.111.15 with SMTP id ie15mr21062701igb.94.1461872071274;
 Thu, 28 Apr 2016 12:34:31 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 12:34:31 -0700 (PDT)
In-Reply-To: <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292940>

On Thu, Apr 28, 2016 at 12:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> It's definitely sufficient, it's just annoying if a user shows up every
>> week and says "I want X.Y", and then somebody else shows up a week later
>> and says "I want X.Z".
>>
>> Are we serving any purpose in vetting each one (and if so, what)?
>
> Personally I do not think we would need to filter _anything_ if we
> can tell that the user directly said
>
>         git -c var1=val1 -c var2=val2 $cmd ...
>
> and "git $cmd" ended up needing to spawn another "git" subcommand,
> possibly in some other repository (i.e. "$cmd" in this case is
> likely to be "submodule", but in principle it does not have to be).
> If the user somehow gives variables like core.worktree that are
> inappropriate to be applied across repositories, that's user's
> problem, i.e. "don't do it then if it hurts".

So when going with that philosophy, the user might be missing
switches like

    -c-for-this-repo-only core.worktree=... -c
submodule.worktree=align-relative-to-parent

i.e. when shifting the responsibility to the user, we need to have
switches to pass options to the repository or a subset of submodules?

>
> If we are doing any filtering, however, it is always hard, if not
> impossible, to take away what we originally granted, even by
> mistake, for any reason, even for correctness or for security, in a
> later release.
>
> We probably could sidestep it by introducing an end-user
> configurable "whitelist" somewhere.
>
>
