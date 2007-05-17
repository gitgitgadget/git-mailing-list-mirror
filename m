From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 14:48:46 +0200
Message-ID: <vpqlkfnipjl.fsf@bauges.imag.fr>
References: <20070515201006.GD3653@efreet.light.src>
	<20070517124006.GO4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 14:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HofPy-0005yx-52
	for gcvg-git@gmane.org; Thu, 17 May 2007 14:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbXEQMs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 08:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbXEQMs5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 08:48:57 -0400
Received: from imag.imag.fr ([129.88.30.1]:41835 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757AbXEQMs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 08:48:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4HCmknT003373
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 May 2007 14:48:46 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HofPS-0000Lz-GU; Thu, 17 May 2007 14:48:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HofPS-0003EZ-E5; Thu, 17 May 2007 14:48:46 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070517124006.GO4489@pasky.or.cz> (Petr Baudis's message of "Thu\, 17 May 2007 14\:40\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 17 May 2007 14:48:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47518>

Petr Baudis <pasky@suse.cz> writes:

>> Mercurial and bzr both have this option. It would IMO have three benefits:
>>  - Fast access for people behind paranoid firewalls, that only let http and
>>    https (you can tunel anything through, but only to port 443) through.
>
>   How many users really have this problem? I'm not so sure.

Many (if not most?) of the people working in a big company, I'd say.
Year, it sucks, but people having used a paranoid firewall with a
not-less-paranoid and broken proxy understand what I mean.

>>  - Can be run on shared machine. If you have web space on machine shared
>>    by many people, you can set up your own gitweb, but cannot/are not allowed
>>    to start your own network server for git native protocol.
>
>   You need to have CGI-enabled hosting, set up the CGI script etc. -
> overally, the setup is similarly complicated as git-daemon setup, so
> it's not "zero-setup" solution anymore.
>
>   Again, I'm not sure just how many people are in the situation that
> they can run real CGI (not just PHP) but not git-daemon.

Any volunteer to write a full-PHP version of git? ;-)

-- 
Matthieu
