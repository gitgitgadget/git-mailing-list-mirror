From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git push [rejected] question
Date: Tue, 19 Feb 2008 10:18:09 -0500
Message-ID: <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
	 <20080219043353.GA23239@sigill.intra.peff.net>
	 <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com>
	 <20080219150826.GA24499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRUF7-0004tE-B7
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 16:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYBSPSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 10:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYBSPSL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 10:18:11 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:13151 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYBSPSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 10:18:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3532064wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 07:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GDytwbpsd4iWsthAzx5eAOy5Ddd7oirW1q39/wQ6pwg=;
        b=CiW7hhi8u+gtbXFZ2iJEshqKtkyJ1+w9ZnCHDGlTbGBmAF96E2SrgTbSdgutPje+0d3ktGHN4Z263erYpaDbLZEXQs9UY67i2UN5P7yq+8Ul/xZtwCbr18lPOEYNv4r/ci9ILpdk2eHfe2EE/+h0/3vSos8VobTJGzZ01v+UTmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HmpBm/laUzkhett+qXTlmq8verwuEAh13NvDQkBRO4L3kSlr7R4ZfJ0B5KA7UkrhB4P7vEmvhsxHvreqqZTeMs4Tp6sxjssYjNIg3d/Rg95Xm2mPiFbefHLz12jlznmq5SsQFlV268FKV4GsZnJD+9mVmRyJZx9N5mDwc8I583g=
Received: by 10.115.14.1 with SMTP id r1mr4300944wai.31.1203434289313;
        Tue, 19 Feb 2008 07:18:09 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Tue, 19 Feb 2008 07:18:09 -0800 (PST)
In-Reply-To: <20080219150826.GA24499@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74415>

On Feb 19, 2008 10:08 AM, Jeff King <peff@peff.net> wrote:
>
> In the first case we push "matching" refs: any head which already exists
> on both sides. In the second case, we push all heads which exist on the
> sending send, whether or not a matching ref already exists on the remote
> side.

I'd like to nominate you to rewrite all of the git documentation from
scratch. :-) Your explanations are extremely clear.

> > It seems like the default should be to push just the current branch
> > ... this would correspond to what a user of git pull expects (even
> > though the converse of git-push is really git-fetch, for a new user,
> > that might not be entirely clear).
>
> I agree with you, but others do not

Sounds like an opportunity for a config option.

j.
