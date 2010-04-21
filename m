From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 17:55:49 -0400
Message-ID: <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:56:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hu5-0002UY-Hy
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807Ab0DUV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:56:12 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48168 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab0DUV4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:56:11 -0400
Received: by wwb24 with SMTP id 24so4400453wwb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=wBsLqLFnB+htLDCbtB1sUQ1eUA5F6LafYi7xERAsgJM=;
        b=fM4vq5ijQliBWZ6M2aCkWocKn21ZyKfKL1dP1PQaypMmvpNAy4JL8U9EDCXbBJ6+oC
         cDDsY/zeTJA9nwwqbDi3L1aTZUtIlDHaXpRkSQQYiFrP2hH79igZgpdAwEoCmfEdVhrZ
         pvJG2LFoQ53IrZWPa1XaLYW/iLzkDS/zdIr30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=c3AsfqkW2HXTPCHKR/HPms0oZGcntP93kAFtYg2/DOjP3ZEQseGz+YZ9XaCL9f8Qmo
         BRuszP8DfIQlUsxHLNXCN0OQyDNSpUsT8xhpn1Oi7OcVsC1khIqckr55iyJstcjHe39t
         Zibv/KcaZrVFNbfDvwfRmooNI4sIaxTevQZBw=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 14:55:49 -0700 (PDT)
In-Reply-To: <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
Received: by 10.216.86.19 with SMTP id v19mr3299255wee.218.1271886969136; Wed, 
	21 Apr 2010 14:56:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145465>

> When you do this you're telling git "I want a new branch from where I
> am right now". If you want to be able to pull in a similar way to how
> master works, use the '--track' option.

Actually, the '--track' option is exactly what I don't want ! :) It tells me:

"Branch test set up to track local branch refs/heads/master."

Without the '--track' option it seems to work as expected: when I pull
it downloads data form the remote but then stops before merging.
This used to work! What happened ? :(

  -- aghiles
