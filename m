From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Wed, 27 May 2015 14:47:47 -0700
Message-ID: <CAGZ79kansAUWsjBsBznqaxRFeN3uF1u2hUZgO8b+OjOw8SKsUw@mail.gmail.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
	<1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1ti23vva.fsf@anie.imag.fr>
	<xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
	<vpq8uc9yfdp.fsf@anie.imag.fr>
	<xmqq382hlpwt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:47:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjB3-0002K0-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbE0Vrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 17:47:49 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:32781 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbE0Vrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:47:48 -0400
Received: by qgfa63 with SMTP id a63so9181079qgf.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LVg5vWJWrBKMBx24wfp/GZ7w+WyIOVrpQZXoGhdv8Rw=;
        b=pgZ2hN1B4mDS0xJ3vlN75rM76BT4/n4HiUOgA2HipVmHtgRNUJH0yIeMbOd+Vxqj2O
         Q5gd+SHrhOTgBk4VDo+Jn9Q9RqSERhdRt8/5mU8JmXohqLy97M4v3OHFVsJj8wG8Dxed
         3Ul1IJbe5yatFLJagwHZ96qhb+UhODNq9B1kVg5aYuQh7yrwYvwXk3hbREskdbPvm9nc
         Qr4B53MM8yW60XnK0eojvwNub3n3VH+MNmBWVmrOpU9xT9SOiIMrjlynNGtZ6WTtTW/G
         fEgr+yyt0B8iLDSBImGoV5GbuyV7DZktO6qeBkd+tihnIKw6WXM/+lWZmgRYIbNHD+Yx
         KQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LVg5vWJWrBKMBx24wfp/GZ7w+WyIOVrpQZXoGhdv8Rw=;
        b=Fl/QGL7Z9lwa+ziSaOhRNp2pY0Hc5vBzpR4x6kyXmE/YMEyQrcGGhfKKTybRXcRXeD
         PfxwlM8cX3d5qib74U/OdST32zoI1tyM1cHIwfoDlsx5LVT+utLuyiMFq+Acx1MlFYWY
         AssU6NXUr+4iH+IDAzyO+zRz20zVxz8LVhkdslmQqoHDA3Mco2+XXtBghyK6/+XWEuQI
         0hHoHk1KDtj3xrqVlyzb8vtIfEUytGfvbTQlpJEDZx+SKmrG6jMEpvts6KqQIjdP0iXf
         e68irz9UabgjWReln5KyzqfRFZI1yMHh20SAVjBCImVloa/5zdb2TC8BoH71buI8kG3s
         +/gA==
X-Gm-Message-State: ALoCoQmfMD7k1cckR1rsLDmTx7ODJScwAKeXEFvoacTMNxyPvFpstkUXw+Y80p/Ljox4R+Eb92Rw
X-Received: by 10.55.22.143 with SMTP id 15mr14727032qkw.85.1432763268033;
 Wed, 27 May 2015 14:47:48 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 14:47:47 -0700 (PDT)
In-Reply-To: <xmqq382hlpwt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270102>

On Wed, May 27, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>
>>>> I find it weird to write
>>>>
>>>> noop <sha1> <title>
>>>
>>> True, but then it can be spelled
>>>
>>>     # <sha1> <title>
>>
>> I do find it weird too. "#" means "comment", which means "do as if it
>> was not there" to me. And in this case it does change the semantics once
>> you activate the safety feature: error out without the "# <sha1>
>> <title>", rebase dropping the commit if the comment is present.
>
> Well, I do not agree with the premise that "A line was removed, the
> user may have made a mistake, we need to warn about it" is a good
> idea in the first place.  Removing an insn that is not wanted has
> been the way to skip and not replay a change from the beginning of
> the time, and users shouldn't be trained into thinking that somehow
> is a bad practice by having such an option that warns.

Talking about ideas:
I sometimes have the wrong branch checked out when doing a small
fixup commit. So I want to drop that patch from the current branch
and apply it to another branch. Maybe an instruction like
cherry-pick-to-branch-(and-do-not-apply-here) would help me there.

On the other hand I do understand the reasoning for having more
safety features in rebase as that exposes lots of power and many people
find the power a bit daunting.

So maybe you don't want to check the rebase instructions, but rather
after the fact, when the rebase is done:

$ git rebase -i origin/master
Successfully rebased and updated refs/heads/mytopic
Rebased the following commits:
    0e33744 Document protocol version 2
    6b6e3a7 t5544: add a test case for the new protocol
    d6aff73 transport: get_refs_via_connect exchanges capabilities before refs.
    cbb6089 transport: connect_setup appends protocol version number
    0b86fa1 fetch-pack: use the configured transport protocol
    23ed0ff remote.h: add get_remote_capabilities, request_capabilities
    e18b6dc transport: add infrastructure to support a protocol version number
    fd8d40d upload-pack-2: Implement the version 2 of upload-pack
    bf781ae upload-pack: move capabilities out of send_ref
    4c9cb59 upload-pack: make client capability parsing code a separate function
Dropped the following commits:
    deadbee upload-pack: only accept capabilities on the first "want" line
New commits: (due to rewording, double picking, etc)
    c0ffee1 More Documentation

I'd guess you would construct the information from the reflog
(The line before "rebase -i (start)" in the reflog) delta'd against HEAD,
so it's a crude incantation of git log maybe?

Also we need to turn this off for the power users, though I'd welcome if
we'd make it default on in git 3. (Being maximally verbose is good for new
users I assume, and turning it off is easy for advanced folks, so we can do
that for all porcelain commands?)

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
