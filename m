From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log -S not finding all commits?
Date: Fri, 09 Oct 2009 16:26:25 +0200
Message-ID: <vpq4oq8prse.fsf@bauges.imag.fr>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
	<362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
	<vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr>
	<86tyy9qz08.fsf@blue.stonehenge.com> <vpq1vldx7xx.fsf@bauges.imag.fr>
	<864oq8r795.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel <mjucde@o2.pl>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri Oct 09 16:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGdb-0007iK-Ts
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760933AbZJIO1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760906AbZJIO1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:27:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39004 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760852AbZJIO1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:27:23 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n99EQOVP020543
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Oct 2009 16:26:24 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MwGQL-0001sF-Sf; Fri, 09 Oct 2009 16:26:25 +0200
In-Reply-To: <864oq8r795.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Fri\, 09 Oct 2009 07\:07\:02 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Oct 2009 16:26:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n99EQOVP020543
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255703184.28451@kAVHnHkpp8Yue0F4n3fZ4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129806>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>   .. | perl -ln0e 'print if /this/'

Ah, good. I would have done this with 3 lines of code, glad to see a
solution with a single more character ;-).

Just updated the FAQ.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
