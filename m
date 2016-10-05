Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F4167207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbcJEJrN (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 05:47:13 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35791 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbcJEJrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 05:47:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id s13so86106963pfd.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9/KxYFegJbXlpufJwDWtZDarN24CqmydP1yHZeOyCc=;
        b=ve3y5wnZqt/qOXTCUdzIVb/iaMndI5iTVu3jbDFqa0zEuxTt2l2VLwRidyB1YlQ9Eg
         S2EsER7mUitt7jueKb1Ne57Nk+WMQssItxjVi8VnjHXxiaAEBc655W1+PUQZah5domKZ
         JTKQ9+NC0n9fhASV1e83kObuQu78/tJPUmmqGRXJa4N6kOaUzeLpi2vALRoe0Qy6Cefz
         /ntU7sgG+0pKGG8tbNWpR05BgkfRJj6q6DqrWQrCFYE9Ek3G4H564VoQf7mn164cBvN+
         dyj6XV4SOWBfaERKfi0KcPOCIQ+zaEdWjvdr6ek6SFiLKTl/U3N2DLhJmFnj8uiu0oaX
         k7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9/KxYFegJbXlpufJwDWtZDarN24CqmydP1yHZeOyCc=;
        b=hpy5iMurNIGVM3aDA2PkIjs8kAQX25WS1mUVQce6wAohMoa35d7IeXR3TZpAYukhwj
         l5Tv3W2IZHzBVfU8MfrDJne6atDS9NErM6OImM3saQEM0mvsSxlTyhN9zMINHpMGjyYG
         71t3eX9x4Iq9oJyn9Phd9yCCpGqEgJJJLBCWFCWdI17aKLekffYxAJOq3+1kEPV9EGUZ
         ga7h7FuO2+T5xjXd1EoxtiOe4ZOqbUpDewnKNlFVoeQNFCsNTmxYttENMncd7QUuWIRy
         sW2CyIcgcgekQhyOfGyCu9jv51d0ZEO9/PBjQw8fP48tdLjxB7lkEe5V2qM04zrpbU17
         F0BA==
X-Gm-Message-State: AA6/9RnhrK1oiS/qkwTAObQVE13xSvdpiCw4HPsls179YHqEE93gBTcFGdLnuUjeV0FedQ==
X-Received: by 10.98.129.132 with SMTP id t126mr5485650pfd.59.1475660831231;
        Wed, 05 Oct 2016 02:47:11 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id xo5sm5271130pab.13.2016.10.05.02.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Oct 2016 02:47:09 -0700 (PDT)
Date:   Wed, 5 Oct 2016 02:47:06 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Josef Ridky <jridky@redhat.com>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
Message-ID: <20161005094706.GA18574@gmail.com>
References: <88486231.114620.1475474318974.JavaMail.zimbra@redhat.com>
 <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
 <CACNzp2mANqmciMzvCahM_+=RnZYtU1SK9DRS2BmQru1fZY_wUQ@mail.gmail.com>
 <597741871.671633.1475558327029.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <597741871.671633.1475558327029.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 01:18:47AM -0400, Josef Ridky wrote:
> Hi Anatoly,
> 
> 
> | Sent: Monday, October 3, 2016 5:18:44 PM
> | 
> | Hi Josef,
> | 
> | 
> | On Mon, Oct 3, 2016 at 8:36 AM, Josef Ridky <jridky@redhat.com> wrote:
> | > In several projects, we are using git mergetool for comparing files from
> | > different folders.
> | > Unfortunately, when we have opened three files  for comparing using meld
> | > tool (e.q. Old_version -- Result -- New_version),
> | > we can see only name of temporary files created by mergetool in the labels
> | > (e.g. foo_REMOTE -- foo_BASE -- foo_LOCAL)
> | > and users (and sometime even we) are confused, which of the files should
> | > they edit and save.
> | 
> | `git mergetool` just creates temporary files (with some temporary
> | names) and calls `meld` (or `vimdiff`, etc) with the file names as
> | parameters. So why wouldn't you call `meld` with the file names you
> | want?
> 
> 
> Because files, that we want, are temporary files created by
> git mergetool and we are not able to change their name.

[I didn't see your original patch, but we actually prefer inline
 patches in the email, as sent via `git send-email`.
 Documentation/SubmittingPatches has more details.

 Please also make sure to add a test to t/t7610-mergetool.sh
 exercising any new features.]

Are you proposing support for config variables to control how
the temporary files are named?

e.g. something like "mergetool.strings.{local,remote,base}" for
overriding the hard-coded {LOCAL,REMOTE,BASE} strings?

I don't want to over-engineer it, but do you want to support
executing a command to get the name, or is having a replacement
sufficient?

Now I'm curious... if replacing the strings is sufficient, what
do you plan to call them?  I can imagine maybe something like
OURS, and THEIRS might be helpful since it matches the
nomenclature already used by Git, e.g. "git merge -s ours".

Since these are temporary files, changing these names might not
be entirely out of the question.  This might be a case where
using the same words as a related Git feature might help reduce
the mental burden of using mergetool.  OURS and THEIRS are
probably the only names that fit that category, IMO.
BASE is already good enough (merge-base).

The downside of making it configurable is that it can confuse
users who use mergetool at someone else's desk where they've
named these strings to "catty", "wombat", and "jimbo".  This
doesn't seem like the kind of place where we want to allow users
to be creative, but we do care about having a good default.

OURS and THEIRS are intuitive names, so switching existing users
to those would not have much downside IMO, and it's a little
less "I just merged a REMOTE branch" centric, which is good.

Do you think these names should be changed?
If so, did you have those names in mind, or something else
entirely?

cheers,
-- 
David
