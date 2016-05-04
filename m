From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Wed, 4 May 2016 13:50:24 -0700
Message-ID: <CAGZ79kZs5zLAUdi53D=pTyFZF__73ZbW4o28C2hOuTV7_NfaDQ@mail.gmail.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
	<20160503235652.GA395@google.com>
	<CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
	<20160504150143.GA8575@sandbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed May 04 22:50:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3kc-0006Ld-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbcEDUu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:50:27 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36292 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbcEDUuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:50:25 -0400
Received: by mail-io0-f175.google.com with SMTP id u185so76427328iod.3
        for <git@vger.kernel.org>; Wed, 04 May 2016 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kiBHhSsejabjAsSPJmyIjj7yWpfB2OXHa5zTPMFXSOc=;
        b=dB1mZf3I/9XGwURa6cHt0nsq8BPmCPRst5iSPxNH/v1AQKU4DtZCVuFeQWbfBfU9/H
         EXte39jNyVuosPc1S4y3FWiYvBoN2JcN1sbEUyZysTcLhSoZnRBm+lxQ41wrITwPEzLH
         sppZ++QNh5ce8nF8hKG0Dmj3y/DMv73mHgrf3nde5iYXQDHXiD0xvxKVryOe6CHptQW/
         e8eJVEoTeHRN93btBBwOEUnD1xkaBhknqzPhebeGI34pb/ORBf0NojezPBGyTnwjF4vf
         ZQqWpdY7LYETSmIfzc0m4+DSUvOjXuc3JUJ3CzF+idCWyA6Vc0YcgwwBUX0pKvnz63hG
         EoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kiBHhSsejabjAsSPJmyIjj7yWpfB2OXHa5zTPMFXSOc=;
        b=m+FfF52Gy6LiXs8QANwQim1dXW3DQnmNoxDIoGnqBdaT3fUgceemevGFEWQmttGarG
         J37069FjHx7F+BSiMjKAmZ9dTDQHBD3mZ4d4+JcdF0oskURRWMWWC1/Ur3eJSLkXYsaH
         iqBN6H0JoMZftGCg2MReTlqlgs7XFufD8VhYiiRsHrrCbKUZyVfftmH/KTSycKFPIqsF
         ZFHPuhGcWu/arD4e1hLaoU4/I5l29zPDnyImkBUk9OwZCpnLCKgAv/KjG3JWrJjcVCiy
         vrt61OsBq6ViF3LZdUVHb1YikKBPHioBD9yrnNIhRNjljhZbAcAEvTYEaCo7Xyrxffc7
         IlBA==
X-Gm-Message-State: AOPr4FWCtkpUevJtsx6wXLR5GYgL42wgVpXG4FCaWPJ8OQ7egL2YlA6ZzoI4pdkwVQA/hw/2dQfRuvWs2krjMd8m
X-Received: by 10.107.174.205 with SMTP id n74mr13031841ioo.96.1462395024378;
 Wed, 04 May 2016 13:50:24 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 13:50:24 -0700 (PDT)
In-Reply-To: <20160504150143.GA8575@sandbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293591>

On Wed, May 4, 2016 at 8:01 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Tue, May 03, 2016 at 05:59:58PM -0700, Stefan Beller wrote:
>> On Tue, May 3, 2016 at 4:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > Stefan Beller wrote:
>> >
>> >> This is similar to the gitignore document, but doesn't mirror
>> >> the current situation. It is rather meant to start a discussion for
>> >> the right approach for mirroring repositories with submodules.
>> >
>> > Ooh.
>>
>> Thanks for writing such a detailed answer. :)
>
> BTW, here is a pointer to the discussion (and what I wrote down) about
> this from back in 2014:
>
> https://github.com/jlehmann/git-submod-enhancements/wiki/Ideas#special-ref-overriding-gitmodules-values

Thanks for pointing at the prior discussion!
Although not much happened since then (code wise)?

