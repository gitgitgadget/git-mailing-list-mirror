From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Don't fail when an existing directory can't be created.
Date: Sat, 23 Aug 2008 16:29:27 +0200
Message-ID: <87prnzoldk.fsf@lysator.liu.se>
References: <87pro1pj3l.fsf@lysator.liu.se>
	<7vbpzk7k5x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 16:34:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWuCW-0001Pa-04
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 16:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbYHWO3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 10:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYHWO3a
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 10:29:30 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:37560 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYHWO33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 10:29:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 79532227F1CB;
	Sat, 23 Aug 2008 16:29:28 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09882-01-79; Sat, 23 Aug 2008 16:29:28 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2878A227F1C9;
	Sat, 23 Aug 2008 16:29:28 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id C7D2A7B4039; Sat, 23 Aug 2008 16:29:27 +0200 (CEST)
In-Reply-To: <7vbpzk7k5x.fsf@gitster.siamese.dyndns.org> (Junio C Hamano's message of "Fri\, 22 Aug 2008 15\:35\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93462>

[this is a resend, since the first one didn't reach the list]

Junio C Hamano <gitster@pobox.com> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> This makes it possible to install in a writable directory not owned =
by
>> the current user.
>> ---
>
> Sign-off?

I can sign it off, but I was more expecting to start a discussions, I s=
uppose.

--=20
David K=C3=A5gedal
