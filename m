Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324582047F
	for <e@80x24.org>; Tue, 19 Sep 2017 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdISQUl (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 12:20:41 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:54726 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdISQUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 12:20:39 -0400
Received: by mail-pf0-f170.google.com with SMTP id d187so57754pfg.11
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jp/i6HkTbYShdrc7T0y7YyHbQpjjbCPoBc4BVyHEGds=;
        b=JlcIKzKNs4aLBC1Bk+2MadUhB/Q0Nh9DTqxdSe1IrDIEy4tEqpcM+PBFhdwY8zEqIt
         901g8pycaenHS/2/WNh7ONJM10cb67oOA6t9T+CEY4vdlj5wLfKMAflJ8tmpoGyDfsQo
         UaEscuI/59d8TD/EbsMYHAfMLwnb9n8MpQ7ferf1ex2xG99itdA3Gx+MaKYApsfUMpFt
         57r/pEVTrJh0QHWk5PIBFvsUoA0KAdDtaxGi+CaSUksPUR6KeLuWJbHJ5GZy6zqHhabc
         o2RByGEEjoJXhKJWprNYe9sEFuhibm4hkr5WG/4Y4RLzUhnRq9MZpmIRp4h6lRPrTxtI
         Zy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jp/i6HkTbYShdrc7T0y7YyHbQpjjbCPoBc4BVyHEGds=;
        b=hVq6nLfRlElriYz5gxBo8ab9gBRq3fK6wEnokU0PbEaJZFAxZG3WIncwW1Rr1Zu2xO
         rcA/4eIqNddFVS731NMsWiycF/a5GrRC03H/6bZmfAMrBtsIXrEwdPJ38vrlENf0hOdX
         2Nt6Nc2BTaCb7uqrQ7w+H/KqZsROoX1VEYuQJTTeqLWX3aso/+ma42CmDxOhc0kw+JwI
         BPq8fuGpMAQ3PQTQ2sOu22O7VzSD8zxCYJuJLVPcN7oB/qPQOwrQ7zmeRwXdzeC2CjLf
         SBjPfIl9BbigumnnP0oxSL3pupMnBZUKS16nzsTS1p8YN7HWFPAh2JpaOjXaWPK0o6Dv
         4ZMw==
X-Gm-Message-State: AHPjjUiC1lMWyv8t8wyQei3NE6TbCHkFFFp59UwtXzzQwLTq3bDx9tvJ
        QJYzu0nMWp9UT9iTeLRHhE8=
X-Google-Smtp-Source: AOwi7QA9WwbdJxYEE8NtLnJIE1UD9Uh5gMuuWCdIBnWfgaXOTN0g4mrupCH9ergHaJN1xByHkd+GcA==
X-Received: by 10.99.131.193 with SMTP id h184mr1784994pge.288.1505838038582;
        Tue, 19 Sep 2017 09:20:38 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id c62sm4443879pfl.84.2017.09.19.09.20.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 09:20:37 -0700 (PDT)
Date:   Tue, 19 Sep 2017 09:20:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
Message-ID: <20170919162035.GB75068@aiede.mtv.corp.google.com>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
 <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
 <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
 <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox>
 <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709181637420.219280@virtualbox>
 <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> What you need is a tool to aggregate this information, to help working
> with it, to manage the project, and to be updated automatically. And to
> publish this information continuously, without costing you extra effort.
>
> I understand that you started before GitHub existed, and before GitHub was
> an option, the script-generated What's cooking mail was the best you could
> do.

On second reading, I think you're talking about GitHub's code review
("pull request") feature, not a bug tracker.

There's been some active work (some that you've been involved in, I
believe) on getting information from a GitHub pull request to the
mailing list.  One possibility would be to get information to also go
in the other direction, so people have information about what happened
to their patch in one place.

I can also see why you are directing your attention to the maintainer
for this one, since if the entire project adopts the GitHub Pull
Request workflow, then the complexity and other flaws of such a
two-way sync could be avoided.

Unfortunately the maintainer is not the only person you'd need to
convince.  You'd also need to convince patch authors and reviewers to
move to the new workflow.  There are likely some potential
contributors that this would bring in, that would like to get involved
in the Git project but had been deterred by e.g. the mailing list's
aggressive filtering of any email with an HTML part.  Meanwhile it
would also be a large adjustment for existing contributors, so it's
not risk free.

I personally like how Bazel[1] handles this.  They have two ways to
contribute:

 A. People used to GitHub can use a pull request like they are
    accustomed to.

 B. People preferring a more structured code review can use Gerrit.

Having only two ways to contribute means that the code review
information is still easy to archive and search, just like our mailing
list archive.

(Actually, an example I like even more is Akaros[2], which also
appears to accept patch contributions by email.)

Adding new ways for a contributor to submit a patch would mean that we
can experiment with new workflows without getting in the way of people
using an existing one.

Thoughts?
Jonathan

[1] https://bazel.build/contributing.html
[2] https://groups.google.com/forum/#!forum/akaros
