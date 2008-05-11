From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to git-archive ignore some files?
Date: Sun, 11 May 2008 09:20:46 -0700
Message-ID: <7vwsm06cdd.fsf@gitster.siamese.dyndns.org>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
 <BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>
 <4820CC35.3090202@lsrfire.ath.cx> <7vk5i7gk6e.fsf@gitster.siamese.dyndns.org>
 <4826CE0B.8080109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Victor Bogado da Silva Lins <victor@bogado.net>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun May 11 18:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEJ4-0001cM-HV
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbYEKQVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 12:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbYEKQVA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:21:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbYEKQU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 12:20:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 073C8112D;
	Sun, 11 May 2008 12:20:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4B6251129; Sun, 11 May 2008 12:20:51 -0400 (EDT)
In-Reply-To: <4826CE0B.8080109@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sun, 11 May 2008 12:44:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3CF3674E-1F76-11DD-9859-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81785>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Another idea: would it make sense to have an attribute for that inste=
ad
> (or in addition to the command line parameter)?  I.e. files marked
> export-ignore would not end up in the archive.  I suspect the set of
> files to ignore doesn't change from archive to archive one creates.

That sounds extremely sensible.

Should/does git-archive read .gitattributes from the tree being exporte=
d?
