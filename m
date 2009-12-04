From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH v2 1/8] Pass unknown protocols to external protocol 
	handlers
Date: Fri, 4 Dec 2009 17:01:12 +0100
Message-ID: <fabb9a1e0912040801t6a0a10f7k2892e78285894cba@mail.gmail.com>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<1259942168-24869-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:02:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGabD-0005lU-FL
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529AbZLDQB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbZLDQB0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:01:26 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:59125 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbZLDQB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:01:26 -0500
Received: by vws30 with SMTP id 30so1218922vws.33
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=WM0B3BqmfJnu6oZQzLs1Bt9UJXAYlxYTCVOX+s1oRlc=;
        b=uaYhAu3q4wVImU/Du9m1K5RYakP7EZ77Mv15ALKbL9+aOdYdISo+fYFgl3AmXZ9o5O
         kBPV2nbRgCVRkDR1++Ss7doyWd3jM1vWUYk7mRRlY8IZkeBD+gs/VA5HjVndshj3e0ZI
         N7FnjT7coTn+T/vj3r8z/TvOB9H0DIoiqROQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qVLzyzjOs4XzVGBQRYHeE5duwgflT3jQ9NpoXyiCfrOlU9cmWDTvQ+rxpq75zxVzRq
         6kWmq3FbJaOdhrGf1viSuUsPv95mAGXEonM4QoBE7vcDsurfuB9zx92Zv5EU5D0S8ECX
         I854OOrmz7ORnDGIfepBfBXfXNtiXdpT0ZXEI=
Received: by 10.220.123.2 with SMTP id n2mr4159977vcr.71.1259942492054; Fri, 
	04 Dec 2009 08:01:32 -0800 (PST)
In-Reply-To: <1259942168-24869-4-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134530>

Heya,

On Fri, Dec 4, 2009 at 16:56, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Change URL handling to allow external protocol handlers to implement
> new protocols without the '::' syntax if helper name does not conflict
> with any built-in protocol.

Haven't looked at the patch itself, but I like the idea, a lot.

-- 
Cheers,

Sverre Rabbelier
