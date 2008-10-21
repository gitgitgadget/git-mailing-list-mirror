From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH, RFC] diff: add option to show context between close 
  chunks
Date: Tue, 21 Oct 2008 08:35:08 +0200
Message-ID: <48FD781C.2000103@viscovery.net>
References: <48FB757B.9030105@lsrfire.ath.cx> <7vabcy3k9l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 08:36:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsAqw-0006St-Bz
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 08:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYJUGfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 02:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYJUGfN
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 02:35:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47105 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYJUGfL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 02:35:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KsApg-0007pr-LZ; Tue, 21 Oct 2008 08:35:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 644CA69F; Tue, 21 Oct 2008 08:35:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vabcy3k9l.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98761>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> I think it makes sense to make 1, or even 3, the default for this
>> option for all commands that create patches intended for human
>> consumption.  The patch keeps the default at 0, though.
>=20
> I think defaulting to 1 would make sense, or alternatively, just
> hardcoding that behaviour without any new option.  That would give yo=
u
> more information with the same number of patch lines, iow, upside wit=
hout
> any downside.

Are you sure about the "without any downside" part? The extra context l=
ine
inhibits that the patch applies cleanly to a version of the file that h=
as
that very line modified (including a different number of lines).

-- Hannes
