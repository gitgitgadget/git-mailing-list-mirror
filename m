From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 00:17:24 +0200
Message-ID: <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 09 00:17:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAsKl-0007vR-Qz
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 00:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab0EHWQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 18:16:57 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50648 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab0EHWQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 18:16:56 -0400
Received: by ewy20 with SMTP id 20so581975ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 15:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=wcvzlkZbCCG5iqWNpFtJOTZynmeC1bxRElfXxAFRjDA=;
        b=QPRDQUxzT/Uf3Su6pIIj0npUKC4RrmhoyEctLEd8Nqu/Au29DHBYOsvaUXNxVp5FmL
         BPrmMMUuknVJxsf1J0D8PbYl31f6LZ1Vqxnyp34eKfr7xtcP6mE+vd93I/U83v2gmqmX
         R/bnyTxf8aqTySSfIAuBCLfJEKTUxlmPeuBl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=tkSomli38Qb6HawiqvHqWRGSvBWvh+tVFW5mCwL5Em9utQcJByNsp9bnHSSTf/RvgO
         fMv40yTVvr1y6Fuprqjc+HOEOwGHoGhaINfGo8LHEgVboK1AwzcEYJljmVfaXxlkPXvh
         5iczRztnMYCllr72UkJKaG9/It6ZjiLM0LhfI=
Received: by 10.213.52.199 with SMTP id j7mr452534ebg.79.1273357014510;
        Sat, 08 May 2010 15:16:54 -0700 (PDT)
Received: from [172.16.3.207] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1767173ewy.9.2010.05.08.15.16.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 15:16:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146682>

On 8. mai 2010, at 23.57, Linus Torvalds <torvalds@linux- 
foundation.org> wrote:

> Having two config variables named "core.autocrlf" and "core.crlf" at  
> least
> is consistent. Having "autocrlf" and "eolStyle" is just messed up.

I see your point, but "crlf=lf" makes no sense and "crlf=input" is  
hideous. It's bad enough that autocrlf uses "true" and "input"; this  
is a chance to reduce the insanity, not perpetuate it.

I'll try to think of a better name.
-- 
Eyvind
