From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] diff: vary default prefix depending on what are compared
Date: Wed, 20 Aug 2008 02:06:50 -0700 (PDT)
Message-ID: <m3k5ecrr6j.fsf@localhost.localdomain>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	<alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	<7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0808181628420.19665@iabervon.org>
	<7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0808181839390.19665@iabervon.org>
	<7vy72tit90.fsf@gitster.siamese.dyndns.org>
	<48AA4430.3060207@gmail.com>
	<7vmyj9h567.fsf@gitster.siamese.dyndns.org>
	<7viqtxh4gt.fsf@gitster.siamese.dyndns.org>
	<7vljysru9b.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Marcus Griep <neoeinstein@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 11:07:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVjfa-0001MO-NU
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 11:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbYHTJGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbYHTJGy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 05:06:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:3393 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbYHTJGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 05:06:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so191837nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+9Apu4K6UtW+HRpw3cjm6isp0uJL5uMFjh2bI4uBZjQ=;
        b=iShx0YLxqvrOT09zVGx1E9rVPEA33fuINz55f5kaUN3pvZCBT4AhJh/5vMlNOtWw0s
         HKQAhe8EFaXmt+cDrbGogT7LAPErcV84bs8o/NQ/K5yqQzNN0vIeQskE9MFZF/4HrfL0
         mQ5rAToz26d5Xbi81JydjrCwa9We0tebk6ZQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=U0eFt/qhkI+RrvCtYghaIiiS4B43IK6zQq7HKEjMQaWKE+/f07IsySMe7OS8JsbAWJ
         IXJmwKjeLiyLMo47mrfgtS/PSF0hpM4anYdEAaeOkMOWX2WFuGtyMXFYXuYN93XPi/c5
         bbIgnG6dh1OAh2065+fSN8yBnZTo3nxivcAds=
Received: by 10.210.34.5 with SMTP id h5mr11298045ebh.84.1219223211139;
        Wed, 20 Aug 2008 02:06:51 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.231.175])
        by mx.google.com with ESMTPS id f6sm7106425nfh.12.2008.08.20.02.06.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 02:06:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7K96kJZ009145;
	Wed, 20 Aug 2008 11:06:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7K96i35009142;
	Wed, 20 Aug 2008 11:06:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vljysru9b.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92973>

Junio C Hamano <gitster@pobox.com> writes:

> With a new configuration "diff.mnemonicprefix", "git diff" shows the
> differences between various combinations of preimage and postimage trees
> with prefixes different from the standard "a/" and "b/".  Hopefully this
> will make the distinction stand out for some people.
> 
>     "git diff" compares the (i)ndex and the (w)ork tree;
>     "git diff HEAD" compares a (c)ommit and the (w)ork tree;
>     "git diff --cached" compares a (c)ommit and the (i)ndex;
>     "git diff --no-index a b" compares two non-git things (1) and (2).
> 
> Because these mnemonics now have meanings, they are swapped when reverse
> diff is in effect and this feature is enabled.

>  
> +	diff_set_mnemonic_prefix(&revs->diffopt, "o/", "w/");
> +

Somehow you lost in the commit description and in the added
documentation the (o)bject prefix (explicitely naming 'blob' object,
for example HEAD:a, or :2:b, or 7a7ff130a34942506e6068105ac5946c9404bf18)

It is also not obvious IMVHO that when comparing two trees (two
commits) git uses default 'a/'..'b/' prefixes.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
