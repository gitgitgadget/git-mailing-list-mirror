From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Mon, 7 Jun 2010 21:50:13 +0200
Message-ID: <20100607195013.GA27362@pvv.org>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org> <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock> <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock> <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com> <20100607085947.GA3924@pvv.org> <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 21:50:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLiL4-0007uH-OU
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab0FGTuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 15:50:20 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:43643 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab0FGTuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 15:50:19 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OLiKr-000419-VX; Mon, 07 Jun 2010 21:50:13 +0200
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148620>

On Mon, Jun 07, 2010 at 06:37:56PM +0200, Henrik Grubbstr=F6m wrote:
>
> On Mon, 7 Jun 2010, Finn Arne Gangstad wrote:
>
>> I think it would be best if git at this time could decide that the
>> affected files also become dirty. The ideal commit is one that
>> both alters the .gitattributes _and_ the affected files at the same
>> time, and git should make it easy to create that commit.
>
> I agree in the case of newly added attributes. In the case of=20
> repositories already containing unnormalized files this however leads=
 to=20
> problems.
> eg
>
>   Consider the case above, but a while later when the repository has =
been
>   fixed at HEAD. If an old version from before the normalization is
>   checked out, the index will once again become dirty, which means th=
at
>   git will refuse the user to check out some other version unless the
>   --force flag is given. Excessive use of --force is not a good thing=
=2E
>   If the user is aware of the problem, and checking out old versions =
is
>   a common operation, toggling the suggested option might be a good
>   solution.

Maybe I misunderstand something, but if you check out an older
version, the .gitattributes file will change to match the old version.
The old version should not have the conversion attributes set, and
should therefore result in a clean checkout?

- Finn Arne
