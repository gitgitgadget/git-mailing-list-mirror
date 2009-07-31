From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 14:24:28 +0200
Message-ID: <40aa078e0907310524x1fe4d84dr858ebc03731ee093@mail.gmail.com>
References: <20090726232154.29594.qmail@science.horizon.com>
	 <20090731104602.15375.qmail@science.horizon.com>
	 <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>
	 <4A72D76D.3050400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 31 14:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrA6-0006sj-8u
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZGaMYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZGaMY3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:24:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:56189 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZGaMY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:24:29 -0400
Received: by bwz19 with SMTP id 19so1157726bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4xdUn6R6/cir+1rE/lUtvyPyBR1E3Zeup1ZtNGCi9bo=;
        b=NPwXOPz/kDkVJDUrk0viDsTLBylawmTVqmm2lNwqG71hN3q6VDY0EZHDJ9lOahihSX
         it4e73VNG00f5mJocP1EYr7omuTB+vTyGbEdePiyxDMoleZj8I2ncnqla1lNr9ZM0UNi
         3TZjZkI9UKOl56c4UG7mv2T9MKY1t/hZVXYU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U2LLDChmqHtTpGwCUA5RHZCN3jWW0C5f/EM0XbT8X2xL0RMMpg1Y5KI0SFnZlwHVPr
         ZHvsh9jGbknTJfmo6XRYKIHrdh7JR2k0ONGWyP+LvRgKMD8MyzHwzsRwmUR0Ll6meUxH
         oreT1J0iR5hbp7GLKgPVquD5/SbYs21mVggXI=
Received: by 10.204.58.79 with SMTP id f15mr2675376bkh.202.1249043068847; Fri, 
	31 Jul 2009 05:24:28 -0700 (PDT)
In-Reply-To: <4A72D76D.3050400@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124550>

On Fri, Jul 31, 2009 at 1:37 PM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
>> What did I do wrong? :)
>
> You need to go to the x86 directory, apply the patch and run make there.
> (I made the same mistake.) Also, you i586 (32bit) glibc-devel if you're
> on a 64 bit system.

Aha, thanks :)

Now I'm getting a different error:
$ make
as   -o sha1-586.o sha1-586.s
sha1-586.s: Assembler messages:
sha1-586.s:4: Warning: .type pseudo-op used outside of .def/.endef ignored.
sha1-586.s:4: Error: junk at end of line, first unrecognized character is `s'
sha1-586.s:1438: Warning: .size pseudo-op used outside of .def/.endef ignored.
sha1-586.s:1438: Error: junk at end of line, first unrecognized character is `s'

make: *** [sha1-586.o] Error 1

What might be relevant, is that I'm trying this on Windows (Vista
64bit). I'd still think GNU as should be able to assemble the source,
though. I've got an i7, so I thought the result might be interresting.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
