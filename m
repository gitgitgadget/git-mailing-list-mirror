From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-cvsserver.perl: encourage use of English module and qx() operator
Date: Fri, 16 Apr 2010 19:48:21 +0300
Organization: Private
Message-ID: <87mxx3qr6y.fsf@jondo.cante.net>
References: <1271435565-32370-1-git-send-email-jari.aalto@cante.net>
	<8639yve4gk.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri Apr 16 18:48:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oiZ-0008KC-42
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597Ab0DPQs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:48:29 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:43518 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab0DPQs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:48:28 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 69C7FEC38F;
	Fri, 16 Apr 2010 19:48:27 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A041FD674D1; Fri, 16 Apr 2010 19:48:27 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id E86664042;
	Fri, 16 Apr 2010 19:48:23 +0300 (EEST)
In-Reply-To: <8639yve4gk.fsf@red.stonehenge.com> (Randal L. Schwartz's message
	of "Fri, 16 Apr 2010 09:40:11 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145082>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "jari" == jari aalto <jari.aalto@cante.net> writes:
>
> jari> Substitute magic variables $<puctuation> with the English.pm
>
> Please no.
>
> That might have been good advice in 2005, but it's crazy talk now.

It would be interesting to know why not. These magic variables are hard
to read and remember without consulting the manual pages.

There doesn't seem to be noticeable performance penalty any more:

    $ perl --version | grep v5
    This is perl, v5.10.1 (*) built for x86_64-linux-gnu-thread-multi

    $ time perl -e 'use English qw( -no_match_vars ); print'

    real    0m0.016s
    user    0m0.008s
    sys     0m0.004s

    $ time perl -e 'print 1'

    real    0m0.005s
    user    0m0.000s
    sys     0m0.004s

Jari
