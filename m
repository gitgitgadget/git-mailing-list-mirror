From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 14:55:56 +0100
Message-ID: <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net> <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IweSD-0003es-Ab
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 14:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXKZN4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 08:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXKZN4G
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 08:56:06 -0500
Received: from wincent.com ([72.3.236.74]:38641 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbXKZN4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 08:56:05 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQDtw67007492;
	Mon, 26 Nov 2007 07:55:59 -0600
In-Reply-To: <Pine.LNX.4.64.0711261340470.27959@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66074>

El 26/11/2007, a las 14:41, Johannes Schindelin escribi=F3:

> Hi,
>
> On Mon, 26 Nov 2007, Wincent Colaiuta wrote:
>
>> +		help_message =3D getenv("_GIT_CHERRY_PICK_HELP");
>
> Why on earth do you have a leading underscore?  No existing git
> environment variable does it that way.

I was following the suggestion of Johannes Sixt:

El 26/11/2007, a las 13:51, Johannes Sixt escribi=F3:

> Introduce an environment variable _GIT_CHERRY_PICK_HELP (note the =20
> leading underscore), which git-rebase sets; if it's set, git-cherry-=20
> pick uses that text instead of the usual one.


I imagine that he proposed it that way because it's an "internal use =20
only" thing.

Once I get a clear idea of what kind of change is likely to actually =20
get accepted I'll submit a proper patch.

Cheers,
Wincent
