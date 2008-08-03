From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-name-rev: don't use printf without format
Date: Sun, 03 Aug 2008 13:44:10 -0700
Message-ID: <7vvdyhu8v9.fsf@gitster.siamese.dyndns.org>
References: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl>
 <7vfxpnmgkc.fsf@gitster.siamese.dyndns.org> <4895B641.1050500@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkSC-00017m-3x
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbYHCUoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2008 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbYHCUoW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:44:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbYHCUoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Aug 2008 16:44:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A718749BF9;
	Sun,  3 Aug 2008 16:44:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0F82F49BF7; Sun,  3 Aug 2008 16:44:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1936254-619C-11DD-9ACC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91267>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> printf() without an explicit format string is not a good coding pract=
ise,
> unless the printed string is guaranteed to not contain percent signs.=
  While
> fixing this, we might as well combine the calls to fwrite() and print=
f().

Good catch; I should have caught it when I applied the "split overlong
function" patch, but I apparently was blind.

Thanks.
