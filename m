From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 09 Nov 2007 14:30:15 -0800
Message-ID: <7vr6izqcg8.fsf@gitster.siamese.dyndns.org>
References: <4733AEA6.1040802@lsrfire.ath.cx>
	<Pine.LNX.4.64.0711090122470.4362@racer.site>
	<4734CD78.4000704@lsrfire.ath.cx>
	<Pine.LNX.4.64.0711092218150.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 23:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqcN8-00025q-0i
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbXKIWa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbXKIWa0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:30:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60508 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXKIWaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:30:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A82F72F2;
	Fri,  9 Nov 2007 17:30:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 32A5B93C4C;
	Fri,  9 Nov 2007 17:30:40 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711092218150.4362@racer.site> (Johannes
	Schindelin's message of "Fri, 9 Nov 2007 22:18:54 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64268>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You mean next time you write strbuf_expand()?
>
> ;-)  I saw that Junio already applied your patch as is.  Hmm.

Which only means we expect incremental improvements on top of it
from now on, it does not mean "it is perfect and cast in stone".
