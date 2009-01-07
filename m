From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: instate cleanup rule in case of non-memory
 errors
Date: Wed, 07 Jan 2009 13:19:19 -0800
Message-ID: <7vtz8a95m0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <1230026749-25360-1-git-send-email-madcoder@debian.org>
 <20081223102127.GA21485@artemis.corp>
 <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain>
 <20081224101146.GA10008@artemis.corp> <4952532F.5050704@lsrfire.ath.cx>
 <7viqp8afap.fsf@gitster.siamese.dyndns.org>
 <20090104122108.GC29325@artemis.corp> <4963C1EA.504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKfpd-0000VE-Lq
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 22:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761801AbZAGVTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 16:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761798AbZAGVTb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 16:19:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761797AbZAGVTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 16:19:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C66C81C066;
	Wed,  7 Jan 2009 16:19:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7B8B81C05F; Wed, 
 7 Jan 2009 16:19:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD9128CE-DD00-11DD-82A8-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104833>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Make all strbuf functions that can fail free() their memory on error =
if
> they have allocated it.  They don't shrink buffers that have been gro=
wn,
> though.

Thanks; applied.
