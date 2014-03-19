From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Thu, 20 Mar 2014 03:09:05 +0900
Message-ID: <CAN7MxmVny80BYvYBZ=iBybx_ffVhOCfkP3pU6fYzHpxNu4QYHA@mail.gmail.com>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
	<1395226935-53044-1-git-send-email-modocache@gmail.com>
	<xmqqob123wjm.fsf@gitster.dls.corp.google.com>
	<20140319180213.GB11018@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKvu-0007JJ-6j
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaCSSJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:09:08 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64401 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaCSSJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:09:06 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so9388959ieb.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1wS1IIQpTg2Dn1LcGKTKR0sMIgnNyx0xFUvbfx50AoI=;
        b=MFwCyCbm7LWeU5O/S2f+iqYWscPII7sGVMWsbOKjzY7gdUPZwbRqHoeX3K1iCTLqoe
         13jZ91h6kGkQlZ32eNgDsFiD//oLqOl8QO7f9yveRLWwEfa5lJ36yknvgX3FShuKgkPm
         QEpY+E8gV6H3XeDpILHnhOuetxfxU3y3Jnmu4LMZ/MmWxdzvoAp3zMEsI0wuYLIuqevC
         9n62M5mjp7P2id/QoTkaxBkdcgWvtsa0+KxF7I2q0LO0YnPTdVQoTsxmHX6msOXhfzXn
         YSqX7zPzAZFoIi7fBgh+3+JCnOqloi5jjyAj+7aHYxk3CPuJDUAepdQ5ofzofeIbD435
         3lOA==
X-Received: by 10.43.150.80 with SMTP id kn16mr8200069icc.63.1395252545486;
 Wed, 19 Mar 2014 11:09:05 -0700 (PDT)
Received: by 10.64.55.161 with HTTP; Wed, 19 Mar 2014 11:09:05 -0700 (PDT)
In-Reply-To: <20140319180213.GB11018@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244472>

Thank you for the feedback and tweaks!

> Is the eye-candy output to the standard output what is the most
> interesting during the execution of a rebase?  Wouldn't we be
> more interested to make sure that we did transplant the history
> on the same commit between two cases?

I agree. I'll consult the other tests to see how to write such a test.

> Can we use `git name-rev` to put the actual name here, so that people
> who have not done what they intended can hopefully notice sooner?

This sounds like a great idea! Doing so would mirror how `git checkout`
behaves; checkout informs the user of which branch they have switched
to when using the "-" shorthand: "Switched to branch 'master'".

Should I submit a new patch, or reroll this one?

- Brian Gesiak
