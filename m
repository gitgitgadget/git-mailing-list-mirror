From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree Ready #2
Date: Fri, 24 Feb 2012 18:57:33 -0500
Message-ID: <CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
References: <877gztmfwy.fsf@smith.obbligato.org> <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net> <87sjicpsr1.fsf@smith.obbligato.org>
 <87ty2ro1zf.fsf@smith.obbligato.org> <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org> <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
 <7vobsox84l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	"David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 00:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S151T-0003Mk-1R
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 00:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab2BXX5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 18:57:54 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37472 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2BXX5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 18:57:53 -0500
Received: by yhoo21 with SMTP id o21so1425926yho.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 15:57:53 -0800 (PST)
Received-SPF: pass (google.com: domain of apenwarr@gmail.com designates 10.236.79.202 as permitted sender) client-ip=10.236.79.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of apenwarr@gmail.com designates 10.236.79.202 as permitted sender) smtp.mail=apenwarr@gmail.com; dkim=pass header.i=apenwarr@gmail.com
Received: from mr.google.com ([10.236.79.202])
        by 10.236.79.202 with SMTP id i50mr8985001yhe.61.1330127873361 (num_hops = 1);
        Fri, 24 Feb 2012 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WtnWpj2DRTooN8vqnTmXc22GzIGNlOYTx+QPPxBjfR4=;
        b=eU7eyZT2RazQW59KhxLoXJN1KJX2uC3pkPPPZNrecwNDFIVRvZd2yytm6zCNkzJC5q
         FQiw7/C1SZQmFMD5Tsi54c9/y/pBn4F0zAF/Fg7QpNpUJwIBug9USbHO2AAUwxDhmoP5
         lJNfBOoy8Yr+yRH+Rf8UTN56+tsv7s7tbvu1o=
Received: by 10.236.79.202 with SMTP id i50mr6807493yhe.61.1330127873314; Fri,
 24 Feb 2012 15:57:53 -0800 (PST)
Received: by 10.146.112.6 with HTTP; Fri, 24 Feb 2012 15:57:33 -0800 (PST)
In-Reply-To: <7vobsox84l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191501>

On Fri, Feb 24, 2012 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> Overall I agree that there's little benefit in preserving the history,
>> at least as far as I can see, *except* that some code changes were
>> submitted by people other than me and squashing those changes might
>> conceivably cause licensing confusion down the road.
>
> That is a good point, and it sounds like a good enough justification to
> merge with history, at least for me.

Should we filter-branch or rebase the history first, or just leave it as is?

Like I said, since I don't expect there to be any more back-and-forth
development, rebasing should be pretty harmless.

Avery
