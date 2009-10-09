From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log -S not finding all commits?
Date: Fri, 09 Oct 2009 10:55:38 +0200
Message-ID: <vpq1vldx7xx.fsf@bauges.imag.fr>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
	<362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
	<vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr>
	<86tyy9qz08.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel <mjucde@o2.pl>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri Oct 09 10:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwBHk-0006ah-5Q
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 10:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760339AbZJII4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 04:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759348AbZJII4f
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 04:56:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57558 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758108AbZJII4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 04:56:34 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n998tcVN025677
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Oct 2009 10:55:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MwBGF-0000nu-9B; Fri, 09 Oct 2009 10:55:39 +0200
In-Reply-To: <86tyy9qz08.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Thu\, 08 Oct 2009 15\:52\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Oct 2009 10:55:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n998tcVN025677
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255683339.25853@Wes1W5ZKyLItnV7Xdaq+pQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129755>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
> Matthieu> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> git log -p --format="%s\n%x00"  | perl -0 -ne 'print if(/whatever-you-search/);'
>
> That "if" is noisier than it needs to be:
>
>   perl -0 -ne 'print if /this/'

Thanks,

Also, this seems to actually print the \0 character. Perhaps a perl
guru can give a simple solution to replace the \0 by a \n?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
