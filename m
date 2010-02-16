From: Kevin Menard <nirvdrum@gmail.com>
Subject: Re: git fetch origin hanging in 1.7.0
Date: Tue, 16 Feb 2010 08:20:40 -0500
Message-ID: <7e3605161002160520tf0509b1u700a8b9c7e39b3a@mail.gmail.com>
References: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com> 
	<20100216063959.GC2169@coredump.intra.peff.net> <20100216151821.994ace31.rctay89@gmail.com> 
	<20100216072456.GG2169@coredump.intra.peff.net> <be6fef0d1002152332k2983d750l7b76496118dc3952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:21:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhNMU-00023H-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 14:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0BPNVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 08:21:04 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:58132 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab0BPNVB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 08:21:01 -0500
Received: by yxe38 with SMTP id 38so4140979yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=TukCqXnk/e8LlVXzFLA7/4xY9bPPXJ86LagoxpTjTpo=;
        b=KqdxAQSBuo4k8Uuhzjst0OToGoNFPCeaq8IadX9JxyKnTzBB6miKJLGJXJ95SO6ucI
         +K74vQSxjm0ZolXHXAoY8brdXDhHl2RapP0tAvftA6KcLOg/zKb//qiDh5mT3scO7bj2
         FCwtc0gJtOJhoeU0IDJLcKrltRaBADq4piKlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=N/+xs8PlfVKsY+l3sTXRrNLWRWArAIF1GsB31pVpne5GeJcYQ22MlSv5uedUK3PRDW
         snqhbawDmv2v+FbxsY5K181ZWdf8MpjntSQGawM08NbHm6uMyMlyNVtZ9HyotCtCo2EA
         kwYNXsk4+HvnOG6gt1YvxRdSD9Yc3SL850xVc=
Received: by 10.150.174.35 with SMTP id w35mr12145245ybe.8.1266326460152; Tue, 
	16 Feb 2010 05:21:00 -0800 (PST)
In-Reply-To: <be6fef0d1002152332k2983d750l7b76496118dc3952@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140101>

On Tue, Feb 16, 2010 at 2:32 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:

> Kevin, I didn't add a Reported-by line, as I don't regard my patch as
> actually fixing the issue at hand (hanging read) - it just side-steps
> the issue. Hope you don't mind this.


No worries.  I'm just grateful someone more knowledgeable than me
could take a look, confirm it was an issue, and supply a patch.
Thanks to others that chimed in as well.

-- 
Kevin
