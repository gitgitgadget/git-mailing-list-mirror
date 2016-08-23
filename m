Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343FA1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbcHWQO0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:26 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33246 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbcHWQOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:25 -0400
Received: by mail-ua0-f182.google.com with SMTP id 74so253231011uau.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZbuTKCLe8U1uBRQAJzAUuQAgzqU2oM6zobaylqyyLQE=;
        b=Ex7jMp7C5B2hcl8VXC/0FoxISFD3OMKYJ2rzChXBZkTponeh61RgQRocquwJkzWA/v
         8LL5URG2lGDMxi0l+cLf9BIaN8u2ZYsNk10y8WYg1qBv6mymdtwZ26BU/UGjIhgSY6jJ
         mx5UG5xlD2EEShLpw+b/1+h8fhKRpryFnmYIJ+Vj6FzCoBueqvetzc33LoxZi7C1pRBY
         sd0JZw2DQQA91oooePWMPdcf8C96A5311yvLQ68/+TYqHaCBin3Fp5390QDpTRpOGYAW
         Tl68lM/k4eugyMdF8BjzSGzFKhgD3RDmdtcIL43ohxlLCgg2xyq/CitdUVogOKAKPPQO
         KO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZbuTKCLe8U1uBRQAJzAUuQAgzqU2oM6zobaylqyyLQE=;
        b=mNoVFP3DgdJlnp0+iM9bXCWE4xoC+jcR1xA5o+/USeOJGNq7bsgNEPHjvLTrSYkXNp
         poExShqxrzHafPio9Hoy/iweYAlWKRJ58/AT9f+uiKR6ugsQN42raRW4CAsPyyN/XKlw
         6yVi5qDPDsuoNZrQME/QQAIXJwSKTA6/LvnV51pm9Ncx9GPp2+EQo0Lm4BUAM9bagf0x
         mvOE6wUo8+GI4fAJKz7FBYq90Ag77YS8wAd+mM/OcCj7GtVEJAVyVRZWagnY6YvYL8u+
         DlxHq+GCEnp5dIS3l2OD/etKUarsSRL1YYJSnSl2WbON3KIR01Nzn84KqS1esEa0RwB7
         0VcA==
X-Gm-Message-State: AEkoouvJAbDPFr1fFKOsRpjpximsmXe1Q71v/oO4WtCQuJhzXO3dpCHzSvt2ncxWjDV6PqeckvmLpWM1zrOTvQ==
X-Received: by 10.31.176.134 with SMTP id z128mr15051356vke.86.1471968864048;
 Tue, 23 Aug 2016 09:14:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.85.4 with HTTP; Tue, 23 Aug 2016 09:14:23 -0700 (PDT)
In-Reply-To: <20160823055418.GA5990@whir>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
 <20160823030721.GA32181@starla> <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
 <20160823055418.GA5990@whir>
From:   Lucian Smith <lucianoelsmitho@gmail.com>
Date:   Tue, 23 Aug 2016 09:14:23 -0700
Message-ID: <CAHLmBr3Yn1tVhijmgRwd8hyxgasdc2VtfNi6pYP5FbEHjjb3Vw@mail.gmail.com>
Subject: Re: git-svn bridge and line endings
To:     Eric Wong <e@80x24.org>
Cc:     Alfred Perlstein <alfred@freebsd.org>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick responses!

My situation is that the git side is entirely whatever github.org is
running; presumably the latest stable version?  They provide a URL for
repositories hosted there that can be accessed by an SVN
client--somewhere on github is the 'git-svn bridge' (as I understand
it): something that receives SVN requests, translates them to
git-speak, and replies with what SVN expects.

There is indeed a .gitattributes file in the repository, but the SVN
client doesn't know what to do with it.  My hope was that something in
the bridge code, that translated SVN requests to git and back, could
take the SVN request, "Please give me this file; I'm on Windows" look
at the .gitattributes file in the repository, and hand out a file with
CR/LF's in it.  Conversely, when SVN tells git "Here is the new
version of the file to check in," the bridge could look at the file,
realize it had CR/LF's in it, look at the .gitattributes file to know
if it needed to be converted, and then convert it appropriately.

I can imagine a full-blown bridge that could even translate the SVN
EOL propset back and forth appropriately, but I'm not sure if going
that far is necessary and/or helpful.

I don't know if this is the right mailing list for that particular bit
of software, but it at least seemed like a good place to start.  Thank
you!

-Lucian

On Mon, Aug 22, 2016 at 10:54 PM, Eric Wong <e@80x24.org> wrote:
> Alfred Perlstein <alfred@freebsd.org> wrote:
>> I hadn't anticipated there be to translation between svn props and
>> .gitattributes, it sounds a bit messy but possible, that said, is it
>> not possible to commit .gitattribute files to the svn repo?  Even in
>> FreeBSD land such small token files are permitted.
>
> I'm not sure if an automatic translation is necessary or
> desired (because of a corruption risk).
>
> Perhaps Lucian can clarify the situation for his repo.
>
>> As far as documenting svn-properties, most of the properties are
>> used on the Subversion side either by subversion itself, or by
>> scripts in the subversion repository.  Perhaps a blurb "see the
>> subversion documentation and/or your local subversion
>> administrator's guide for properties and their uses." would suffice?
>
> Yes, perhaps with a workable example Lucian can use today with
> any git v2.3.0 or later.
>
> Thanks for the quick response!
>
>> Opinions?  Happy to look into it.
