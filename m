From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: handle root commits with external strategies
Date: Thu, 12 May 2011 16:50:11 +0200
Message-ID: <BANLkTinyLeTL=-rUPEZOQapudWCR_Lbh4w@mail.gmail.com>
References: <20110512110855.GA5240@sigill.intra.peff.net>
	<20110512110946.GA5292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 16:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKXDZ-0005kY-Io
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 16:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab1ELOuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 10:50:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45422 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1ELOuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 10:50:13 -0400
Received: by qwk3 with SMTP id 3so815231qwk.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uJosp7VoI+yd0pSRIMQQBh8+vEQWZS1gw8K1l6qxSr8=;
        b=SlHcg/VARdqT85nFw4M1QZrwt4mesj/n/VGABW6013SCPsnZz59+xprRwpAlgwdhpG
         iSoS/EF9DWO73apA3F5Mvijc6+Uj+XRwkeWscD7J5npA6+/gOb18OAfeLbmag0RVxnbt
         I6V9zApoX5NVtAqm2qtP/wcjF4uXf5gf9t6Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fWSyExiCvW4Ut55deaPDGuz2tX6LoCZxXJvFssqix+BGmd7n/94+tyZCv4nvKKtkCD
         EOwRjDDgCZSepXPAeKDBrgByWnVhgNKVyHw+Uoce0pT3GMj9WDt0B3+XJy5gjSu3b+op
         FpPSgrWqHrVd7nMeg3PO7TJE3Em0rsXl5tP8Q=
Received: by 10.229.214.204 with SMTP id hb12mr215300qcb.261.1305211811438;
 Thu, 12 May 2011 07:50:11 -0700 (PDT)
Received: by 10.229.213.134 with HTTP; Thu, 12 May 2011 07:50:11 -0700 (PDT)
In-Reply-To: <20110512110946.GA5292@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173473>

On Thu, May 12, 2011 at 13:09, Jeff King <peff@peff.net> wrote:

> The merge-recursive strategy already handles root commits;
> it cherry-picks the difference between the empty tree and
> the root commit's tree.
>
> However, for external strategies, we dereference NULL and
> segfault while building the argument list. Instead, let's
> handle this by passing the empty tree sha1 to the merge
> script.
>
> Signed-off-by: Jeff King <peff@peff.net>

Works perfectly for me, thanks a lot for coming up with a patch incredibly fast!

-- 
Sebastian Schuberth
