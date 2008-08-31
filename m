From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style
Date: Sun, 31 Aug 2008 03:53:47 +0200
Message-ID: <200808310353.47699.chriscool@tuxfamily.org>
References: <20080830111253.GA9148@zakalwe.fi> <7vwshyfctu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 03:51:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZc68-0003YL-Rv
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 03:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbYHaBuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 21:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbYHaBuH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 21:50:07 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:37353 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829AbYHaBuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 21:50:06 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 60BF53EA0C5;
	Sun, 31 Aug 2008 03:50:04 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 351D13EA0B5;
	Sun, 31 Aug 2008 03:50:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vwshyfctu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94447>

Le samedi 30 ao=FBt 2008, Junio C Hamano a =E9crit :
>
> The command name at the beginning of die message does not have this
> issue. E.g. the colon in:
>
> 	die("git foo: I hate you");
>
> is sufficient to make it clear that these two words form a single nou=
n;
> i.e. "I'm 'git foo' program, and I am telling you that I hate you".
>
> But it might be just me, so before asking you to reroll another round=
,
> I'd like to hear opinions from the list.
>
>  (1) No, JC is worrying too much about readability; Heikki's patch is
> good;
>
>  (2) JC's right -- "instead of calling 'git rev-list'" is much better=
;

I agree with (2).

Regards,
Christian.

>  (3) Something else?
