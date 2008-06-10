From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add an optional <mode> argument to commit/status
 -u|--untracked-files option
Date: Mon, 09 Jun 2008 23:23:12 -0700
Message-ID: <7v63sherlb.fsf@gitster.siamese.dyndns.org>
References: <7vod6i1e3p.fsf@gitster.siamese.dyndns.org>
 <5f0ab026ce200e501be81a3b5082e482e1580e42.1212670149.git.marius@trolltech.com> <7v4p86qa93.fsf@gitster.siamese.dyndns.org> <484CD3A7.8090303@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5xHO-0000cZ-GB
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 08:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYFJGXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 02:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbYFJGXd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 02:23:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYFJGXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 02:23:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F407D1355;
	Tue, 10 Jun 2008 02:23:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D0BA71354; Tue, 10 Jun 2008 02:23:21 -0400 (EDT)
In-Reply-To: <484CD3A7.8090303@trolltech.com> (Marius Storm-Olsen's message
 of "Mon, 09 Jun 2008 08:54:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD0F6CD8-36B5-11DD-9C59-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84474>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Ops, obviously it should have been s@\(int\)@(intptr_t)@. Sorry about
> that, I'll resend the patch series.

Requeued.

> (The option struct in parse_options.h uses intptr_t for the default
> value of an option, thus a normal const char * would make the compiler
> complain (verified with both Windows MinGW 3.4.5 and Linux GCC 4.1.2))
>
> BTW, which compiler version are you using?

    gcc (GCC) 4.2.3 20071014 (prerelease) (Debian 4.2.2-3)
    Copyright (C) 2007 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

but with -Wold-style-definition -Werror -std=c99 -Wno-pointer-to-int-cast
-Wdeclaration-after-statement etc.
