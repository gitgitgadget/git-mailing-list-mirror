From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 14:32:03 -0400
Message-ID: <CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <xmqqbne9ivry.fsf@gitster.dls.corp.google.com> <CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
 <xmqqwpwxha4r.fsf@gitster.dls.corp.google.com> <CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
 <xmqqtwrxesqa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPCy-0003KY-2F
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbHQScZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:32:25 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34059 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbHQScX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:32:23 -0400
Received: by iodb91 with SMTP id b91so161186675iod.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g9SPxYCut2nJ5Kv3/HURFS6MZnE4iCz/t2pr7LIAQ4Q=;
        b=M0gyhCLIlre6OyofyQv5IAnGdnmhouzBHnRNH2OBtr1ToBO7+beSs9VjOIYItcvb8W
         ixMBY6nrNuSAbcWFclHNeT3R2/a5FKXms58eV6YPags07nTmKeMNKRKNQtkS8I/bhNpo
         Pggmln/SAKRuMobYOGR/K4J5nV4NXSRVMlaAemyjLhs5qLe4si3A8GCfDVH2spyzoGoW
         rUQrrBc3f3wIBwGOGodLTgRbKQFlILDDq6G5ggwArEnXKplJePoWA8UiwXT4XQw64RGF
         3A+hNalCGZZldcvvHm/GeSFzQ6sPSLfTonpszs1Gr0xhUDg0UdnLDx3f573GEkmKw+ll
         hreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=g9SPxYCut2nJ5Kv3/HURFS6MZnE4iCz/t2pr7LIAQ4Q=;
        b=CzSx0GxBNkN8s97lZJJrri4aLoIKm9A+JG2XFGeLyCHxiqFQRR/2kx6iweyRTk55Xc
         VhC0M67+PdvjIj/gJJeectqMxmIADPNCKdqRwXpqdHXAP4pf/9wCBm92DfbCOOuFgIsD
         VNmIRMk2vx6WZ2xIU3FltkrYakD/RFBsHyo+jSne5FiSAvYSvqlnCL+3hlrVfg9JgBzi
         cs1QJ5U2q9hNCMB9aHCfhgWBUlC3hngiDcOpPRkszeqWwz1VQBV6pkna8zmK5xoccofd
         /f7PZ0wUGvjDLn/flud01aiq+PcFoMXh0PzhNkrc5+6+2I/LEFtxCIb3YlL+V9mOJZ27
         bscA==
X-Gm-Message-State: ALoCoQluw9l8KATcB1yLoSqn513h12WJfeH7wF+L5OENDDkkDKuOiFZPHM4eKmIDXK91mcfRHWQO
X-Received: by 10.107.136.66 with SMTP id k63mr616427iod.194.1439836342936;
 Mon, 17 Aug 2015 11:32:22 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Mon, 17 Aug 2015 11:32:03 -0700 (PDT)
In-Reply-To: <xmqqtwrxesqa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276069>

On Mon, Aug 17, 2015 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> Ok, so let us bikeshed a bit further.
>>
>> Bikeshed 1.
>> Option A: --signed/--no-signed--signed-if-possible
>> Option B: --signed=true|false|if-possible, "--signed" alone implies "=true".
>>
>> Bikeshed 2.
>>
>> Option A: if-possible
>>
>> The possibly confusing thing is one might interpret missing "gpg" to
>> mean "impossible", i.e. "if gpg is not installed don't attempt to
>> sign", which is not the behavior we want.
>>
>> I don't have another succinct way of saying this.
>> "if-server-supported" is a mouthful. I think Jonathan mentioned
>> "opportunistic", which is fairly opaque.
>>
>>> By "strange", I was referring to the possible perception issue on
>>> having a choice other than yes/no for a configuration that allows
>>> you to express your security preference.
>
> My preference on Bikeshed 1. would probably be to add
>
>     --sign=yes/no/if-asked
>
> and to keep --[no-]signed for "no" and "yes" for existing users.

Incidentally, I just looked up incidence of true/false vs. yes/no in
command line options, and the results are decidedly undecided:

$ grep -e '--[^ ]*=[^ ]*true' Documentation/*.txt
Documentation/git-init.txt:--shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
Documentation/git-pull.txt:--rebase[=false|true|preserve]::
Documentation/git-svn.txt:--shared[=(false|true|umask|group|all|world|everybody)]::
$ grep -e '--[^ ]*=[^ ]*yes' Documentation/*.txt
Documentation/fetch-options.txt:--recurse-submodules[=yes|on-demand|no]::
Documentation/fetch-options.txt:--recurse-submodules-default=[yes|on-demand]::
Documentation/git-pull.txt:--[no-]recurse-submodules[=yes|on-demand|no]::

Consistency is hard.

I am inclined to stick with yes/no in this case because
--recurse-submodules at least feels like a more modern option that we
should emulate, but don't feel strongly either way.

> Regarding Bikeshed 2., I do not have a strong opinion myself.

Although it sounds like you already expressed an opinion for if-asked
> if-possible, which is stronger than my own :)

> Thanks.
