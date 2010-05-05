From: Scott Chacon <schacon@gmail.com>
Subject: Re: Does recent 'smart' HTTP feature help git-svn thru unfriendly 
	corp. firewalls too?
Date: Wed, 5 May 2010 07:32:19 -0700
Message-ID: <i2ld411cc4a1005050732nf1e4a91fv6c25142936f7aef6@mail.gmail.com>
References: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
	 <20100505141636.GG11053@spearce.org>
	 <i2yd43c95441005050720rccceadcex88a2ce6730d96a5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Michael Norman <mwnorman@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 16:33:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9ffO-0002Hw-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760276Ab0EEOcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:32:24 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63599 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933775Ab0EEOcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:32:22 -0400
Received: by wwd20 with SMTP id 20so488614wwd.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=z504r44cbXEbZG1GzJqej6GVh52x18fx0emTcxZSQ0E=;
        b=OQYNjTW9q8nz3O6a1sw1UHlzCM/QcXHmdz9iqX9TAvjhURKa8yhpuNqFs4/qcwAgd7
         NVXpy1A1ZAtze9BNiyloO5i2DPgbTxMSycXdtPuJ1ImTC2I7MiXKHdSFXlha79BCUJkN
         fP9/ioXK4v13x7DETwdurbqJ7aDbc4kM4XtQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SSx/MhKcDik3G4scZCtgbMlsGKnyBBRtEp0LO/lZfnbCqrnguLIpwhk5dMZ8nqmV2O
         /F2Bw0AiGx/Qe3nveJnxSoybH/VIW0LMqIe1JgT6nUZWWy973y4SPodQ37rzcwDcnpPj
         A1mJRW2kXl74jwzfK8hk2RvOKSEhndUD/2RPI=
Received: by 10.216.86.3 with SMTP id v3mr6213736wee.190.1273069939758; Wed, 
	05 May 2010 07:32:19 -0700 (PDT)
Received: by 10.216.3.13 with HTTP; Wed, 5 May 2010 07:32:19 -0700 (PDT)
In-Reply-To: <i2yd43c95441005050720rccceadcex88a2ce6730d96a5d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146401>

Hey,

On Wed, May 5, 2010 at 7:20 AM, Michael Norman <mwnorman@gmail.com> wrote:
> Sigh - most SVN installations require ssh+svn for read/write access.
>
> Our company is changing firewall vendors and I have been told that our
> TortoisePlink+putty-session 'trick' may be blocked :-(

You can use GitHub for native SVN and Git access, both over http -
that will allow you to use Git as the main repository as it should be.
:)

Scott
