From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:48:39 -0500
Message-ID: <CAMP44s3HaV-V3FZFrsX3rR1FWy-Tzxqibr138bBUizNfhJM9UQ@mail.gmail.com>
References: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkfX-0007w7-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab3FISsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:48:43 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:55814 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3FISsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:48:42 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so5022561lab.5
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S6rc4p09+Q/TE3Y98CWcQ98Cx2Tph4dNrYuoYQtHEAA=;
        b=KUgDU29hDs9iFVLqmRM2jwaDS0cdbKjQX2HFvEDqeg28NzaGrQ11J4iIzWtE9m0aIk
         dfratOiZ9z9sQyvy3ii/FGkDtZZYkQrlSvOnXPUOQE/c8AoN35FMbPkjjedE66cKC/15
         E15s3RiG4cRSUa04W7ci1WYiuJ9j7f9WY7qoXgouhZcF4rCMUFoBY+6NCbzgNWFwFfpH
         YwFkeRN7Cq8uSCEYSDazwew4Ry/uJI2xhsFFqcnJcegYCrTLTsddA5Z6UyX3tlGhW44Q
         lHJoQfg3fidpErzRE5pD1kmOcw0Tzh2bjg5z2fNo/TxqCP+kTN9pV9jIeqzjlTp0hEhf
         ptQg==
X-Received: by 10.152.27.102 with SMTP id s6mr3451316lag.47.1370803720000;
 Sun, 09 Jun 2013 11:48:40 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:48:39 -0700 (PDT)
In-Reply-To: <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227094>

On Sun, Jun 9, 2013 at 1:32 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Jeff King wrote:
>> I actually think word choice and politeness is only a small part of it,
>> and one that I live without.  It is not just _how_ something is said,
>> but _what_ is said. And sometimes what is said does not lead in a
>> productive direction. I found Thomas's comment here:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/227053
>>
>> sums up the core of many of the conflicts I've seen on the list.
>
> This is all very good, Jeff.  Various people have expressed what's
> wrong with fc's "demeanour", "tone", and "style of discussion" in
> various different ways at various different points in time.  This goes
> on and on and on with no end in sight. WHAT do we do?

What really puzzles me is that I think discussion and disagreement are
healthy, not only in open source projects, but in any organization; If
everyone always agrees, you know something is really wrong. But if
others think disagreement is not helpful, why do they bother replying
at all? Arguing. And they think their time is better spent not
discussing, but writing code (or something else), why don't they spend
their time that way. Why blame me for their choices?

We disagree, that's fine, move on.

> I'll be frank: I'm a pragmatic person, and I want to see work.
> Despite all this mess, who has shown me the most number of patches
> with some direction?  Felipe.  Who gets the most number of patches
> into git.git, by far?  Felipe.  And who is wasting time theorizing
> about what's wrong with Felipe in various ways?  Everyone else.

Thanks! "Talk is cheap, show me the code."

>> I am less interested in people's feelings than I am in discussions
>> trying to reach a productive position of agreement, rather than turning
>> it into a point by point debate that may no longer have any use for the
>> project (sometimes individual points need to be refuted or discussed, of
>> course, but it is easy to lose sight of the purpose of an email).
>
> Felipe has discussed the {sequencer.c -> builtin/sequencer.c} move
> with a bunch of us (and sent a patch), discussed how to write tests
> properly with me (with a patch), and discussed how ruby can be used to
> call into libgit.a (with code that I'm currently playing with).

Interesting. In case it might help you, this is the extconf.rb I used:

---
ruby/extconf.rb:
#!/usr/bin/env ruby

require 'mkmf'

$INCFLAGS = "-I.. #{$INCFLAGS}"
$CFLAGS += " -DSHA1_HEADER='<openssl/sha.h>'"

# libs
$LOCAL_LIBS += ' ../builtin/lib.a ../libgit.a ../xdiff/lib.a'
$LIBS += ' -lssl -lcrypto -lz'

# make sure there are no undefined symbols
$LDFLAGS += ' -Wl,--no-undefined'

# Create Makefile
dir_config('git')
create_makefile('git')
--

I have to build all the objects with -fPIC though.

-- 
Felipe Contreras
