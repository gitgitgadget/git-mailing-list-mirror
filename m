From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] RFC/Add documentation for version protocol 2
Date: Wed, 22 Apr 2015 23:16:52 -0700
Message-ID: <CAGZ79kZyTTX2d+ULohS+J0tA7AYHRZ8DKqfgmuQGFzZsbwkQzA@mail.gmail.com>
References: <1429658342-5295-1-git-send-email-sbeller@google.com>
	<xmqqd22wdl88.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZN9nBrJ_7skrSQ4kor+p=DM8RnSC2bFZ6TX=SxdMdqcA@mail.gmail.com>
	<xmqqd22vd9me.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 08:17:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlARZ-0005gl-IT
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 08:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbbDWGQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 02:16:57 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34536 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbbDWGQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 02:16:55 -0400
Received: by iget9 with SMTP id t9so4654943ige.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=irSchhFHc+KEIqUmwLfzxDDhIWNCktH5gSEoTJ4dngc=;
        b=oUGWQtJY5hHOxzHUmzZLHlgeO51AQsPP/n0E6wftwQPK3uiVXBqF1b8HZg85E8zRL8
         fk2uVqBhPM0pgK+Vh/RyblKiAIDz4KAka2p0o1QKxhwQ2sF63tgNvLPbBKpJw8YVCtkE
         APycNRctmPM2wG7zMUp+n1NrxeUiduUdXiajnSkt61yXp55aCxfj2qgymTzu1Xr9JFFw
         lFUfy7dKF+b4+Y9Izkfj4nk0SMDk7/fn68PFSTdbO+Oez5ClC0sgmn/yowghR+4YWe+V
         3wZb2jIpcOW7DA+vsH/2c25mFLM4tdKngfl8fUJ8qWByb3SHxUkfx+Cfb2i9nuv1sIGb
         SNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=irSchhFHc+KEIqUmwLfzxDDhIWNCktH5gSEoTJ4dngc=;
        b=IdIIsH2j2U48QW8Z85ZDMMpWunaUUiB27z2Z2M37hMyU4O3JYs/ec65QDXoTWv9Ugv
         2rwFeRH37fPSph4VovM91f7Obo1itK4OzKvuA798ynUxgVrJ/tyKbEAN8FoS4KzeSYKn
         WrCcOP7TebeWkHpZsT1sHGXXZjloASNjPp+3uCcLRHdaydFBXlOpfNdJGcJEspy1K4Iu
         EHWb0ntb4P+NBJXSAZyne6+XDTZFtUuLdA3lvSvxEIJbyMHchF4OFwEvbxhOIHO+HSt5
         Sd4TMmLS+0P7ZTUbCijpt1MQO9hZwMwZF4gXo8I65OPGNUGR7V9x9bLFHaqKYOiQpM19
         OuCw==
X-Gm-Message-State: ALoCoQkx5iyCUfaTEYnOUyW7uffIeGdVCkTvA/4tSsgTop03ymy0srdlwSxORWs5bgHFdz2Cx4Vl
X-Received: by 10.50.117.4 with SMTP id ka4mr9560878igb.10.1429769812820; Wed,
 22 Apr 2015 23:16:52 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 23:16:52 -0700 (PDT)
In-Reply-To: <xmqqd22vd9me.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267676>

On Wed, Apr 22, 2015 at 4:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> +action           = "noop" / "ls-remote" / "fetch" / "push" / "fetch-shallow"
>> ...
>>> If we are going in this "in-protocol message switches the service"
>>> route, we should also support "archive" as one of the actions, no?
>>> Yes, I know you named the document "pack-protocol" and "archive"
>>> does not give you packs, but "ls-remote" does not transfer pack data,
>>> either.
>>
>> I'll add that. Also I need to incorporate shallow in one way or another.
>
> This level of detail may not matter at this point yet, but it is
> unclear to me why you have "fetch-shallow" as a separate thing
> (while not having "push-shallow").

Right, this should have been done via plain fetch action but the mode parameter
may be set to shallow,narrow or what we want. Sorry for my shortcut in thinking
there.

> The current infrastructure does
> already allow fetching into shallow repositories without needing a
> separate action that is different from "fetch" (aka "upload-pack").
> I would not be surprised if it were "I can deepn you if you want"
> capability, but I do not understand why you are singling out
> "shallow" as something that needs such a special treatment.
>

I should not have done that. I just got confused.
