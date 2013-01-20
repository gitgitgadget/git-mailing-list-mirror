From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2] INSTALL: git-p4 doesn't support Python 3
Date: Sun, 20 Jan 2013 13:03:10 -0800
Message-ID: <CA+sFfMfCi-cvgRXE7KnPAsQpMWFR8eMiG0wQ0vL+p+U=R2R2qw@mail.gmail.com>
References: <20130120110620.GJ31172@serenity.lan>
	<7vwqv7lm6b.fsf@alter.siamese.dyndns.org>
	<20130120192831.GB7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:03:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx23B-0003G7-9T
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab3ATVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:03:12 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:45124 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab3ATVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:03:11 -0500
Received: by mail-vc0-f171.google.com with SMTP id fk10so3730397vcb.30
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Hiky2qRNKED/E5y0as4Igu4DmCO5aFgn947rGjQyNEY=;
        b=Fsi+pwX/hGSUnPLzcknJZUs6dHQj7VEg9zzbMX0u7IbDqtMdhAQ6xR0Lbsa69qJOu6
         Q9wQQQtrxsgt+FbfGgzenIs0k/TnDQSVIlrdzaobFGnNDMESaeCKUGdNz1Xv6OT3m5Kw
         NlT2DsgCDADyHnVMqS/9fC/nSgt9BIbBDwQNfIDQ7/edZxYez53IVbdJMamAe9+n4S6W
         WkUAhCyHzpzzDSq1VTjasZTpY91fKg80K6aL6fVtKjm2QCvHBb05B2niZIZmxFJRgA16
         QQDjGFFoEm48TqMpJMUd+3PN/CtwpWXgVNMTN6mH71fu2mjwtlaJuppUUK80D8Ccg1jy
         gr7g==
X-Received: by 10.220.151.72 with SMTP id b8mr17113757vcw.38.1358715791076;
 Sun, 20 Jan 2013 13:03:11 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Sun, 20 Jan 2013 13:03:10 -0800 (PST)
In-Reply-To: <20130120192831.GB7498@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214048>

On Sun, Jan 20, 2013 at 11:28 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Jan 20, 2013 at 10:54:52AM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>>
>>> git-p4 supports Python 2.6 and later versions of Python 2.  Since Python
>>> 2.8 will never exist [1], it is most concise to just list the supported
>>> versions.
>>
>> Thanks; Eric's patch recently updated git-p4.py to require 2.4 I
>> think. Shouldn't it also be updated?

Actually, the script does not support python 2.4 in its current state
since it uses subprocess.check_call which was introduced in python
2.5.

But, this can be trivially worked around.  I made the changes in my
own tree on Friday and planned to submit them after using it myself
for a few days.

Personally, I prefer to continue to provide the ability to compile and
install a fully working git on platforms in common use without pulling
in additional dependencies.  At least while it's fairly easy to do so.
 So, in my opinion, git-p4 should be patched to support python 2.4 and
the comment in INSTALL should be updated.  But, this opinion should be
taken with the appropriate grain of salt since I'm not really a
contributor to any of the python infrastructure.

-Brandon
