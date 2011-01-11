From: Pietro Battiston <me@pietrobattiston.it>
Subject: Re: git-repack & big files
Date: Tue, 11 Jan 2011 20:03:23 +0100
Message-ID: <1294772603.3435.67.camel@voubian.casa>
References: <1294731438.3300.973.camel@voubian.casa>
	 <4D2C7AA9.1020506@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcjVI-0007Sb-Sr
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567Ab1AKTDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 14:03:32 -0500
Received: from pietrobattiston.it ([92.243.7.39]:36901 "EHLO
	jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932544Ab1AKTDb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 14:03:31 -0500
Received: from [192.168.1.2] (net-188-218-63-65.cust.dsl.vodafone.it [188.218.63.65])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 94E8D13560;
	Tue, 11 Jan 2011 19:03:27 +0000 (UTC)
In-Reply-To: <4D2C7AA9.1020506@cfl.rr.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164974>

Il giorno mar, 11/01/2011 alle 10.43 -0500, Phillip Susi ha scritto:
> On 1/11/2011 2:37 AM, Pietro Battiston wrote:
> > Since it perfectly does what it is not optimized to do... I then wo=
nder
> > when it does not do what it declares: if I run git-repack=C2=B2 wit=
h the
> > parameter --window-memory set to, for instance, "100m", it takes
> > hundreds and hundreds of MB of memory until it runs out of memory, =
fails
> > a malloc and aborts.
> > So, two questions:
>=20
> --window-memory reduces the window size to try and stay under the lim=
it,
>  but the window size can not be reduced below 1.

OK, I think I understood. Still, I don't think there are many doubts
that the documentation is misleading when it says "the window size will
dynamically scale down so as to not take up more than N bytes in
memory". That's all.

> > 2) do I have any hope that in one way or another my 500+ MB mailbox=
es
> > with relatively small changes over time are archived smartly (=3Ddi=
ffs) by
> > git at the current state of development? If I understand correctly,=
 the
> > project git-bigfiles=C2=B3 would just "solve" my problems by not ma=
king
> > differences of big files.
>=20
> Git is not a backup tool.  You should use rsync rdiff-backup instead.

That's unfortunate - I think I prefer to split my mailboxes than to
loose many of the nice features git provides. But thanks a lot for the
suggestion.

Pietro
