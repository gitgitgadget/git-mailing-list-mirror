From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] doc: clarify that notes can be attached to any type of
 stored object
Date: Mon, 4 Apr 2016 10:33:56 +0200
Message-ID: <CAHGBnuP71qpOoNAAwXE-nbPbVyK56Up0YpmhhjC5430VwW73kQ@mail.gmail.com>
References: <56FE48C6.9050306@gmail.com>
	<xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
	<xmqq8u0xjmxh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:34:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amzxT-0003FK-4M
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 10:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbcDDId6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 04:33:58 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35998 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbcDDId5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 04:33:57 -0400
Received: by mail-vk0-f53.google.com with SMTP id c4so45288779vkb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UureigXW2YpUu8vidn+wstvvA2L0Sn4dqsn3BRDDBjk=;
        b=hpL3z9+axJKGYPtwGdWPc7JZbNjy23KBHeWEZJoMjgoL8tXPX2mKuGwH2Ydk15ZL7e
         v+Daj0nrGkCathsmCfmZ0Zg57GhNlBpeqfNnJdVnLHVgZGVLeVqRm712bGUglA+VD8xq
         MTDXnf4WveZ7RLTrga+4TwqdsZfvpomlo+1qd0p8SZPSfPDo9eog5W9IFEEvciJpbZTb
         BjM5s35eEPf/opr8mF1nSJxOCmrwDDUbVBqk9SCJw17wE+p/G/pJ7Qkeoj1w3LGkgEJX
         W2FL3gjBhLh3Z0mZH8lh3VOp4Sz/W8PGH05QbClO5I85LDb8E5KOn3dmNFig4hl8uxzi
         jcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UureigXW2YpUu8vidn+wstvvA2L0Sn4dqsn3BRDDBjk=;
        b=fWKZ/UME5lVQRC/NSu7NtMi8sLmKAYorQTbNaepaEMB38ErJy5gSwc0yKYPJncP1Bd
         IWt3hI8lpsGRj9uj8qZUK2IkSVZytpTlEx4iKWEb8mQmt4rasHBunQCave32uBaaeQBr
         nsmFieBwwgTZiIYe/oo0ZQlCT4qg5f7FZ8p2JP04J40gW4hv4rrs1hFt8c9eEjNX8KsC
         lnMTyaKnehsx5UJ/nKXz9m4IjDH+HDVyU14bdqAFtf+ikD5t/RykFlmDLdxMSizaPQBs
         HUreZW9hfzupbQMybSOhTKhcHJsTkQTLiZiA5eOVqE1zxpJjF1cMqCF488A13rZ3l8Ho
         Gmbw==
X-Gm-Message-State: AD7BkJKOEq5MnyCQlr7EGTj4cDXAb7zdnufOCO5S1V3A/HcGzfUVo3iOCAGygLtWckW4sXReQJWCTDYYmbi8Ig==
X-Received: by 10.31.41.195 with SMTP id p186mr6100581vkp.20.1459758836822;
 Mon, 04 Apr 2016 01:33:56 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Mon, 4 Apr 2016 01:33:56 -0700 (PDT)
In-Reply-To: <xmqq8u0xjmxh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290685>

On Fri, Apr 1, 2016 at 6:47 PM, Junio C Hamano <gitster@pobox.com> wrote:

>     DESCRIPTION
>     -----------
>     Adds, removes, or reads notes attached to objects, without touching
>     the objects themselves.
>
> This says "notes attached to objects" and "the objects themselves".
> They do not limit the target of attaching a note to "commits".
> So this may be the place to add "  Note that notes can be attached
> to any kind of objects, not limited to commits" or something, if
> we really wanted to.

Done, I'll send a patch shortly. But I wanted to list the supported
object types explicitly, in particular as many guide in the net are
unclear that only annotated tags are object, and lightweight ones are
not.

>     Notes can also be added to patches prepared with `git format-patch` by
>     using the `--notes` option. Such notes are added as a patch commentary
>     after a three dash separator line.
>
> This paragraph _might_ be confusing to new readers.  The "added to"
> sounds as if you are attaching a note to a non-object which is a
> patch.  But this "add" is about "inserting the contents of the note
> attached to the commit being formatted" and corresponds to "can be
> shown by" in the previous paragraph.  We may want to avoid the verb
> "add" when talking about the use of data stored in an existing note
> to somewhere else like this.

Done.

>     add::
>             Add notes for a given object (defaults to HEAD). Abort if the
>
> And this "Add notes for " should probably be reworded to "Attach
> notes to" to match the first sentence in the description.

After a bit of thinking, I don't believe we should do this. All
subcommand docs start with the verb the subcommand is named after. In
that sense making the "add" docs start with "Attach" would be
inconsistent and probably raise the question why the subcommand is not
called "attach" after all. Also, in the description it says "Adds,
removes, or reads notes attached to objects", so it includes "[...]
removes [...] notes attached to objects", and if you read it like this
the word "attach" is not specific to the "add" subcommand. So I left
this as-is in my patch.

-- 
Sebastian Schuberth
