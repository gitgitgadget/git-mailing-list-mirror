From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.15
Date: Sat, 21 Nov 2009 00:25:43 +0800
Message-ID: <20091120162543.GB3919@debian.b2j>
References: <20091120133117.GA26917@diku.dk>
 <20091120135004.GA3919@debian.b2j>
 <2c6b72b30911200755l16b306cey16efb42fe9ba27da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 20 17:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBWJ2-0003fd-37
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 17:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZKTQZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbZKTQZn
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 11:25:43 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:50747 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZKTQZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 11:25:42 -0500
Received: by pxi42 with SMTP id 42so1870451pxi.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bJ2V8IgtUeykTAIxHtNjt8+NXqroxP/qytA4/HcL6zI=;
        b=RxcQJWIcojGRHRF+LSiNackAM9GldeTFYvO0d8GEwK4YF0VfSs/tZ0KUOh7Q0CkLMJ
         scpf0eXcilaQibghwrkAO8gLO0vri2aMrejY5Fq8kTRaXwQSoRFdEBUkObEk7T6EFE8F
         3SawjUhdvNHkzPYnJ1gQb/w9VOXu4FBLjQE+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C69CuRnNwytOGVqs5C4koWtPeTlRXVC63gDQOt/Hufj3XXXFq82Y7/dUSYCgIMkRqR
         p9lQvdPohiAKnAbK9WeJHrME3AzkekaxUlmBM6VNs5bHQPytQRpVE9wwcCVqPSn459Bt
         JqKxB6CKTq/jw9cJabrSJBAfVTdXcT2HZT0ko=
Received: by 10.115.67.8 with SMTP id u8mr2111412wak.190.1258734348462;
        Fri, 20 Nov 2009 08:25:48 -0800 (PST)
Received: from localhost (n219077015140.netvigator.com [219.77.15.140])
        by mx.google.com with ESMTPS id 20sm1027867pzk.13.2009.11.20.08.25.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 08:25:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2c6b72b30911200755l16b306cey16efb42fe9ba27da@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133359>

On Fri, 20 Nov 2009, Jonas Fonseca wrote:
> install-release-doc-man:
>        for doc in $(MANDOC); do \
>                git checkout origin/release $$doc; \
>        done
>        $(MAKE) install-doc-man

Thanks it works.  Could you also commit this to git?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
