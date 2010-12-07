From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 15:29:49 -0600
Message-ID: <20101207212949.GA25162@burratino>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
 <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
 <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org>
 <4CFEA249.907@web.de>
 <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Kevin Ballard <kevin@sb.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Scott Kyle <scott@appden.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ573-00026K-KK
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab0LGVaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 16:30:04 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:41403 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0LGVaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:30:03 -0500
Received: by ewy10 with SMTP id 10so431294ewy.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PZO8s5GVr/hc6hGvqEJ9XDNaj18sCCkhebqfW0G2n0Q=;
        b=oBJnIIP4emyhuBbc5qfzjJnTSY8ioGnsMu6JzW0Wa4X+MMy7so48zUZkj913qZVhxv
         2IQjRTcJ5E07UafrTzlAYZ/ImZuo5/ZIPugCbzFjIniHGtn0WmjvE0nfzTICuEb4H8qo
         dctj6IP33ZmQF22ZBLImdlHLylZaDTfuN1Uvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nCBPsKbBBUrSnuUtYeADJO2I9pJfX7hyaxR5K2Iat9JYJXw4Eqb2BhEBvTRbzRBMhR
         eDA8Igqo4vQZUoU9SwZ1nsSIFXqbl8HBmsOcvBVHDk9PbKNGhqDRTxSbo+V08QKSVqjK
         FOjwP7g14suAc36Mf9Lf4DPZIPNwjvzdh5tac=
Received: by 10.216.178.4 with SMTP id e4mr849271wem.28.1291757401578;
        Tue, 07 Dec 2010 13:30:01 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id x28sm3194874weq.16.2010.12.07.13.29.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 13:30:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163140>

Scott Kyle wrote:

> If I set the "submodule.<name>.ignore" then diffing around inside my
> history will not show the changes to that particular submodule.

Even if you set it to "dirty"?
