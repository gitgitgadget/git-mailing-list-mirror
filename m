From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Show committer ident in some cases
Date: Fri, 02 May 2008 14:44:40 -0700
Message-ID: <7vwsmcwfcn.fsf@gitster.siamese.dyndns.org>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js34Z-0004gt-Fj
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 23:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765002AbYEBVoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 17:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758680AbYEBVoy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 17:44:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbYEBVox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 17:44:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 552085DCC;
	Fri,  2 May 2008 17:44:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C52E35DCA; Fri,  2 May 2008 17:44:48 -0400 (EDT)
In-Reply-To: <1209752541-19111-1-git-send-email-sbejar@gmail.com> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Fri, 2 May 2008 20:22:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE64CCB6-1890-11DD-B611-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81035>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> The definition of "wrong committer" could be:
>
> 1) user.{name,email} or GIT_COMMITTER_{NAME,EMAIL} is not a wrong com=
mitter.
> 2) automatic without a domain name (user@hostname.(none)) is a wrong =
committer.
>    (not handled with this patch series)
> 3) automatic or partially set ident:
>    a) wrong committer for some users
>    b) right committer for others

Define "partially set".

> Santi B=C3=83=C2=A9jar (2):

???
