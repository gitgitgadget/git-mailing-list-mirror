From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH, RFC] diff: add option to show context between close chunks
Date: Tue, 21 Oct 2008 08:09:33 +0200
Message-ID: <48FD721D.9030105@viscovery.net>
References: <48FB757B.9030105@lsrfire.ath.cx> <48FC9685.8030704@viscovery.net> <48FCC8A1.5090109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 21 08:10:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsAS9-0003xE-LE
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 08:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYJUGJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 02:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbYJUGJh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 02:09:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56168 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbYJUGJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 02:09:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KsAQw-0004O8-8C; Tue, 21 Oct 2008 08:09:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CAA3969F; Tue, 21 Oct 2008 08:09:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48FCC8A1.5090109@lsrfire.ath.cx>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98759>

Ren=E9 Scharfe schrieb:
> I have to admit my main motivation was that one line gap, where a chu=
nk
> header hid an interesting line of context.  Showing it didn't change =
the
> length of the patch, so I found this to be a sad wastage.

"Wastage" is relative. For a given patch, the one line of context that =
was
hidden by the hunk header would be welcome by a human reader, but it is
not necessarily useful if the patch is to be applied, in particular, if=
 it
is applied to a version of the file that has *more* than one line betwe=
en
the hunk contexts. This is the reason that diff does not produce 7 line=
s
of context between changes in -U3 mode ("you asked for 3 lines of conte=
xt,
you get 3 lines of context").

BTW, nomenclature seems to have settled at the word "hunk", not "chunk"=
=2E

-- Hannes
