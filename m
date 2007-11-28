From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use --no-color option on git log commands.
Date: Tue, 27 Nov 2007 20:45:02 -0800
Message-ID: <7vr6ib9dwx.fsf@gitster.siamese.dyndns.org>
References: <474B42EC.1000408@wanadoo.fr>
	<7vr6icej23.fsf@gitster.siamese.dyndns.org>
	<474C60FA.4040302@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal.obry@wanadoo.fr>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKuW-0003xn-Gd
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:16:56 +0100
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEsq-0006kI-T3
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:50:48 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEsh-0001hB-T8
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbXK1EpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 23:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbXK1EpO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:45:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55327 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbXK1EpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 23:45:13 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 740562F0;
	Tue, 27 Nov 2007 23:45:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CD619A9C8;
	Tue, 27 Nov 2007 23:45:31 -0500 (EST)
In-Reply-To: <474C60FA.4040302@wanadoo.fr> (Pascal Obry's message of "Tue, 27
	Nov 2007 19:24:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-6.4, required=5.0, autolearn=disabled, AWL=0.602,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 84B55E8F5B1A1FA6AE1D84C6C4578A15E566A41B
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -63 maxlevel 200 minaction 2 bait 0 mail/h: 52 total 723819 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66334>

Pascal Obry <pascal.obry@wanadoo.fr> writes:

> Junio C Hamano a =C3=A9crit :
>> The patch is good as belt-and-suspender, thanks.
>
> Ok.
>
>> But I suspect that we should make 'true' to mean 'auto' someday in
>> git_config_colorbool().  Crazy people can set 'always' if they reall=
y
>> wanted to, but most normal people would not want color unless the ou=
tput
>> goes to the terminal, I would think.
>
> I definitely agree. I add it set to true, using auto instead I do not
> have the problem. Anyway I still think that it is good to apply my pa=
tch
> to completely avoid such issues.

Yes, that is what I said.

Except that the patch is severely whitespace damaged, and the message
lack a sign-off.

I fixed them up by hand, so no need to resend.
