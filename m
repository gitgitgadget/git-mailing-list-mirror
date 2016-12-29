Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F451FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 23:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbcL2Xex (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 18:34:53 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34693 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbcL2Xew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 18:34:52 -0500
Received: by mail-qk0-f173.google.com with SMTP id h201so145037855qke.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pFTB4IhRbdfobMAj23E0PSNDSLIHqQ2xkK1ivDj9VJw=;
        b=ddxuZ350mCtJzNw0Awp7iWgkoM0jqtldvKRlcKLiBkGEDxPi9UBEkqoHsv+JpGBqJ7
         cvdwsQWWcTlaEMEF4205GSI30RzUIZNz1IXJGHJSlCEE7l+q3PcIBwZQtN3HZrzWuCNn
         DDXze90Yy/H5swXA2OuHeeSzim5ineXUZVqCoZrI558F9z8NKr7E7mSsB1Q7M4RY4t+M
         B+wingHQ4K1+8VTfsLyrwRmjNzhV5pupU1PESqXwkbg3itTjW2DtefOU0O90inBAetdL
         qH5cIuEUTGUMro8VnII6oYXZ7uGO1eHJ80snwlRqKXogXp97QeN8SLLWsv9tC62U0ZxA
         MVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pFTB4IhRbdfobMAj23E0PSNDSLIHqQ2xkK1ivDj9VJw=;
        b=O3pYHaedMkqTmBCNykRsO7e1UDrJYVriB/+KtakoyqAnW6bdfJcOJDEnibHuKMTLxH
         sLI1PEtAVqBJoYg5m8OgaAer3GXoTnNe3vEClL20lR90Sz2hytUvMJGfYmvnCIoykiv2
         xUuQp6qT5uKTc8kjA4oIHdGFJQ+oS/9D4cT11XiSZMyrEwBHNMS7yue4fPPsTS8jjtFC
         66mn/APZCASGDwsd9FH9lEJGUGL0OGi7LDa12tQPzNh7rUGMQ/sZtrsMoW5cHyJ80ldi
         DfPHQPPN2FbAjwXf1fP0zbCz9n2R2K5ZXYu99YYRVktuiqH2tjxRPvZFKQa16/uIYFKq
         pINw==
X-Gm-Message-State: AIkVDXKWaDGJ65i2KN1ZVPZsY9lVgUrBIEax+nx1GpxmNpOJWqHkDwdzvPQKIgWCCtrR3F6F44gSl1AEpd6k4Kmi
X-Received: by 10.55.105.129 with SMTP id e123mr45324625qkc.173.1483054491711;
 Thu, 29 Dec 2016 15:34:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 29 Dec 2016 15:34:51 -0800 (PST)
In-Reply-To: <xmqqpoka5pb0.fsf@gitster.mtv.corp.google.com>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
 <20161229084701.GA3643@starla> <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaAbCTsY_SddVMKMsLV0xyXNBFvxQ=J-20Cwdz31v4OwA@mail.gmail.com> <xmqqpoka5pb0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Dec 2016 15:34:51 -0800
Message-ID: <CAGZ79kZFCDiYt6q52t5XMw0aB2qHA9ODVkCQJSxrGckSV3+O8A@mail.gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Eduardo Habkost <ehabkost@redhat.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> IANAL either, but we have been striving to keep output of
>>>
>>>    $ git grep '\.signoff' Documentation
>>
>>>
>>> empty to keep Sign-off meaningful.
>>
>> Try again with -i ;)
>> and you'll find format.signOff
>
> Mistakes happen.  Finding an old mistake is not an excuse for you to
> make the same one again.
> It is an opportunity to come up with a way
> to correct it without hurting existing users by designing a smooth
> transition path.
>

knee jerk reaction:

1) Document why format.signoff is bad (even after a long
  office discussion I am not fully convinced it is bad. That
  may be because I am biased as I find format.signoff *very*
  useful. The cumbersome contribution process as laid out
  by SubmittingPatches just got easier for me as I have one
  step less to worry about. I haven't made a mistake so far
  sending out crap where I'll throw a temper tantrum if you
  apply it.

  So I would expect a maintainer of a project that uses
  email based workflow to write that documentation giving
  reasons. That person is currently consuming the automatically
  signed off patches, so I'd want to know their line of thinking.

2) If the config option is set, but no explicit sign off is given,
  put a different footer, e.g.
    git config format.signoff true &&
    git format-patch HEAD^
  may produce Auto-Signed-Off-By: ...
  whereas
    git -c format.signoff format-patch
  behaves the same as
    git format-patch --signoff
  that gives the Signed-Off-By as we know it.

  It is up to the upstream project to accept these new sign offs.

3) (later) warn about the option if it is set, giving the text from 1)

4) (a long time later) remove the option.

--
For 2) I am not sure what we want there, because this
has to happen in collaboration with all the upstream projects that
use sign offs.

We could be subtle, i.e. just use all lowercase / all uppercase
letters for this differentiation. Then automated tools that check for signoff
are easily adjusted. e.g. The eclipse foundation disallows pushing for
review if any patch is missing a signoff; Gerrit can check for that.
Gerrit is not case sensitive when checking for a footer.

I am not sure if there are any other tools out there that automatically
check for that, but I would assume they are also case insensitive in
such a case, as it is unclear to me how to properly capitalize the sign off.

This is an easy way forward for upstream projects., though confusing in
court later on.
--
We could also be non-subtle, very explicit, and each tool that
can add sign offs currently, needs to be explicit about itself:

    Configured-Formatpatch-Signed-Off: (for git format.signoff with config)
    # and others:
    Explicit-Formatpatch-Signed-Off:
    Git-Gui-Button-Clicked-Signed-Off:
    Git-Gui-Button-Shortcut-Signed-Off:

Once we have that we could add much more of these:
    Configured-Commit-Signed-Off:
    etc.

You can continue to sign off via just typing it, or by
    I-typed-it-signed-Off,
--
One of the problems highlighted to me was that you could have accidentally
configured format.signoff globally, but you're only allowed/desire to sign off
in a particular repository, such that

    Repolocal-Configured-Formatpatch-Signed-Off:
    Global-Configured-Formatpatch-Signed-Off:

may be worth discussing.
--
