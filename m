From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] BROKEN -- format-patch: learn to fill comment section
 of email from notes
Date: Tue, 23 Feb 2010 23:45:46 -0800
Message-ID: <4B84D92A.8060804@gmail.com>
References: <6cf9010742df96e0c68ef8adc1ab392c08525bc2.1266946262.git.trast@student.ethz.ch> <fe0d69eba1b0265c0ca913831ba26e643062f8eb.1266946248.git.trast@student.ethz.ch> <201002231837.11245.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:45:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBwU-0004uw-LM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852Ab0BXHpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:45:51 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48790 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab0BXHpu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:45:50 -0500
Received: by mail-gw0-f46.google.com with SMTP id 16so999897gwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=CnPt1Bbk0R6J4ztjQwS7KyFcSiVnWfWw9D2oXjp5BpY=;
        b=r/+8jfBVX0o/GSj33ADcFDLrsClURimzAKIy+dm33r9wpcRiQpxtJRe5ozzZmhsR8u
         4kbG023O5hodcUdspXFlZQclWzz7Ph2D6FoMUMJ8qk9GypJ/wqQDjGTEBT4D7AcU4EN1
         3mb77P1IRTqKOGgSpFcm5USg73FlOGbqw/iCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=GgKW9x3DUrULtE5zSM3NXJfYt3i64xwhN0DC5+uADyDpOeiewrTIQ3I2373LknUM32
         4Nla9BHAy1uuAtJQBySG4rvrwx0sgWmTeAywiwH98W7uJoxMOsTfwo5piUKkta8RhVIt
         1++7sfI6FCVI51lNTLswzje7YzsnJ4Cd0BUec=
Received: by 10.100.15.19 with SMTP id 19mr2111424ano.72.1266997549905;
        Tue, 23 Feb 2010 23:45:49 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm624337yxg.66.2010.02.23.23.45.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:45:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <201002231837.11245.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140915>

On 02/23/2010 09:37 AM, Thomas Rast wrote:
> On Tuesday 23 February 2010 18:34:56 Thomas Rast wrote:
>> [PATCH] BROKEN -- format-patch: learn to fill comment section of email from notes
>
> BTW, I forgot to say: the breakage is visible in either t4013 or
> t4014, depending which way you tweak the newlines.

Last time I tried to touch the code in this area I gave up. It looks
like you're experiencing the same problem where pretty formats cause
problems in the tests. I would love to see this sorted out so I can
resurrect my dead topic "log-tree: always add --- marker when options
are patch and a stat".

Good luck!
