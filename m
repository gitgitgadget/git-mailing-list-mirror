From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Mon, 13 Apr 2009 18:38:22 +0200
Message-ID: <80317CFC-6D87-4232-92EB-C5927F262E17@wincent.com>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr> <7vws9rdmgd.fsf@gitster.siamese.dyndns.org> <vpqfxgevy58.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtPDG-00045f-QF
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbZDMQjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 12:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZDMQjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:39:16 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:54365 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZDMQjP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 12:39:15 -0400
Received: from cuzco.lan (125.pool85-53-29.dynamic.orange.es [85.53.29.125])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n3DGcjq4022470
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Apr 2009 12:38:48 -0400
In-Reply-To: <vpqfxgevy58.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116448>

El 12/4/2009, a las 14:45, Matthieu Moy escribi=F3:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> You can say 'd' and then ^C, I think.
>
> Yes, you /can/, and that's what I'm doing right now in this situation=
=2E
> But that's undocumented, not so intuitive (I found out I could do tha=
t
> after trying ^C alone, which doesn't work, staged content is recorded
> on disk at the end of the file only, not after each prompt), ...
>
> I thought the situation was common enough to deserve an explicit
> command. The 'd' command is natural for "git add -i" + patch
> subcommand, but for "git add -p", I found 'd' mostly useless, and I
> really want a "quit" command.
>
> Sure, I can live without it, but if other people would like to have
> it, please speak now ;-).

Yes, I'd like it too. I've been using ^C a lot, but I'd never noticed =20
that changes weren't staged except at the end of each file. Thanks for =
=20
bringing it up; you might have saved some people (including me) from =20
being bitten by it at some point.

Wincent