>
>> > To fix this, we could allow additional .gitmodules settings to be put
>> > in another ref (perhaps something like "refs/repository/config" to allow
>> > sharing additional repository-specific configuration in other files
>> > within the same tree --- e.g., branch descriptions).  The semantics:
>> >
>> > * If there is a gitmodules file in refs/repository/config in the
>> >   repository I clone, then the submodule settings from it are stored
>> >   locally somewhere that overrides .gitmodules.  Perhaps
>> >   .git/info/<remotename>/gitmodules?
>> >
>> > * Later fetches from the remote would also update this gitmodules
>> >   file.
>> >
>> > * Settings from this gitmodules file can be overridden locally
>> >   using 'git config' until an explicit "git submodule sync" to
>> >   override the local configuration.
>> >
>> > What do you think?
>> >
>> > If two different remotes provide conflicting values for a setting
>> > in their gitmodules files, git would error out and ask the user
>> > to intervene with a tie-breaking "git config" setting.
>>
>> Let's look at an example with C mirroring from B, who mirrors from A.
>>
>> The user who clones the superproject from C may want to obtain submodules
>> from either C or B or A. All this can be configured in
>> the refs/repository/config value of C, but in case it is not configured in C,
>> it may fall back to the same branch from B. When and how would B get
>> that branch?
>
> I think B has to setup that branch on its own when it starts to mirror
> A and uses different submodule urls or other configs.
>
> Jonathan you suggested to copy the content from a remote to
> .git/info/<remotename>/gitmodules locally. How would one get it to the
> remote side? It seems to me as if we would need to implement additional
> infrastructure to do this. Would it not be simpler if we just kept it on
> a ref on the local side as well? We already have the infrastructure to
> read those values from a ref. We only would need to add something to
> write them. Then a simple push, which could be aliased in form of a
> git-submodule subcommand, suffices to get the values to the remote.

That is good idea!

>
> That also solves issues when people clone from their working copy.
>
> I would like to think a little bit further about the conflict situation
> when two remotes are providing values. Configuring this looks to me like
> a nightmare for users. Maybe there is some sort of elegant solution?
> E.g. like we use the values from remote A during a fetch from A, the
> ones from B during a fetch from B and no values from a special ref in
> case there is no remote operation involved. Since the main goal is to
> support forking of submodules isn't there always a remote operation
> involved?

Here is what I imagine
When B mirrors from A, B sets up this special ref for its repository,
e.g. refs/meta/submodule-B and have a symbolic ref pointing at that.
(e.g. SUBMODULE_CONFIG pointing at refs/meta/submodule-B,
which has a worktree which contains a .gitmodules files which
sets up
  "submodule.baz.url = http://B/baz"
  "submodule.relativeBase = http://A"

That way anyone cloning from B would get
the superproject and the submodule baz from B while the
rest of the submodules are found at A.

When C mirrors from A, they add another branch  refs/meta/submodule-C,
which can either be a fork of refs/meta/submodule-B with some changes on
top of it or it can add a reference to refs/meta/submodule-B, i.e. the
configuration
would be:

  "submodule.baseConfig = refs/meta/submodule-B"
  "submodule.foo.url = ssh://C/foo"

and SUBMODULE_CONFIG would point at refs/meta/submodule-C.

When cloning from C, the user would get

 * the superproject from C
 * submodule foo from C
 * submodule baz from B
 * all other submodules from A

By the inheriting property of the branch of B there are no conflicting values.
C could just overwrite submodule.baseConfig for example.

>
> My suggested scheme above does not solve the currently quite typical use
> case where you might 'git fetch' without submodules first and then do
> the submodule fetches during a 'git submodule update'. On the other hand
> in the 'ideal future world' where submodules behave like "normal files" the
> fetch will be done during the superproject fetch so in that case we
> could solve such conflicts.
>
> The main thing which we could keep in mind is that we only allow certain
> values in such special refs. E.g. only the ones needed to support the
> fork workflow. BTW, do we actually need to change other values than the
> URL? Addtionally we ignore other values that are more related to the
> overall project structure. E.g. like submodule.<name>.ignore.

Maybe we want to have a dedicated protocol field, eventually.
A,B,C may have different standards on what they use by default.
e.g. Use ssh at kernel.org, but http in a corporate mirror, because http is
the only protocol not blocked by firewall. So I could imagine that a
complete mirror of submodules with relative URLs wants to only replace
ssh by http.

>
> Ok after writing this it really feels like special casing a lot. I would
> not really call it elegant. At the same time limiting these special refs
> to one special use case (forking) might help us to keep the user
> interface[1] simpler and conflict free in the long run. Not sure. What
> do you think?



>
> Cheers Heiko
>
> [1] Which is not the simplest already.
