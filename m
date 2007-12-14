From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Failed to make install-info
Date: Thu, 13 Dec 2007 22:03:55 -0800
Message-ID: <7vejdpvmlw.fsf@gitster.siamese.dyndns.org>
References: <E1J2q92-0001YT-BZ@jdl.com>
	<200712140635.39311.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33fB-0005sP-9E
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbXLNGER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXLNGEP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:04:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbXLNGEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 01:04:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E2294D94;
	Fri, 14 Dec 2007 01:04:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 155F44D93;
	Fri, 14 Dec 2007 01:04:02 -0500 (EST)
In-Reply-To: <200712140635.39311.chriscool@tuxfamily.org> (Christian Couder's
	message of "Fri, 14 Dec 2007 06:35:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68231>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le jeudi 13 d=C3=A9cembre 2007, Jon Loeliger a =C3=A9crit :
>> Guys,
>> I managed to fail to install info files during:
>>
>>     /usr/src/git# make prefix=3D/usr install-info
>
> I am also struggling with "make install-info" to make it install in=20
> ~/share/info/dir=20
>
> First it barfed because "~/share/info/dir" did not exist.
>
> Then it doesn't find "install-info" because it's in "/usr/sbin" on my=
 debian=20
> machine.
>
> I well tell if I get the same error as you. But right now I cannot=20
> invastigate more.

I personally feel that calling "install-info" is a bit too distro-ish
and should not be done in our Makefile vanilla build-and-install
procedure.
