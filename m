From: Stefan Beller <sbeller@google.com>
Subject: Re: Please consider extending .gitignore to support setting of a file
 size limit
Date: Fri, 8 May 2015 15:13:59 -0700
Message-ID: <CAGZ79kazifa82bob5RvL4gGarkKympb-aLDBmhT=y7ddTj-aTg@mail.gmail.com>
References: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com>
	<xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
	<20150508065459.GB31516@vps892.directvps.nl>
	<20150508070906.GC8248@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
	Roger Mendes <sproger1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat May 09 00:14:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqqX0-00020h-35
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 00:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbbEHWOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 18:14:01 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33397 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbEHWN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 18:13:59 -0400
Received: by iepj10 with SMTP id j10so70769249iep.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=71t6x9e/3AJDhms0maV3mwuv1nbrliw9jhnRcX00zUY=;
        b=XNLvfqGUroGQ95gRJhqYnPPzFVvrbF8dVSbwMn9qttQx8pnuTGduXkY6Pi7Z1jCacO
         lHLUcAjD+WiKsi8u9GZQlV5/FV+mTklwtiB1KWQhSohRD0pciNNP3DYb3tmHFM87Owxq
         e9igqMvEMDzYOOaOUv/u/0G9CjhGnQuKbdwK8XttpLFWRSm/AYla+DkBh0cr2472dv8u
         x0LSrxdkjDVZRpygQWgp7R61x3oiDxgSNFvnEBsF/Z7+S6lLtZ4YLa5uCi+wU9bxVJTJ
         bV30nVZICXFfUMhYxEZMaFSkc6xj6UQZMaOdshZz5VFnou0/dr+ecVzhQ1ePBgUwQNaL
         lOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=71t6x9e/3AJDhms0maV3mwuv1nbrliw9jhnRcX00zUY=;
        b=T1NhdZb702sOv3SFjvIPo80QJS4s7ZtCXXtlCUYZ1bPRvGeX2pne7huQRVSm7mFDvQ
         hcYP8ppm/6hkk4cESd2ev1d8zd54ONvMlQMhWapQEYOY4/ui8p2GJ/DTV6uOC0q3fEkS
         2YgaYK4a5XjjmZLjsp1g8A7Iqy9/0spIoPNFAfgTHmrSZFoA0pazxuYJ/J7r4MSK08u2
         UqFohD6Gt+5gMBnqmHOCY0ccN9emEDxKwA1k0yhQjYVoqsFzUlASYdWZqqrD2/MBt+iF
         C7vWz9pTfLmfkhUnuZKpnJwoVT2Rdc7rC/UkNuaRl+ozftda4hwkT6cVok3BXTI4SAOP
         xTSw==
X-Gm-Message-State: ALoCoQl6iI7lIGGX3ftLO6z+gDwrcyT1QQKoGR0J2yBlWXgRfikQ3mZeyR6T8Ee3FShkrWQLhr0M
X-Received: by 10.42.213.136 with SMTP id gw8mr277202icb.95.1431123239182;
 Fri, 08 May 2015 15:13:59 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 8 May 2015 15:13:59 -0700 (PDT)
In-Reply-To: <20150508070906.GC8248@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268679>

On Fri, May 8, 2015 at 12:09 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Fri, May 08, 2015 at 08:54:59AM +0200, Kevin Daudt wrote:
>> My experience in #git is that people want to prevent other people
>> accidentelly adding large files, resulting in all sorts of problems,
>> which takes a lot of effort to fix if you're not an experienced user.
>
> I second this. In #git@freenode we often get people trying to reduce
> repo size since they or a collegue accidental added a huge binary file.
>
> They do a filter branch and remove that file. However then they need to
> do a forced push. And the person (the collegue) that didn't had enough
> git experience to understand why it was a mistake to add a big file, now
> ends up with having to sync with a rewritten remote.
>
> So I can really see that there's a demand for such a feature. However, I
> wonder if this shouldn't just be a pre-recieve hook?
>
> If we want to inform the user, we might just add a pre-commit hook for
> this.
>
> The problem with pre-commit hooks is distribution of them. As it is with
> making this a configuration option. There's really no good way to share
> configuration and hooks between git repos today as I know of. (Yes, I'm
> aware of this beeing a hard problem due to security concerns).
>

Any problem in computer science can be solved with another layer of indirection
they said. So:

Maybe we can just distribute some good defaults (or your internal distribution
for git can ship adapted versions of the default). And instead of just running
a hook, maybe the clone/fetch could tell the client to enable these
predefined hooks.
so maybe we'd need a fetch capability "recommended-hooks" which could look like

    recommended-hooks=<name>,<sha1>

The name would indicate what hook you're interested in such as
.git/hooks/pre-commit-warn-huge-size.sample and the sha1 would be the
sha1 of that default hook to ensure nobody has tampered with that script.

I am not sure if we need the sha1, maybe that's overengineered. I mean trusting
a default script is as much as trusting the git binary on your system, isn't it?
