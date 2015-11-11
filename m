From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Tue, 10 Nov 2015 19:22:07 -0500
Message-ID: <CAM-tV--dCUQwc7dAjgNUpHYx-T4VhdZ_gzcY+=6ZsfLhDF_MEg@mail.gmail.com>
References: <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
	<20151030001000.GA2123@sigill.intra.peff.net>
	<CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
	<20151030005057.GA23251@sigill.intra.peff.net>
	<CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
	<20151030210849.GA7149@sigill.intra.peff.net>
	<CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
	<20151109155342.GB27224@sigill.intra.peff.net>
	<CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
	<20151110122501.GA14418@sigill.intra.peff.net>
	<20151110122625.GB14418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 01:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwJAz-0004gS-K8
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 01:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbbKKAWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 19:22:09 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33630 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbbKKAWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 19:22:07 -0500
Received: by igvi2 with SMTP id i2so109734238igv.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 16:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cavntBdqfQxFNEc8+gOv9D2b+ISBCC/A+pRrI9CFzWc=;
        b=HDJR+LuQqFvl9JmL9wdx5x6cZIbdYcOTAXDe/4Y3ptm7CgVBM2ZWWf5U2O94yGjk6e
         v2xQAlUGo0xKtypdwgSGlbodtJuXanzbDE+dbbTIn2rlqJrnLslrp1/hqMSb3K9lwpBC
         Bgzy2teqWAY7tr00KMQru5vXYam6TtFBpLsQcfZ00jz/B7w1d3M2MVlBeI4kSutAsqlI
         UC2XovPnjzd6V296kTnF6SODQ29EF2pK5PNWkKSusysPZi+WIFn9zd6UGKVemUrteA3W
         5+PdjwbZGfI0KzWvx/KTpUdieM4X5TNR5Awe+e0IQ1CYgaWG3uQgtSMdrW1QfZb+cmB4
         jhxw==
X-Received: by 10.50.131.234 with SMTP id op10mr30055398igb.58.1447201327278;
 Tue, 10 Nov 2015 16:22:07 -0800 (PST)
Received: by 10.79.119.2 with HTTP; Tue, 10 Nov 2015 16:22:07 -0800 (PST)
In-Reply-To: <20151110122625.GB14418@sigill.intra.peff.net>
X-Google-Sender-Auth: toI-ihK0wTiMwJ03w9moUvJ-KpY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281139>

I think you're right about the automated test not being worth the trouble.

On Tue, Nov 10, 2015 at 7:26 AM, Jeff King <peff@peff.net> wrote:
> To clarify: just telling me it's OK to add your sign-off is fine here. I
> can add it (and fix up the style thing) as I apply.

Ok, please do that then, thanks.
