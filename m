From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Thu, 24 Feb 2011 21:01:58 +0100
Message-ID: <AANLkTikHdLqC2=Uw7D_0uJ7m9LuvcUFmVUkC9qAGWiue@mail.gmail.com>
References: <20110224142308.GA15356@sigill.intra.peff.net>
	<20110224143030.GH15477@sigill.intra.peff.net>
	<4D668076.7020000@op5.se>
	<20110224160555.GB30275@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Ericsson <ae@op5.se>, Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 21:02:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PshO2-0008Ow-2Q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 21:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab1BXUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 15:02:00 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55007 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab1BXUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 15:01:59 -0500
Received: by wyg36 with SMTP id 36so904760wyg.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 12:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Yv8DJB5gxQEFVLlCReol22KHV+hrT6UEUUICuy1L+AM=;
        b=mPNQ4sE1CCRF9l+Dt9SManQj50mGN1Wj2x5uVXmCTD4Y9/DWFHeUBmg1xKM+Ld9+wu
         HrtRPNQRnZHZM9yGauohdS/SAQjiwXaikBR+PUmhu/oSqhAGo8wWaITfGmNpi0Boj8we
         lzjg0nxZ/dJlWGSW9nUXMS+qqLnWiTqYLkDzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WRHUq/gfzCp+ggiskGenjStDUsWiSwi+5a726wb3ywZexbD6x1SMgpGWT4PMFpQFfm
         dBJN/0gEaUquC8MeZw8QzlWFAoppAP0re04OlMMtxyZhCJdHzAMRIIgduZr7oQdAzycz
         WN5sNeAYH07SNNIXdsgp276LN16TWCOKNk4sM=
Received: by 10.216.145.154 with SMTP id p26mr6311024wej.11.1298577718314;
 Thu, 24 Feb 2011 12:01:58 -0800 (PST)
Received: by 10.216.241.78 with HTTP; Thu, 24 Feb 2011 12:01:58 -0800 (PST)
In-Reply-To: <20110224160555.GB30275@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167857>

On Thu, Feb 24, 2011 at 5:05 PM, Jeff King <peff@peff.net> wrote:
>
> But those are not strong objections. Just giving the rationale I used
> while writing the patches. I'd be curious what others think.

I think the design is nice!

Thanks,
Christian.
