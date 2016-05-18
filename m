From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/21] i18n: sequencer: mark entire sentences for translation
Date: Wed, 18 May 2016 15:28:57 -0400
Message-ID: <CAPig+cQzsxMMv1XSdStFDs08C3qvb_Ttb4oVeN3T1si85v=f7w@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-6-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed May 18 21:29:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b379T-0001h4-BC
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbcERT27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:28:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35962 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbcERT26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:28:58 -0400
Received: by mail-io0-f196.google.com with SMTP id a79so507223ioe.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=K8ryo/jPOjQjwPpXrrsYUxGMuy7SaA+uYFKbGbGN3cU=;
        b=ac6XfbYGaQ55QpbLq1g2UFM9c+RKqJbXtvW0/vD5+++vId/40FtPiJREO7ngb6l9i5
         wW3y7bO3gvI9zqrbB9ZRgd5118JJ+KyaXhVofWjlQgvLu3wzTyesb5Yhgrn4ubGCyN/c
         wB7vMLlRc/Wm7BGWPHeX6dQGRPn4hI+YIh1+j22K4x4g2Y/RjLWIfCOwEug18WaN4wTB
         GpE1rpgQffeUblbU3lejZOXdlXd3gaRHMJFBbCw9MLmlBAqcpBIHXG6eZlR+Xq8ACqgJ
         dYQpBzW0onhtz6G7Ipvy76TpHAdGh5Vu1CCnRD/p7RIgZP2EHBQGZe522q5cLiQ7++i5
         nGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=K8ryo/jPOjQjwPpXrrsYUxGMuy7SaA+uYFKbGbGN3cU=;
        b=NfdwdglUNi9/7tTdKydrt6CZeyW+If+bOD9Wp/hfd5zn/nzxKDmslg2cz3+Wbwob3n
         XZogu/O6m8OJOUM/0qISV+fUwIF8TWpKxN2vGB+S8fwjNzkprLWyOM9nCcfTDV3KgW9B
         a02WrQ6TPd4KDcCBQD73UWcE7hpusk9VTVT2l2xcqJ1yr/hEBX8HVsFRRw95whn9L/tY
         OUyqu+4h7+af9MOyW4xeYNJ908FuG4yjx04Na3+a5AvI1Y+f9TCleGq1bn4eCU/eHAfw
         HZ5Nd1x6SJBkx8ZC3v6fpO3QfZcOuZSmra/yf0oApKggGiR10bhjslJKS8az0vZgay3T
         cfrw==
X-Gm-Message-State: AOPr4FXx1U51nPDJGMqZpC6dku3cewLnvAKk+h4p/3nRTGKXKAccwue0bvIq6lm/6FUNH3NQMDWrsgBh1x4apQ==
X-Received: by 10.107.47.37 with SMTP id j37mr6413563ioo.168.1463599737588;
 Wed, 18 May 2016 12:28:57 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Wed, 18 May 2016 12:28:57 -0700 (PDT)
In-Reply-To: <1463585274-9027-6-git-send-email-vascomalmeida@sapo.pt>
X-Google-Sender-Auth: t3CS8rLDKVqN8AcqOq19GTBSO3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294995>

On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> Mark entire sentences of error message rather than assembling one using
> placeholders (e.g. "Cannot %s during a %s"). That would facilitate
> translation work.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -697,9 +697,14 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
>         if (action != opts->action) {
> -               const char *action_str;
> -               action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
> -               error(_("Cannot %s during a %s"), action_str, action_name(opts));
> +               if (action == REPLAY_REVERT)
> +                     error((opts->action == REPLAY_REVERT)
> +                           ? _("Cannot revert during a another revert.")
> +                           : _("Cannot revert during a cherry-pick."));
> +               else
> +                     error((opts->action == REPLAY_REVERT)
> +                           ? _("Cannot cherry-pick during a revert.")
> +                           : _("Cannot cherry-pick during another cherry-pick."));
>                 return NULL;
>         }

Similar to my comment on patch 3/21, since the "actions" are literal
git commands, it's not clear why this change is helpful. Perhaps the
commit message needs to do a better job of persuading the reader?
