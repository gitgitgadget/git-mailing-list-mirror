From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Let me ask again: How do we import patches from non-git sources?
Date: Thu, 14 Jun 2007 09:53:36 +0200
Message-ID: <vpqsl8v6kfz.fsf@bauges.imag.fr>
References: <1180017010.21181.2.camel@zealous.synapsedev.com>
	<1181151454.6086.23.camel@zealous.synapsedev.com>
	<vpqhcplx8vb.fsf@bauges.imag.fr>
	<1181153904.12740.35.camel@ld0161-tx32>
	<1181785754.4102.13.camel@zealous.synapsedev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, Git List <git@vger.kernel.org>
To: Marc Singer <elf@synapse.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 09:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HykAI-0004Ss-MM
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 09:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbXFNHye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 03:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbXFNHye
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 03:54:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:64787 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbXFNHyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 03:54:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l5E7rav4019724
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2007 09:53:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hyk9A-0006Kg-EF; Thu, 14 Jun 2007 09:53:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hyk9A-0005jy-BX; Thu, 14 Jun 2007 09:53:36 +0200
Mail-Followup-To: Marc Singer <elf@synapse.com>, Jon Loeliger <jdl@freescale.com>,  Git List <git@vger.kernel.org>
In-Reply-To: <1181785754.4102.13.camel@zealous.synapsedev.com> (Marc Singer's message of "Wed\, 13 Jun 2007 18\:49\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 14 Jun 2007 09:53:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50176>

Marc Singer <elf@synapse.com> writes:

> On Wed, 2007-06-06 at 13:18 -0500, Jon Loeliger wrote:
>> On Wed, 2007-06-06 at 12:58, Matthieu Moy wrote:
>> 
>> > Cogito is more or less depreceted now. You should probably use git
>> > itself.
>> 
>> Hmm.  We should then likely try to encourage kernel.org and denx.de
>> folks to advertise cloning their published repos with git rather
>> than cogito now.
>
> It's also users who are *just* getting their feet wet in the git pool.

Yes, and cogito definitely _used_ to be a very good thing for them.
But today, starting with cogito instead of git is not really easier
for a beginner: OK, the program is a bit simpler to use, but some
commands are missing, so you'll sometimes have to type "git" and
sometimes "cogito" (the cogito tutorial was actually using a few git
commands). Then, the user comes on the mailing list and asks
something, he will be answered in terms of git commands 95% of the
times, ...

For that reasons, the maintainer of cogito said some time ago that he
was probably going to stop working on cogito. Maybe I missed something
in the meantime, but I don't think anyone volunteered to continue with
cogito. So, encourraging people to use cogito is a bit like "hey, try
this, but once you've finished learning it, you'll have to forget it
and migrate" ...

-- 
Matthieu
