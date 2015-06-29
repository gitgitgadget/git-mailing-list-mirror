From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 00/44] Make git-am a builtin
Date: Sun, 28 Jun 2015 22:01:18 -0700
Message-ID: <CAGZ79kZyq_BrYKA=+=Qkg9xzXE=2fFr5U_DJFz6GQmm62MxVAA@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 07:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9RDA-00026Z-P9
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 07:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbbF2FBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 01:01:21 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34779 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbF2FBT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 01:01:19 -0400
Received: by ykfy125 with SMTP id y125so105542811ykf.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X07Dawhv7Lamq6RfYt4LO05Bbv7qois0uqeW4h0NfLI=;
        b=ZEPCqIBSaTyPQDjDZ9flfV2N4Hqu8zVJvDu+oLhoKIYJJe4hLen4xO33Q2jkMybQLv
         ZWwLTvHlo7ZtnglOBlkNsa5okqYtNqOSKELVGGJ7OqhT38GPecmq7Avj0/6WfsQ1P7do
         tpJ3DbO+oen+/NdQuIp9cumZg7j4x93V+gWowui60U6/kLumBfCCyv3H1WywiViYEr4H
         EsJgY0i4gGIok3MXuFYzbNZY4zQXjG1OHr0tpvMg2XwZbY1v2+eqN2ys4Bl9elwwFYBo
         okA+gArNcMVIrWU/W1cmWXZ67+kZ29u3bYBlqPshXr6VzR7/y8I5XOym9J14CN+mOGys
         Dzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X07Dawhv7Lamq6RfYt4LO05Bbv7qois0uqeW4h0NfLI=;
        b=GumQyB/1U9eC+85YPRX/acJXIPOMcFuE03HryL8E1NJi4ftg778scc9JQfNe6hNQ2B
         JHsprtY4iMUuDgHoOj94oQHmLVkXhE09HT/pHxNySnDH/JrvkNeIyoLy7fWfy3gEc2wZ
         AZvo6e4lbVr9BP/8rUXCdWzYQZ9YXP+CA6e51nLyqTxUP0dxthKyat1/fnv2UQGa8PA8
         XzOz/uWHuN8nuVV9ky18CgmsKz2vmYCEkx+WKOmmIgC6rtIU0d+SI/V10EZ/JyEz4hbU
         oERFU5/XBNLEYhxi359MbLWpnEsGO8FWFAAuUbS9ZpPPAlp84AqhYljVJuquy0n7Nv9g
         OPAw==
X-Gm-Message-State: ALoCoQkkhlKSI0h9WzrCakx8zqDchnA69rSd+Qz50NKWvOO7dm00l05mCQJ5uuFFVHCxkCeSnv9l
X-Received: by 10.170.43.193 with SMTP id 184mr16513385ykl.119.1435554078368;
 Sun, 28 Jun 2015 22:01:18 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Sun, 28 Jun 2015 22:01:18 -0700 (PDT)
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272935>

> This is a re-roll of [WIP v3]. This patch series is now out of WIP, as ...

> This WIP patch series rewrites git-am.sh into optimized C builtin/am.c, and is
> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].
>

I assume the later is just a left over from an old cover letter. :)
