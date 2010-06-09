From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH next 2/2] Remove python 2.5'isms
Date: Wed, 9 Jun 2010 23:28:27 +0200
Message-ID: <AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com>
References: <nduJYSHPH3U3cC4hTqPaVi-iLDqB7pemU3zevJMNRmyDsRKmtq_gVu-G9W-She7bPSFG9LafRk0@cipher.nrlssc.navy.mil> 
	<nduJYSHPH3U3cC4hTqPaVieVkcHeedXMjA92T_KB9XTSNMZ0NeKHomHE5LPZ65BzOnHb--wYKXY@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, johan@herland.net, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 09 23:28:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSpS-0004Cd-7W
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 23:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab0FIV2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 17:28:49 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:33628 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0FIV2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 17:28:48 -0400
Received: by ywh42 with SMTP id 42so6098684ywh.15
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=VuV3oINzQTPaXY45rr+3ccdH/ASSwHYsNgZvNf6Vvck=;
        b=MnBTnidyfcvi14rsOwpuSF3RV+If/W4bkkO+Vzzof7/3WAF1gqOJpFCV/QjmRylLAv
         7fztHMAZUxJ7vnFP4s5NWcyHH/IBDNsWpUZ2Kb7CfKH1p63j51bWhZ1elnhGZKURSvZC
         v7iwB+7uvMFB5cgA4NYaLpnZLJue4Oe8EBLHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hGbSrSsnQi/cqH/H7TJkYl3HMgW7+gR9/sFNaPf+PdMCzriuX7HktWeJjJIO3yvDV7
         B4ial26mXeJpiQvGEQs1IG3DrqyvZ5dpaOBwZ4Bn+C+1et2jPLVNdRrMUq7wk068QUT7
         jrjNQqQrhGnXnntdGyvA8p+MVrYHZEKC61H20=
Received: by 10.150.213.15 with SMTP id l15mr376548ybg.125.1276118927118; Wed, 
	09 Jun 2010 14:28:47 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Wed, 9 Jun 2010 14:28:27 -0700 (PDT)
In-Reply-To: <nduJYSHPH3U3cC4hTqPaVieVkcHeedXMjA92T_KB9XTSNMZ0NeKHomHE5LPZ65BzOnHb--wYKXY@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148822>

Heya,

On Wed, Jun 9, 2010 at 23:24, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> The following python 2.5 features were worked around:

Thanks for fixing this, although it makes me sad to see the code
uglify the way it has :P. I guess that's the pain of backwards
compatibility.

-- 
Cheers,

Sverre Rabbelier
