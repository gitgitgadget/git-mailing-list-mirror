From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 6 Jun 2013 01:48:03 -0500
Message-ID: <CAMP44s0jNoP2bSkkwaxufKVkyG=obHXZwcJPc1CiU4wy9yTjPA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<51AEE1C3.9020507@viscovery.net>
	<20130605071206.GC14427@sigill.intra.peff.net>
	<51B02D81.3000700@viscovery.net>
	<20130606063754.GA20050@sigill.intra.peff.net>
	<CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
	<20130606064409.GA20334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 08:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkTza-0007ZB-0l
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 08:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab3FFGsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 02:48:08 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:64584 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab3FFGsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 02:48:06 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so2255972lab.32
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cnc+DepKCcPRBkARYac6oMOpQR5iF3swkxv3ysMapB0=;
        b=VzNVfDfQIqFNBgkSDE3Fko6aJLpmLRF2MzY03es/m3fdRRT16b0WI7uGpDG/ca5ffw
         yg3YCfdAPPotGvG2YzdlHpDLPTZiUNev1R2njvVmZwNIy4GAjqzasEn9jUFEazbw7gY1
         8wABl4icEY4kbZA7Dz3kwIc/z6Qh9IY+vBAB0uxle8FqCibj8LTpNiNSc914URtXKExU
         8W0p+E7oWZcct1QtPPcMuJkjNzptneBYKLw27R0IQgHnV8WHTC/eymh3c43CxKNZSnlI
         QttpBdNynPfUXHeQjJV6TWghBb2eNC8/lUPqtdx72aQ8oAaPasnlOpF+AYeRewj6mtuv
         JwFA==
X-Received: by 10.112.132.66 with SMTP id os2mr10656808lbb.118.1370501283755;
 Wed, 05 Jun 2013 23:48:03 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 5 Jun 2013 23:48:03 -0700 (PDT)
In-Reply-To: <20130606064409.GA20334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226483>

On Thu, Jun 6, 2013 at 1:44 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 06, 2013 at 01:41:05AM -0500, Felipe Contreras wrote:
>
>> > Thanks. I wasn't quite clear on how the signal handling worked on
>> > Windows, but from your description, I agree there is not any point in
>> > running the test at all.
>>
>> Shouldn't we clarify that Git exit codes only work on UNIX-like
>> operating systems?
>
> Clarify where?

Documentation/technical/api-run-command.txt

> My impression is that this issue is well-known in the
> msys world, and it is a platform issue, not a git issue. If somebody
> wants to write a note somewhere in the git documentation, that's fine
> with me, but I'm not clear on exactly what it would even say.

That the exit code is not the same in Windows (not msys).

-- 
Felipe Contreras
