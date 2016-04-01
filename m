From: harish k <harish2704@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Date: Fri, 1 Apr 2016 12:02:02 +0530
Message-ID: <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
	<20160331164137.GA11150@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 08:32:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alscs-00081n-HE
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 08:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbcDAGcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 02:32:05 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34776 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbcDAGcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 02:32:03 -0400
Received: by mail-oi0-f48.google.com with SMTP id o62so92757840oig.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IDBm81KIdqEtwt2LU/HpbScWWWXrMXZUMqhUefMYwLQ=;
        b=BqGDbiSVUDiuT0PEQ/0n4r1d2GQiuYJKv2DkqKwqWXxeg1f4R2IyIvrA7l/Z5fMEKs
         4WxE+L2JUB/NkRCTYOCfWszHkZi2F3+taHFPL1dflElrJMV+fAGhjmvagGiGJKnFr+iW
         nwu/u8bvem0f/CvQlSaEwkyTiThw9oncBJjKXClsWpJP3b3IQdfFMKYbU8x27oUe606u
         UVU5EiUiHyKvdSeiaZ3WsLCwy1zdwTF9Kj9Grqg8S5xvRTlIh+3aoDxVIOPWjtfUH9Vu
         dfdCnPwj4FWO7OEEWr0FRYjkhDCR7MV50izHLWbYYqMym6D+PS8It/C50oXPy8mgqMXX
         PNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IDBm81KIdqEtwt2LU/HpbScWWWXrMXZUMqhUefMYwLQ=;
        b=Vy/gxVw4t9TMce6mDGWjZDXKp9jycAsSiS/qQP9CqAXZlFL+zFNEW8e6WG6qufEaeD
         az/x5byL3EUJT+idm6w+SLDYctXVxG4f6BePsieLGXPr2//4yddMC3qzFAqCDoNu/7WZ
         ppEUTiF2VauH7KRFh4c/80kYscMT8wrwBVd3tyf+PnfRbP3U1k6KTjo1Qi63+/EMoPqP
         yhmgVqXhF0uM/r1eLoHqhS1yQuWb4w4cjgpXKsqKtZMH5tG8FzLhUGhhkRbXtuD1MS11
         QR+ngHq38+8YC/HzYhAjOWob3ka2C3sGXlRLZjzLJQC60X7AAFm5KXB2B75ET41CrOvU
         F/qQ==
X-Gm-Message-State: AD7BkJJ1shl38NteeBki1S7IaJXbkU/jpYfkzAKKKChgpot8PvEltU1L4sV/Wy1m5GL/XSNz3ooz1cZnhTkyag==
X-Received: by 10.157.44.139 with SMTP id p11mr1886924otb.124.1459492322227;
 Thu, 31 Mar 2016 23:32:02 -0700 (PDT)
Received: by 10.157.10.99 with HTTP; Thu, 31 Mar 2016 23:32:02 -0700 (PDT)
In-Reply-To: <20160331164137.GA11150@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290509>

Hi David,

Actually Im a TCL primer.  This is the first time Im dealing with.
That is why I kept it simple ( ie both accel-key and accel-label need
to be defined in config ).

I think, git-cola is using Qt style representation accel-key in the config file.

Is git-cola is an official tool from git ? like git-gui?
if not ,
My suggesion is, it is better to seperate config fields according to
application-domain
like, "git-gui-accel = <Ctrl-l>" etc..
Other vise there is good chance for conflicts. ( Eg: consider the case
 that, <Ctrl-p> was assined to a custom tool by git-cola )

Currently this patch will not handle any conflicting shortcuts. I
think custom shortcuts will overwrite the other.


On Thu, Mar 31, 2016 at 10:11 PM, David Aguilar <davvid@gmail.com> wrote:
> Hello,
>
> On Tue, Mar 29, 2016 at 11:38:10AM +0000, Harish K wrote:
>> ---
>>  git-gui/lib/tools.tcl | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl
>> index 6ec9411..749bc67 100644
>> --- a/git-gui/lib/tools.tcl
>> +++ b/git-gui/lib/tools.tcl
>> @@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
>>  }
>>
>>  proc tools_populate_one {fullname} {
>> -     global tools_menubar tools_menutbl tools_id
>> +     global tools_menubar tools_menutbl tools_id repo_config
>>
>>       if {![info exists tools_id]} {
>>               set tools_id 0
>> @@ -61,9 +61,19 @@ proc tools_populate_one {fullname} {
>>               }
>>       }
>>
>> -     tools_create_item $parent command \
>> +     if {[info exists repo_config(guitool.$fullname.accelerator)] && [info exists repo_config(guitool.$fullname.accelerator-label)]} {
>> +             set accele_key $repo_config(guitool.$fullname.accelerator)
>> +             set accel_label $repo_config(guitool.$fullname.accelerator-label)
>> +             tools_create_item $parent command \
>>               -label [lindex $names end] \
>> -             -command [list tools_exec $fullname]
>> +             -command [list tools_exec $fullname] \
>> +             -accelerator $accel_label
>> +             bind . $accele_key [list tools_exec $fullname]
>> +     } else {
>> +             tools_create_item $parent command \
>> +                     -label [lindex $names end] \
>> +                     -command [list tools_exec $fullname]
>> +     }
>>  }
>>
>>  proc tools_exec {fullname} {
>>
>> --
>> https://github.com/git/git/pull/220
>
> We also support "custom guitools" in git-cola using this same
> mechanism.  If this gets accepted then we'll want to make
> similar change there.
>
> There's always a small risk that user-defined tools can conflict
> with builtin shortcuts, but otherwise this seems like a pretty
> nice feature.  Curious, what is the behavior in the event of a
> conflict?  Do the builtins win?  IIRC, Qt handles this by
> disabling the shortcut and warning that it's ambiguous.
>
> Please documentation guitool.<name>.accellerator[-label] in
> Documentation/config.txt otherwise users will not know that it
> exists.
>
> It would also be good for the docs to clarify what the
> accelerators look like in case we need to munge them when making
> it work in cola via Qt, which has its own mechanism for
> associating actions with shortcuts.  Documented examples with
> one and two modifier keys would be helpful.
>
>
> cheers,
> --
> David



-- 

-Regards
Harish.K
