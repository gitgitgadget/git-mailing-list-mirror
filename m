From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] git-svn: Print revision while searching for earliest use 
	of path
Date: Thu, 5 Feb 2009 08:42:42 -0500
Message-ID: <86d4c5e00902050542n74b10bfdw5e9249ac23fdc9e7@mail.gmail.com>
References: <1233810570-30765-1-git-send-email-deskinm@umich.edu>
	 <20090205064240.GA22926@dcvr.yhbt.net>
	 <86d4c5e00902050540lf8a3adfq18b1fed909d6e68a@mail.gmail.com>
Reply-To: deskinm@umich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 14:44:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV4WY-0005aK-CY
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbZBENmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 08:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZBENmn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:42:43 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:7332 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZBENmn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 08:42:43 -0500
Received: by wf-out-1314.google.com with SMTP id 28so303458wfa.4
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=yVctyPkmXkaeopKfTyJnB3OpAw4YVne3OrLRFjilwnI=;
        b=MLK5RwMO5hgZiHJcRIR9hKzhhmmwl9X4V52n9A+7j4wHqA838eEYWO0x8m/+HHHuMW
         QV0mwQlcQOf577PLJk7tqNEbtw1y2s0TyR0djk2WPgfJG8mJTo2tptiY/ur4L72nulLH
         Qjc/nPrHv4j2bEcFz+3PBWxzOjASNLzUEUsOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=v6hai44RT7YYUjWHzx7uDzwWfGHvScoKdE6r6gz1Y/YQlefS8+STso7BIEWXrTsHUo
         FMK8wY81eXXPeVDDRACPD2TYvU+6qdxPoCttXer8hEVJGZMn5M6NSdv64xoHxuCelO6G
         8SwLdVabUycf9r+WFTQ2V0hBSUzxJ3PTIilSk=
Received: by 10.143.6.1 with SMTP id j1mr252498wfi.226.1233841362517; Thu, 05 
	Feb 2009 05:42:42 -0800 (PST)
In-Reply-To: <86d4c5e00902050540lf8a3adfq18b1fed909d6e68a@mail.gmail.com>
X-Google-Sender-Auth: cad4c855dab27cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108561>

Resending due to temporary insanity with email, sorry Eric.

On Thu, Feb 5, 2009 at 01:42, Eric Wong <normalperson@yhbt.net> wrote:
> Deskin Miller <deskinm@umich.edu> wrote:
>> If the current version is
>> felt to be too verbose since it is printing a new line, I'd be up for
>> squelching the output to e.g. every 1000 revisions or so.
>
> This is definitely useful on slow/large repositories.  The current
> output with newlines is fine by me.

Ok.

> Couldn't we avoid the trouble of parsing the inconsistent error
> messages by printing this status message after the get_log() calls
> in gs_fetch_loop_common() ?

I didn't look at get_log closely, because I thought it executed only
once.  I definitely agree that it would be cleaner if it's possible.
Let me look at the code some more and I'll see what I can do, or feel
free to post an alternate implementation.

Deskin Miller
