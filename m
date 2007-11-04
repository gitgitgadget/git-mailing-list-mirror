From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is --pretty=format: so slow?
Date: Sun, 04 Nov 2007 03:48:36 -0800
Message-ID: <7vhck2s02z.fsf@gitster.siamese.dyndns.org>
References: <18221.16318.785162.44769@cargo.ozlabs.ibm.com>
	<7vmytuvdvq.fsf@gitster.siamese.dyndns.org>
	<472D9F6E.8070609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodyM-000187-Ob
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbXKDLsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 06:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbXKDLsp
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:48:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41648 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbXKDLso convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:48:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E4ED82F9;
	Sun,  4 Nov 2007 06:49:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 341659130F;
	Sun,  4 Nov 2007 06:49:01 -0500 (EST)
In-Reply-To: <472D9F6E.8070609@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sun, 04 Nov 2007 11:31:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63389>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Incidentally, I'm finishing a patch series to add git-describe style
> placeholders.  It needs such an optimization even more badly (and has
> it).  Speeding up other slow placeholder expansions falls out quite
> naturally.  Please wait just a few minutes..

Thanks, and take your time, as I am just going to bed, dreaming
for a perfect series from one of the few people on this list
whose patches I do not have to read to reject crap, but I do
read to get impressed and admire ;-)
