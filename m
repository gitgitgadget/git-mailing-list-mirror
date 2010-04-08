From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Replace hard-coded path with one from <paths.h>
Date: Thu, 8 Apr 2010 13:26:07 +0200
Message-ID: <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
	 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
	 <20100404222801.GB31315@arachsys.com>
	 <20100406163525.GF15306@arachsys.com>
	 <20100406163643.GG15306@arachsys.com>
	 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
	 <20100408105850.GD2146@arachsys.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 13:26:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzpsG-0001GS-3L
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 13:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758609Ab0DHL0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 07:26:11 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:40858 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758603Ab0DHL0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 07:26:10 -0400
Received: by bwz1 with SMTP id 1so1687023bwz.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type;
        bh=oyM9fiRovPTJNw8lEtL1RjEtjqT/GEiyPZNgD4+iJLQ=;
        b=EuBr6xFhSssocYp1w4umwZWpGt5H5/RNGT7ToEhWr0AKIAVDSm/3l+4pn7twz5ylY+
         SS1Pr2HMhPtwwpVD+m1MrSEexJVcjOPE9UobatLtlY2R6Ulj9vwBWabUpV94xwM5Nfq0
         uDwixBKVs76kiPA+78eLsc20V7csoaAiK+cYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=m72PN7UZzdyb8THT9QywEX4aPPhv6d2d5SuIgPUzDy2mrMD68nsaypaPUcYeJiCxls
         dSxSz2/+YiYU0Hgrb3zW/rYe3O4riJUTZ2XT02mPmykWW10BEU309tept96k24+qmTXS
         0qFtTLeOKtlhpHgWBrfIQXb5ZdcqDyadIUn1k=
Received: by 10.204.72.202 with HTTP; Thu, 8 Apr 2010 04:26:07 -0700 (PDT)
In-Reply-To: <20100408105850.GD2146@arachsys.com>
Received: by 10.204.80.99 with SMTP id s35mr10580084bkk.183.1270725967816; 
	Thu, 08 Apr 2010 04:26:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144352>

On Thu, Apr 8, 2010 at 12:58 PM, Chris Webb <chris@arachsys.com> wrote:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>
>> > +#include <paths.h>
>>
>> This breaks on Windows due to missing paths.h. I guess you need some
>> guard to detect if the header is present or not.
>
> Is this true of all WIN32, or just __MINGW32__ / __CYGWIN__?

I've only tested it on mingw (msysGit). I don't know about cygwin and msvc.

-- 
Erik "kusma" Faye-Lund
