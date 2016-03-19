From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sat, 19 Mar 2016 23:21:42 +0530
Message-ID: <CAJj6+1Fgj7VyVSSi2Qy=yEtEjuQWb7A8GDX-mY7h3V_mnRY2bw@mail.gmail.com>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
	<CAFZEwPP1GwH6a1kLTCn6ETov6YeK-t9PFJ_-wWP2P6v7CObiGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 18:53:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahL4G-0007le-6X
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 18:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934160AbcCSRvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 13:51:46 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34353 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934141AbcCSRvn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 13:51:43 -0400
Received: by mail-io0-f182.google.com with SMTP id m184so170985901iof.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=m/g9I6WbOIUrPuLkfyI5Zq4JcQ1PiW/r1rNYO3kXx6o=;
        b=WzclntkjscVMDugCEvzf6YyJ46hE4yIJ08LFSV1cwBm59nmNZItgjruzuhOkT4IMLD
         ULEXKLcFhmq0nmKIf08HZE7rZ7fWZg80Kh3t9P4AjUYWU8Ua2smWhTF2v5lUy3+y/mxR
         vlYlF/bPUa+5h5ACBBmdNq1nUip0jShqjD7pHh/JHvLnuaK4KJIz8WlN7NFkI9JEQidl
         TskVY+W04UAI62/R22Wme6Zw29jYYFyB3lpfQ8fs+w3Sw66SWf5yP71CTEBQ6zKM3+Tt
         qrIVp4IqERfUGrg7Y5gCgg2OgATjUcyiFV5TnqiKLF1+awA0RdS+heXxrDFRbDsnzl70
         Vh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=m/g9I6WbOIUrPuLkfyI5Zq4JcQ1PiW/r1rNYO3kXx6o=;
        b=ME/Q9pPTPxjxzV6kc7Qq4j7CqPkcVqVhszsirApTiKTU3O4y7g8112mMgUhtq5oqoc
         zadDkG7H8QiK0ysctSRfSN/opk57LoIPyIKoLfEG1IiiysNjGamu3FFs4q51KYgysvfV
         9KhkcRGsbaH+3P+xTx8Kn2tQlipxt6+lHVZ3P1Soqax8UnlLZGiZMFu2UGTwYCB1DX+7
         ZzTPfeCgBa/EtP9LzOXpc3COD781bIogAJZF1ic5aL0tPCsEFRcduzJLLoUPRD8ae0Mn
         dF15JV/Vm0F/wL2hhMbDrTJG9LREuL55ozpzsH1p/JrTwIO2OBK1O3qwBv2nnEx37gIa
         +sRg==
X-Gm-Message-State: AD7BkJJgkXMJz8rklHCv86bNhbDSniKKl4MRPRSUS7Y2DsyqQ6YHa5uKBOvbbWnYzXC7BYzJ21HhwxSO3WjVWg==
X-Received: by 10.107.134.94 with SMTP id i91mr21916062iod.95.1458409902646;
 Sat, 19 Mar 2016 10:51:42 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 10:51:42 -0700 (PDT)
In-Reply-To: <CAFZEwPP1GwH6a1kLTCn6ETov6YeK-t9PFJ_-wWP2P6v7CObiGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289317>

The original discussion [1] (the e-mail to which Jeff replied) doesn't
contain much either, but I'll try to explain it.

$ git tag --contains q
error: malformed object name q
usage: git tag ...
<entire usage text, printed on git tag -help / -h>

The same happens with 'git branch --contains', and 'git for-each-ref
--contains`, as they use the same underlying code. Just showing the
error message would be enough in this case.

The issue here is that the callback returns the "error: malformed
object name %s" print, which parse_options sees as some sort of error
and tries to help the user by printing the usage. [2]

One simple solution would be to change "return error("malformed object
name %s", arg);" to a die("message"); return;, however it might not be
the best option (though I'm not seeing any other user of this
function, the only place it is being used is for OPT_CONTAINS and
OPT_WITH

> 3. teach parse-options to accept some specific non-zero return code t=
hat means "return an error, but don't show the usage"
Would be a good general purpose alternative.

I need to look at this a bit more, and also get some hints / clarity
from Jeff regarding 2. if possible.

Thanks,
Chirayu Desai

[1] http://article.gmane.org/gmane.comp.version-control.git/284323
[2] https://github.com/git/git/blob/047057bb4159533b3323003f89160588c9e=
61fbd/parse-options-cb.c#L81

On Sat, Mar 19, 2016 at 10:34 PM, Pranit Bauva <pranit.bauva@gmail.com>=
 wrote:
> On Sat, Mar 19, 2016 at 10:19 PM, Chirayu Desai <chirayudesai1@gmail.=
com> wrote:
>> Hi, I want to work on this as my GSoC micro project.
>>
>>> On Mon, Jan 18, 2016 at 10:24:31PM +0100, Toralf F=C3=B6rster wrote=
:
>>> > very first line is "error: malformed object name <id>" which tell=
s all, or ?
>>> Yeah, I agree that showing the "-h" help is a bit much.
>>> This is a side effect of looking up in the commit in the parse-opti=
ons
>>> callback. It has to signal an error to the option parser, and then =
the
>>> option parser always shows the help on an error.
>>> I think we'd need to do one of:
>>> 1. call die() in the option-parsing callback (this is probably a ba=
d
>>> precedent, as the callbacks might be reused from a place that wants
>>> to behave differently)
>> I assume you mean parse-options-cb.c:parse_opt_commits() by the call=
back.
>> I see that it is currently used only by commands which have a "--wit=
h"
>> or "--contains" option,
>> and all of them behave the same way, printing the full usage, so a o=
ne
>> line change in that function would fix it for all of those.
>>> 2. have the callback just store the argument string, and then resol=
ve
>>> the commit later (and die or whatever if it doesn't exist). This
>>> pushes more work onto the caller, but in this case it's all done by
>>> the ref-filter code, so it could presumably happen during another
>>> part of the ref-filter setup.
>> I'm not quire sure how exactly to do that.
>>> 3. teach parse-options to accept some specific non-zero return code
>>> that means "return an error, but don't show the usage"
>> This sounds good, but also the most intrusive of 3.
>>> I think any one of those would be a good project for somebody looki=
ng to
>>> get their feet wet in working on git. I think (2) is the cleanest.
>>> -Peff
>>
>> What would be the best way to proceed with this?
>
> The extract that you posted isn't very clear.
> I guess posting a link with the previous discussion would be quite
> helpful as some people don't have the previous emails in the inbox.
> The archives can be found at
> http://dir.gmane.org/gmane.comp.version-control.git .
