From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Tue, 16 Jan 2007 11:27:05 -0500
Message-ID: <E8FAB100-0E5B-4C3E-A0AB-34699CBBD148@silverinsanity.com>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 17:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6r9X-0001H7-Id
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 17:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXAPQ1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 11:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXAPQ1N
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 11:27:13 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:53564 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbXAPQ1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 11:27:12 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C46221FFC02B;
	Tue, 16 Jan 2007 16:27:10 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36948>


On Jan 16, 2007, at 10:16 AM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 16 Jan 2007, Uwe Kleine-K=F6nig wrote:
>
>> git push --exec=3D... is fine, but having it to specify every time i=
s
>> annoying.
>
> What would you specify? The only sensible thing would be "--=20
> exec=3Dblabla"
> where "blabla" is a workalike to git-receive-pack.
>
> IMHO this is just an obscure option for obscure _really_ low-level gi=
t
> debugging, so it should not even be mentioned in the man page, let =20
> alone
> encouraged.

It should be documented somewhere so that for the few odd cases where =20
you need it you can find it.  The most likely case I can think of is =20
an SSH push where git isn't in your path for some reason.

Undocumented options are a bane to users.  Document everything, and =20
put BIG WARNINGS on things that shouldn't be used.  Or put them in =20
their own man page.

~~ Brian