From: Joe Ratterman <jratt0@gmail.com>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 13:08:11 -0500
Message-ID: <AANLkTinNM_tf=rJYXLO8cgaxwpAz2pi8G4nJiwZ9RLR6@mail.gmail.com>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
	<7vlj024wal.fsf@alter.siamese.dyndns.org>
	<4D9037AA.9090601@drmicha.warpmail.net>
	<20110328115421.GA9232@sigill.intra.peff.net>
	<7vvcz3yxs8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Grs-0003mq-Qw
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab1C1SIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:08:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53387 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab1C1SIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:08:12 -0400
Received: by gwaa18 with SMTP id a18so1269385gwa.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xYH3kFWaXT3lJ1LwkOHI34meRtP9IuM4S/VDDQMO8Yc=;
        b=xen2bwJCpepks7HDasQzImuZhCgD2XjLSDpUTpclSlszuE8OsruiL4yT8BuDCSmKv1
         +LuM0LSxWoVNvFQBtq/JrR8fIEFzU8LFQ+KBsJnpF3+fvd2c50bTQ+NtqkDNLxn2Epnb
         c50GHSJkt+FOhW5TlWTSNBOZUdWPHBJtkPPJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cle7UfpHcl33oFaTtXkAtzjUUdBShZzwuHOyg9TY2oxoR73dpBMa4TBjzD7mF/hMcG
         y5HfeTkD/4n1ReVybR4UMc9zI3jwjgUranAdaVdh7ItVWghz3Z9QCR9JKez4kCiQg9bR
         6J02zLyewqoqf8mGQ+nM4eCw01xjA+FYsOWbs=
Received: by 10.236.105.164 with SMTP id k24mr235605yhg.370.1301335691079;
 Mon, 28 Mar 2011 11:08:11 -0700 (PDT)
Received: by 10.236.95.16 with HTTP; Mon, 28 Mar 2011 11:08:11 -0700 (PDT)
In-Reply-To: <7vvcz3yxs8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170170>

On Mon, Mar 28, 2011 at 12:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> But would any user go all that trouble, just not to say "-nE" from the
> command line (or use an alias that was designed not to crash with
> scripts)?
>

I use the $GREP_OPTIONS environment variable to add -n and -P (pcre)
to my grep commands by default.  Coming from a strong Perl background,
I don't know the *exact* difference between basic and extended, so I
do not usually realize I need -E until it gets a little too
complicated.  I generally forget line numbers until I want to start
editing the file, making me run the grep command a second time.  For
me, it is much easier to have them in the environment/config-file,
since I never want to avoid them.

Joe
