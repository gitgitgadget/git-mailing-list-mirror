From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 18:08:15 +0200
Message-ID: <vpq646opzio.fsf@bauges.imag.fr>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
	<20070519115245.GA10035@coredump.intra.peff.net>
	<20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Sat May 19 18:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpRXn-0000k5-5s
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXESQMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbXESQMZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:12:25 -0400
Received: from imag.imag.fr ([129.88.30.1]:46511 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbXESQMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:12:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4JG8FTn001562
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 19 May 2007 18:08:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HpRTb-0000VY-Or; Sat, 19 May 2007 18:08:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HpRTb-00078x-MS; Sat, 19 May 2007 18:08:15 +0200
Mail-Followup-To: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
In-Reply-To: <pan.2007.05.19.15.45.46@progsoc.org> (Anand Kumria's message of "Sat\, 19 May 2007 15\:45\:49 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 19 May 2007 18:08:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47753>

Anand Kumria <wildfire@progsoc.org> writes:

> On Sat, 19 May 2007 08:11:54 -0400, Jeff King wrote:
>
>> On Sat, May 19, 2007 at 05:09:33AM -0700, Robin H. Johnson wrote:
>> 
>>> Ahh, they do show up there (and I learnt a new git command now, thanks)
>>> - the ones that I can remember the Subject lines for anyway.
>>> 
>>> Any hints for the future on finding stuff that is in the reflog but not
>>> in the tree? (Remembering every subject line isn't feasible).
>> 
>> Try 'git-fsck --unreachable --no-reflogs'. :)
>
> What version? git 1.5.1.4 doesn't seem to have that.

The commit introducing it is 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b,
and I'd say it's in git 1.5.1:

$ git-describe --tags 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b                                                                                     
v1.5.1-34-g566842f

-- 
Matthieu
