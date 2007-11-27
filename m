From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 14:45:36 +0100
Message-ID: <474C1F80.5060404@op5.se>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix0lG-0003eB-6k
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbXK0Npn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 08:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbXK0Npm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:45:42 -0500
Received: from mail.op5.se ([193.201.96.20]:55430 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbXK0Npm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 08:45:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 481871F08037;
	Tue, 27 Nov 2007 14:45:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuT8MuAt58Fk; Tue, 27 Nov 2007 14:45:39 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 132311F08032;
	Tue, 27 Nov 2007 14:45:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0711271109130.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66208>

Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 27 Nov 2007, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=
=81=AA=E3=81=93 wrote:
>=20
>> Quoting Andreas Ericsson <ae@op5.se>:
>>
>>> "git pull --rebase" already has an implementation. Dscho cooked one=
 up
>>> which I've been using since then. It works nicely.
>> What is the reason that the option was not added to the official git=
? =20
>> Was it coded poorly, buggy or were there some other issues?
>=20
> It is very well possible that it was coded poorly ;-)
>=20
> The main reason, I believe, was that some old-timers who know the=20
> implications said that it would encourage a wrong workflow.


If by "wrong", those old-timers meant "a workflow not commonly used
in a published one-pushes-many-pulls repository", I certainly agree.


>  One thing=20
> that could go possibly wrong, for example, is to rebase commits that =
you=20
> already published.
>=20

=46or the vast majority of git users, that's a non-issue as "published"=
 is
usually defined as "pushed to the publicly advertised watering hole".

Yes, I'm aware that git is distributed. That doesn't mean that it's not
convenient to have one single place where all code meant to be released
eventually ends up.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
