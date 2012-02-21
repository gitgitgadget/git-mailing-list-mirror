From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Tue, 21 Feb 2012 08:21:35 +0100
Message-ID: <CAA01Csrmnx9TcmH8TkYyJDx5dcre0ASKr+1-v-8fwP7YPVWQJg@mail.gmail.com>
References: <20120217222912.GC31830@sigill.intra.peff.net>
	<CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
	<20120220140653.GC5131@sigill.intra.peff.net>
	<87ty2l38ay.fsf@thomas.inf.ethz.ch>
	<20120220143644.GA13938@do>
	<20120220143952.GA8387@sigill.intra.peff.net>
	<20120220151134.GA13135@sigill.intra.peff.net>
	<87d3991gyg.fsf@thomas.inf.ethz.ch>
	<20120220203540.GA5966@sigill.intra.peff.net>
	<7v1uppkvpx.fsf@alter.siamese.dyndns.org>
	<20120220224140.GA7116@sigill.intra.peff.net>
	<7v8vjxjd47.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 08:22:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzk31-0002UE-CO
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 08:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab2BUHVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 02:21:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56126 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab2BUHVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 02:21:36 -0500
Received: by iacb35 with SMTP id b35so8549938iac.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 23:21:35 -0800 (PST)
Received-SPF: pass (google.com: domain of piotr.krukowiecki@gmail.com designates 10.42.174.8 as permitted sender) client-ip=10.42.174.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of piotr.krukowiecki@gmail.com designates 10.42.174.8 as permitted sender) smtp.mail=piotr.krukowiecki@gmail.com; dkim=pass header.i=piotr.krukowiecki@gmail.com
Received: from mr.google.com ([10.42.174.8])
        by 10.42.174.8 with SMTP id t8mr25500433icz.54.1329808895807 (num_hops = 1);
        Mon, 20 Feb 2012 23:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UB7Wm5rYewr4fubyxn3BctybkjGXFOBb9qKzGPIDRh0=;
        b=VU7lRKLaTdT3h4mSEczhr1/JBJXeeqIuS+v+GCFVwwrhSEP2w+TFI7zmBkMxB8PNa4
         o9up7F8JSEneTpB0qSsq72RIma8y3Hp1rv+pJBTVeoGbNkEwxFh6tD33cz+hczdipMnk
         ETPxSWgnixmYcF4Zhcx64hNdDl5o93xlGcUxc=
Received: by 10.42.174.8 with SMTP id t8mr20321342icz.54.1329808895761; Mon,
 20 Feb 2012 23:21:35 -0800 (PST)
Received: by 10.50.60.73 with HTTP; Mon, 20 Feb 2012 23:21:35 -0800 (PST)
In-Reply-To: <7v8vjxjd47.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191138>

On Tue, Feb 21, 2012 at 12:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
[...]

Hi,

I hope the fixes will also help git-svn users? I.e. there's a lot of
rebasing (and cherry-picking - at least in my case) and probably some
other stuff going on under hood. I.e. I hope that if I git-svn rebase
or cherry-pick, it won't invalidate the cache...

Thanks,
-- 
Piotr Krukowiecki
