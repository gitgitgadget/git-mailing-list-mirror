From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: convert from perl internal to utf8 for commitdiff_plain
Date: Tue, 29 Jan 2008 21:10:01 -0800
Message-ID: <7vejbzkifq.fsf@gitster.siamese.dyndns.org>
References: <87ve5dicih.wl@mail2.atmark-techno.com>
	<7vir1dqjg0.fsf@gitster.siamese.dyndns.org>
	<87fxwhi3qj.wl@mail2.atmark-techno.com>
	<7vejc1qium.fsf@gitster.siamese.dyndns.org>
	<87ejc0j08t.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 06:10:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK5Di-0003TY-Rj
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 06:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbYA3FKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 00:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYA3FKP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 00:10:15 -0500
Received: from rune.pobox.com ([208.210.124.79]:43065 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbYA3FKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 00:10:13 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0DABF18F225;
	Wed, 30 Jan 2008 00:10:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B461918F1C6;
	Wed, 30 Jan 2008 00:10:30 -0500 (EST)
In-Reply-To: <87ejc0j08t.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Tue, 29 Jan 2008 21:16:02 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72022>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

>> > sorry about my stupid english.  What I meant was that because commi=
> t
>> > log doesn't say _why_ it changed to here-doc, I couldn't be sure it
>> > was ok to overwrite the change introduced by the commit 59b9f61a3.
>> >
>> > IOW, I was tring to ask, "is it ok to revert back to print?"
>>=20
>> Sure.  Can I forge your Sign-off?
>
> =46rom 127a6abaf23991394b3b2c5455c2522f9da1e8ac Mon Sep 17 00:00:00 200=
> 1
> =46rom: Yasushi SHOJI <yashi@wat.atmark-techno.com>
> Date: Tue, 29 Jan 2008 20:48:33 +0900
> Subject: [PATCH] gitweb: Convert generated contents to utf8 in commitdi=
> ff_plain
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit

Please don't do this.  MIME headers do not belong to the body of
the message.

>
> If the commit message, or commit author contains non-ascii, it must be
> converted from Perl internal representation to utf-8, to follow what
> got declared in HTTP header.  Use to_utf8() to do the conversion.
>
> This necessarily replaces here-doc with "print" statements.
>
> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
> Acked-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Will try to apply by hand; if you do not hear from me about this
patch again, no need for resend.

Thanks.
