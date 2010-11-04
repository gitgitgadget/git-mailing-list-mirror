From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 10:27:18 +0100
Message-ID: <AANLkTinmPF-Q9hy+s5qe_66hLaF=msTh_cFc5uZZQxs-@mail.gmail.com>
References: <1288847836-84882-1-git-send-email-kevin@sb.org>
	<vpq39rhzdht.fsf@bauges.imag.fr>
	<914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org>
	<AANLkTimzTzUvoHT9bHve-qvt8V_mvJHmQtgpqY6f_H3u@mail.gmail.com>
	<EE792829-6A68-44FB-8C8D-2365DB4E5A5D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:27:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDw6P-0001Nd-5c
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab0KDJ1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:27:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54572 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab0KDJ1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:27:19 -0400
Received: by fxm16 with SMTP id 16so1253515fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=AE6ygHI8WKFfNetFdrE/R4gfb1Pt+mGsezqkUtFMFBI=;
        b=leMa1Z6O3PLipf/wUenDyvG27W0u+TUpqdnULB0L+MNoSy4DnJxDMvsvQ1Q9UCD+32
         raL3PFya5y7JOONILlKKQlTGQ67bWfINh2knexpQkpgKGoqz703T4C7gGyjG+mXsKSgy
         PAvyu+Uhx2wsE86Aj49nS4NzXr0r5nceP4ZJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kKwPvn2jvNufHtvkjO0OkzFYay42b1xs0FRGg+1xOr0IYbNK0bEqGN6sF54L4eZcOE
         QmmYXzU1Fz1uhr5MoZirqOOdd943ZfvK2Ur7s6VAVKVMugjXPhZyYOnqQw2X60Sbyi12
         RTWdfojkRZpMsFCNYD/5BRtU+4NrAJDJs0CPE=
Received: by 10.223.101.140 with SMTP id c12mr423073fao.16.1288862838771; Thu,
 04 Nov 2010 02:27:18 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Thu, 4 Nov 2010 02:27:18 -0700 (PDT)
In-Reply-To: <EE792829-6A68-44FB-8C8D-2365DB4E5A5D@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160703>

On Thu, Nov 4, 2010 at 10:25, Kevin Ballard <kevin@sb.org> wrote:
>> I thought "shell" would do exactly what your patch does. And it has
>> the "s" short version.
>>
>> So +1 for "shell" from me and -1 for "pause", which *does* confuse me.
>> I'd expect that
>> to just sleep for a few seconds.
>
> "s" is actually taken by "squash". That's why my original patch used "!",
> though a user might actually expect "!" to do what "x" does.

Indeed, eek!
