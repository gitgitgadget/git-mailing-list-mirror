From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-pull.txt: Add picture to --rebase option
Date: Fri, 03 Dec 2010 06:56:24 -0800 (PST)
Message-ID: <m3oc923nyz.fsf@localhost.localdomain>
References: <1291365669-10439-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 15:56:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POX3q-0006kU-0o
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 15:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab0LCO43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 09:56:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45885 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab0LCO41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 09:56:27 -0500
Received: by bwz15 with SMTP id 15so8402496bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 06:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uj6eKMO9815g4jvX+mI69vvumo8XneC/EHKc0tnxQ1g=;
        b=UsKmhPoCSIipAW+3vIG5smvDhTnx/m7eN4KvjnJm83fRMo+k0KM5jlgk8ReTWuMj4+
         Dtc3PZju7GFTnFX1LSNFho/cQrXtZgJcW0XxHtV1sKMXJJU56TqGd1X2wFxG8gBGOQbm
         srkiNVfcDcxesIef0PFQFSzS89OkQ2ZmL9ZDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=RiItHUxRC4X7+MyxRyTDsTUv2oXeN+S979f3be63ATz/EmC8aR9/O5rB9Hl6KKWznW
         PbO2eAcDaK7/zWzbmmGVgYY5qdy4sRZWQaHTIUXizcUhXg3UC0IWfLrRrGuOdNsTmQlZ
         gL9foVuEDkXzsM32q6wwvMNIbqroJfOnnKWt4=
Received: by 10.204.119.15 with SMTP id x15mr2454374bkq.22.1291388186542;
        Fri, 03 Dec 2010 06:56:26 -0800 (PST)
Received: from localhost.localdomain (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id d11sm258078bkd.10.2010.12.03.06.56.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 06:56:24 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB3EtpkS021744;
	Fri, 3 Dec 2010 15:56:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB3EtWri021740;
	Fri, 3 Dec 2010 15:55:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291365669-10439-1-git-send-email-jari.aalto@cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162801>

jari.aalto@cante.net writes:

> From: Jari Aalto <jari.aalto@cante.net>
> 
> Illustrate what are the effects of the the option.
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>

> ++
> +The effects of this option are:
> +------------
> +    [initial]
> +    o---o---o---A--B   Your work in commit A and B
> +
> +    [git pull --rebase]
> +    o---o---o---*---*--A--B
> +                |   |
> +                New updates merged in. Your work is rebased
> +                on top of them.
> +------------

Good idea.  Thanks.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
