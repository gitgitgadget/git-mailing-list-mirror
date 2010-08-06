From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git server eats all memory
Date: Fri, 6 Aug 2010 11:37:42 +1000
Message-ID: <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-10@kanis.fr>
X-From: git-owner@vger.kernel.org Fri Aug 06 03:37:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhBsd-0006GI-WC
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 03:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934351Ab0HFBhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 21:37:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37686 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217Ab0HFBhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 21:37:43 -0400
Received: by wyb39 with SMTP id 39so7280211wyb.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=J04JzKyKd3bT/hr+8wNQPbuEdn6sPCVQILMGeVBPWJ0=;
        b=vhCPIuKm5MThZKO4BqklvecLDajWmteti7R8gghWpYGyE3ZH7Exq1ETY+t/5N0PNGP
         GdZA0Zi2Epd/Yv2yQy6hs07dFdz8kkab8b9UVwPQ7tSjCRANOobDa6fZ+0Zs6uK/mlW6
         oMg5R7wEzvmwoHCNmGl11Qa/5DOXlpe3Wc918=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=skKcWluB0eFsknBuIVs1c7B3sdmP+8W2iOswdGrxc2cSRumYiGliI4KSohOp/1KiUh
         GPXDzV6lDTNxP1jn+CpFp64D3uKawoXa21fIpp9Ogc0VKbC4AQ87ZHmbxhwLcWZ3VMBR
         DahgESvPahQ22O42zXSGFQB7dxFOLDc7bW+1o=
Received: by 10.216.167.145 with SMTP id i17mr293517wel.41.1281058662651; Thu, 
	05 Aug 2010 18:37:42 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Thu, 5 Aug 2010 18:37:42 -0700 (PDT)
In-Reply-To: <87ocdhlgbl.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152742>

On Thu, Aug 5, 2010 at 4:33 PM, Ivan Kanis
<expire-by-2010-08-10@kanis.fr> wrote:
> I am ready to do whatever to diagnose the problem. I know C pretty well
> and am ready to look into it but I am not sure where to start.

Try "git pack-objects --all --stdout > /dev/null" on the repo on
server to see if it uses the same amount of memory you saw in cloning.
You can then try debugging that command if it does.
-- 
Duy
