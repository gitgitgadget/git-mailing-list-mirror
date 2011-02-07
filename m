From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add support for merging from upstream by default.
Date: Mon, 7 Feb 2011 10:36:05 +0100
Message-ID: <AANLkTikii-fx5nYeBDc70eh_wj05sEZ6fH6=bF9GqHBK@mail.gmail.com>
References: <m2k4he23z6.fsf@whitebox.home>
	<1296912681-4161-1-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 10:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmNW4-0006bg-16
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 10:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab1BGJgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 04:36:08 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37038 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1BGJgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 04:36:06 -0500
Received: by wyb28 with SMTP id 28so4330773wyb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 01:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CRmcsHYdrfqCk26UVpRMFFh9zK7iaM1nSkGY+WYNiZE=;
        b=NSYPSa0GgEBTSHX3qzx6wGrG7wG0Oae5bBpWQWIv2Vs+H7o14QNrPDvJaNpZNzFSlD
         lkqWV6+r7b+O7LbgGggx/a2slCT12J4sue5+Umh3AmVwyDfDeZrkbGQpqIslr9MbZ+m3
         bRm7mQ1Zqcy6owGaeUmrdJgJalqBfOPhfw8g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tG5k67H0cap6xijBLofn0KX14u1EDlPtU3fZuuDgx0iJYBETgV2Rk86plwRMoqx55i
         h9oueCwrhR3t8V2/P3YFondoxZz4txgG1/fqF/ff/lIXAfOPQmG8XdYDb2tQthPidPw0
         6lHUkQiLOxYv7OKxou1MxGEfY90FZKUJxUgpA=
Received: by 10.227.152.149 with SMTP id g21mr15374468wbw.20.1297071365394;
 Mon, 07 Feb 2011 01:36:05 -0800 (PST)
Received: by 10.227.129.18 with HTTP; Mon, 7 Feb 2011 01:36:05 -0800 (PST)
In-Reply-To: <1296912681-4161-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166245>

On Sat, Feb 5, 2011 at 14:31, Jared Hance <jaredhance@gmail.com> wrote:
> Adds the option merge.defaultupstream to add support for merging from the
> upstream branch by default. The upstream branch is found using
> branch.[name].upstream.

Why do we need a per branch config for this, isn't .origin/.merge
enough? Or, where is the connection between your new .upstream and the
@{upstream} ref?

Bert
