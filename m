From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in   archive files)
Date: Tue, 04 Sep 2007 17:23:42 -0700
Message-ID: <7vzm02klip.fsf@gitster.siamese.dyndns.org>
References: <46DC4D45.4030208@lsrfire.ath.cx>
	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se>
	<Pine.LNX.4.64.0709041139140.28586@racer.site>
	<46DDE69C.1080908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Sep 05 02:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISigW-0005DZ-E7
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 02:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbXIEAXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 20:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbXIEAXw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 20:23:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbXIEAXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 20:23:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 94DB812E6CA;
	Tue,  4 Sep 2007 20:24:06 -0400 (EDT)
In-Reply-To: <46DDE69C.1080908@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Wed, 05 Sep 2007 01:13:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57664>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> Maybe we should not so much name it by purpose, but by function.  Ho=
w=20
>> about "substformat" for the attribute name, and replacing any=20
>> $Format:blablub$ inside those files with something a la=20
>> --pretty=3Dformat:blablub?
>
> I like the $Format:...$ notation.  How about naming the attribute
> "template", as that's what a thus marked file is?

Sounds good, although I suspect "template" might confuse newbies
that checkout may apply the substitution as well.  How about
something with "export" in it?  export-subst, perhaps?
