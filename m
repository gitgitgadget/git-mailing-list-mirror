From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] format-patch: Add config option format.coverbodytext
 to change the cover letter body
Date: Tue, 6 Jan 2015 11:14:59 -0800
Message-ID: <CAGZ79kZE+zBgYANE8+NppnBsAVfLXPdgxnvFRbLdMkafSqduWA@mail.gmail.com>
References: <1420486105-30242-1-git-send-email-sbeller@google.com>
	<xmqqzj9wp52y.fsf@gitster.dls.corp.google.com>
	<CAGZ79kabhx1q2pxY0_UXAy64G94GQZaP4nSUgeUjV0c_sjt+QQ@mail.gmail.com>
	<xmqqd26rpwjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Zav-0001M4-EG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbbAFTPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:15:01 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:52522 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490AbbAFTPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:15:00 -0500
Received: by mail-ig0-f178.google.com with SMTP id b16so86753igk.17
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sIU764sIJo4mKkePd6llnS0HOGxgG3Q8muADWEV2a/g=;
        b=J1UC/kmWTz4xc/kK/peyuJMHRTQ/cEbIaBw2cRgkLOR0S89GkNhGnIlxh8GJv1nrUi
         Gu9Wj7Ls/p9hfoU9KUg4MEJzU1scf0ErWW+Z4CeZvlDT27K58Tjre+3LjSLqomk5Dmi9
         UwJo3KW5YSiolek/T2WaxPtTwAIY58+THczDjqDwia7Rd8PeDduB0tT2tcmatKFW5SOY
         RgvbdqokLzKyGIQ1kYTkaazxqCNwQl8Gr9AoX/hmrKiI2eIReDWBZDB1ualWaM9O/sp5
         x/KABgSf9DLYmneWMFI/gdeIUWRI9LdCk6+MOhh6SzIYDdH5/1mHLoZaahMSJaKgJiBw
         ybEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sIU764sIJo4mKkePd6llnS0HOGxgG3Q8muADWEV2a/g=;
        b=GyQkmYIc1ED32gZgkKfQOCdCxRkwL6o9us1hiZld5i4CO0c5+MOr0TmeXmiZO0GGIF
         RmyNbOzBa9tTz0914f71/0LfywHicqVZLDfzSryYrTEc9Cbqgz8hpmRRr6cC88oMxgO3
         GgfKwuktC6l0rV6xTH+QR5W7+Ute/rA8Iq+JxMwAy6wHAg6WI0uRkxhFVYr3rB7rdun/
         QwEensSuc9OgIaAsDF+yCBisdjF3Duok9ncO+VA7t2NDDf+1mpIj7VB3Ha5SaMS59fLq
         VB3r2sAixeai4hBVrSIDmCQX1h9Tvgt0qOfW2sfBNW2T4bRTK2IqJvC4Zyf8gIyHU5zp
         q3rg==
X-Gm-Message-State: ALoCoQkcdTFqxrc/3/jIC2ayTkhQrpJ5liltdc5EDZ+XiSkAvLZ8aR4RkjEEK2LAq66ERm2CQcwV
X-Received: by 10.43.100.67 with SMTP id cv3mr73803747icc.92.1420571699525;
 Tue, 06 Jan 2015 11:14:59 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 6 Jan 2015 11:14:59 -0800 (PST)
In-Reply-To: <xmqqd26rpwjg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262090>

On Tue, Jan 6, 2015 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> You said it yourself above, didn't you?  While perfecting your
> branch and while perfecting reroll of your branch.
>
>
>> * After doing changes, wait at least 12 hours for second self-review
>
> This is certainly once-per-series.

Right.

>
>> * sending out:
>>     git format-patch --cover-letter --notes --subject-prefix=PATCHvX
>
> This is not even helpful reminder if that is only shown after you
> run format-patch, no?

Right, as I currently have these notes somewhere completely
out of reach of my git tree, I manually check that list whenever I need to.
So this is for different events.

>
> Yes, but that is a separate discussion where the check list is given
> (per patch or per series?) and how it is presented (overriding the
> "blurb here" comment or something else that can also be used for the
> non-cover messages?).

One of the problems here may be that a single patch is never formatted
as a patch, but lives inside the git world. Only when I consider the
whole series
good I start formatting the patches, which is why it's hard to find a place on
a per-patch basis.

>>> Perhaps --add-header="x-reminder: what changed since the last?"
>>> would be sufficient for your purpose instead?

Maybe a similar approach of pre writing notes to some per patch
checklist would do?

So once I'd set
    git config commit.add_notes_if_empty "/in/filesystem/checklist/per/patch"

which would add notes whenever I'd commit and the notes for that commit
are not empty (i.e. commit --amend doesn't wipe existing notes).
Maybe that config option should rather be below
notes.add_on_commit though.

So before we drift into more discussion, I'd still think it makes sense to have
the ***BLURB *** replaced by some configurable questions regarding the
series as a whole, so I'd try to perfect that patch?

Thanks,
Stefan
