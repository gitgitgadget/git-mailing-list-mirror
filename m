From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 10:31:32 -0700
Message-ID: <CAGZ79kY96cx9iED=xbheByO7kzNFT2VkO6VpRX6nVJ6rov+6uw@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
	<xmqqegay5yw0.fsf@gitster.mtv.corp.google.com>
	<xmqqh9fu4gi7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:31:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVaD-00036Y-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbcCYRbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:31:33 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35742 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbcCYRbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:31:33 -0400
Received: by mail-io0-f182.google.com with SMTP id v187so89562409ioe.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xdqUc1B5QIMqeAR9mNLGJ3I3Vr7Cq0/WFJn8Usii5Og=;
        b=OcozwwSsrHluSDnQz9DJuPvmuR/qZoo4lzfDD2ndYLcn0qm1sN8WW1GD3fKFLXcbnb
         8z2uSgyDxWm5L8AyWlLiR6hsvXmCKBOvhCSwSxeiOLGC9NYo7/0bgPYfNYSk+aArlg75
         kUMQd1kh+vJw59OZTtB2BwxgjXE5HboyhiEu49JSVy5J4A9Ec/YkQL8Y73GCIdG7Op1U
         obuDWQJGEMZYFwlP+3H7zXWYBcY07TtrsLpiuVYjXRAyWxe23rG/smS2+QeWkkX6UafN
         nFOx3Ks91aioxJO2eYx8KAROIOets5/6lprbiLwFGGSABI9QP1B2WnUQBAekHOmErDT1
         3IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xdqUc1B5QIMqeAR9mNLGJ3I3Vr7Cq0/WFJn8Usii5Og=;
        b=RRLIhUrovidKvrPtE68qdOnslKaxy8Oxa+uCJ1oTAjPxCClp3ktqWzHyDxjMYyYi36
         c7JP7ahNGJwJAB7zS8Ao4NiqMgQlJCyHRj7ETJd0WZQPp6mWNFrRM+gXodzz2ovHEEA9
         loDArc6Oqtx1JkkTONZNGeaEMC+wS0K5xuRTrp6RdVR9dytTnn/mRMq5H2xfWxaPpfgv
         8WBgRdH6CQpO+58abec713WU4tqAMYL3NXsV0qIXlAiU29ZEM/omMGCsLT7jvz2/+yjf
         loH6N1qHYkMA8Jxv7hNvUdMnmmBID2z3AQcI8/EhGptlraS7h7RzYCbsKMDcnpLnXchB
         hQ6Q==
X-Gm-Message-State: AD7BkJLjrqUFucDv4NW9Mqj43gfpMBH6voimHQdwAt3l7CQjPIVBRlfqsQgCTn1dKPNSTyuOlBbTvaZffqKVpHKz
X-Received: by 10.107.158.138 with SMTP id h132mr14612009ioe.174.1458927092191;
 Fri, 25 Mar 2016 10:31:32 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 10:31:32 -0700 (PDT)
In-Reply-To: <xmqqh9fu4gi7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289912>

On Fri, Mar 25, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The way all the subcommand written in C works is
>>
>>  - The start-up sequence does the repository discovery, which
>>    involves crawling up to the top-level of the working tree, and
>>    compute "prefix", where the end-user was when the command was
>>    invoked;
>>
>>  - The subcommand implementation is called with this "prefix";
>>
>>  - When the subcommand implementation interprets the command line
>>    arguments and option arguments, it prefixes the "prefix" as
>>    needed.  If, for example, "git grep -f patterns" is invoked
>>    inside "sub/" subdirectory, when the command line and option
>>    arguments are processed, the process is already at the top level
>>    of the working tree, so it needs to read the patterns from
>>    "sub/patterns" file.  "git ls-files 'Makefil*'" invoked inside
>>    "sub/" subdirectory needs to limit the output to those that match
>>    not "Makefile", but "sub/Makefil*".
>>
>> The hope of doing an incremental rewrite of the whole thing by
>> enriching submodule--helper is that the bulk of the code there will
>> be reusable when the entirety of "git submodule" is rewritten in C,
>> so they need to take the "prefix" the same way, whether the caller
>> is calling from "git-submodule.sh" script via submodule--helper, or
>> the eventual C implementation of "git submodule" is making direct
>> calls to them.  As long as the correct "prefix" is passed to the
>> routines that are driven via submodule--helper, it does not matter
>> and I do not care how it is done.
>>
>> The current code of "git submodule" whose higher parts are still in
>> shell would would:
>>
>>  - The start-up sequence in shell does the cd_to_toplevel and finds
>>    the prefix;
>>
>>  - "git submodule--helper list --prefix=$prefix $other_args" is
>>    called; as this is called from the top-level of the working tree,
>>    internally its "prefix" is empty, but $other_args must be
>>    interpreted relative to the $prefix passed with --prefix option.
>>
>> If we instead call "git -C "$prefix" submodule--helper list $other_args",
>> then
>>
>>  - This command first does another chdir(2) back to $prefix;
>>
>>  - The start-up sequence of "submodule--helper" does the usual
>>    repository discovery again, which involves crawling up to the
>>    top-level of the working tree, and compute "prefix".  This
>>    happens to match what -C "$prefix" gave the command.
>>
>> Making calls to submodule--helper via "git -C" feels a little bit
>> roundabout because of this "caller tells to chdir, and then it has
>> to again chdir back up" only to rediscover the same information.
>
> Just to make sure that the discussion is complete.
>
> Another way a script can use the "prefix" information is to use the
> "prefix" as such.  Knowing that the cd_to_toplevel() took you to the
> root level of the working tree, instead of "git -C $prefix" or
> "--prefix $prefix", it could do "git $cmd $prefix$filename".
>
> One consideration when choosing among the approaches is how the
> $filename is reported back to the user (e.g. as part of an error
> message).  "git $cmd $prefix$filename" invocation would complain
> about the full "$prefix$filename" path, but what the user gave it
> may only be $filename part.

Right. Using either "git -C $prefix" or "git --prefix $prefix" would report
the $filename only, because both cases assume $prefix was cut
using cd_to_toplevel and the user expects $filename only.
