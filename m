From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Using signed tag in pull requests
Date: Wed, 18 Jan 2012 13:34:14 +1100
Message-ID: <CAH5451mz7NpDyL9O708siBdgSC7eXZi=VWk5qd2Ghm0PmWZ9NQ@mail.gmail.com>
References: <7vehuyosaa.fsf@alter.siamese.dyndns.org> <CAH5451nSMcJ50fu2qtMkw4zPpx-Kg-k-jqCcpryu+pkC8JX8rw@mail.gmail.com>
 <7vwr8pok7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 18 03:34:50 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RnLML-00028k-Lk
	for glk-linux-kernel-3@lo.gmane.org; Wed, 18 Jan 2012 03:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab2ARCei (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 17 Jan 2012 21:34:38 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53370 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756531Ab2ARCeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2012 21:34:36 -0500
Received: by lahc1 with SMTP id c1so1915914lah.19
        for <multiple recipients>; Tue, 17 Jan 2012 18:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sZ73Fofty0ewtxBsRK7rkaM5Gd5DaCt0Prcu6fzrmYU=;
        b=Atzyskdf1dv2POpSyeWNSBiOcyNJhCWGgbrmkYwYqTaYROGqFW4r+F1K1E+1LSHglH
         vmYkgV/zHMTytD6rxLaJ6HRkpaU9eLnv1apunCfgumGdlKB9wqc45gTX58qT4jrXFvRt
         OR0cWS9hzkWga4rVsWjIcUIFe37hS2Gx/9iy0=
Received: by 10.112.100.199 with SMTP id fa7mr4720319lbb.89.1326854075233;
 Tue, 17 Jan 2012 18:34:35 -0800 (PST)
Received: by 10.152.14.71 with HTTP; Tue, 17 Jan 2012 18:34:14 -0800 (PST)
In-Reply-To: <7vwr8pok7w.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188738>

On 18 January 2012 12:47, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>>> Starting from Git release v1.7.9, a contributor can add a signed tag to
>>> the commit at the tip of the history and ask the integrator to pull that
>>> signed tag. When the integrator runs `git pull`, the signed tag is
>>> automatically verified to assure that the history is not tampered with.
>>> In addition, the resulting merge commit records the content of the signed
>>> tag, so that other people can verify that the branch merged by the
>>> contributor was signed by the contributor, without fetching the signed tag
>>
>> I think you mean to say 'the branch merged by the integrator was signed
>> by the contributor'.
>
> Definitely. I'll update my local copy.
>
> Thanks for spotting this.

No worries. That's the whole point right? :D
