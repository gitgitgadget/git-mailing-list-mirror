From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/4] git-gui blame: use textconv
Date: Wed, 16 Jun 2010 09:50:56 +0200
Message-ID: <vpq39wnbelb.fsf@bauges.imag.fr>
References: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<c80899f148cbfc9446554c6c706fdbfb@ensimag.fr>
	<7vr5k9a5f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: clement.poulain@ensimag.imag.fr, <spearce@spearce.org>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 09:51:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOnPZ-00028v-TT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 09:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab0FPHvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jun 2010 03:51:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34925 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab0FPHvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 03:51:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5G7gpO4032521
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jun 2010 09:42:51 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOnOi-0007wR-RA; Wed, 16 Jun 2010 09:50:56 +0200
In-Reply-To: <7vr5k9a5f5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 14 Jun 2010 10\:29\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Jun 2010 09:42:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5G7gpO4032521
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277278973.55215@0GXmcjAfq1kSXwtB6EwO4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149257>

Junio C Hamano <gitster@pobox.com> writes:

> (we might need to devise a transition strategy so
> that people who want to use slightly newer git-gui with older git won=
't
> get hurt).

I don't think these users would really get hurt: they could still use
git gui blame on text files, and they would anyway not have obtained
anything sensible from "git gui blame binary-file". In the very
unlikely case where a user has a textconv filter activated for a file
which can be viewed as text too, there's a checkbox to disable
textconv provided by Cl=E9ment's patch.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
