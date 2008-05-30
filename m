From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: encoding bug in git.el
Date: Fri, 30 May 2008 14:28:26 +0200
Message-ID: <20080530122826.GA4937@diana.vm.bytemark.co.uk>
References: <20080520220900.GA20570@diana.vm.bytemark.co.uk> <87mymkbo9x.fsf@lysator.liu.se> <1f748ec60805210708q34a26bebh915037713caa9a87@mail.gmail.com> <20080525134200.GA31990@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Clifford Caoile <piyo@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri May 30 14:29:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K23jp-0001Mk-TM
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 14:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYE3M2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2008 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYE3M2t
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 08:28:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3521 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYE3M2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 08:28:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K23ic-00022U-00; Fri, 30 May 2008 13:28:26 +0100
Content-Disposition: inline
In-Reply-To: <20080525134200.GA31990@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83291>

On 2008-05-25 15:42:00 +0200, Karl Hasselstr=F6m wrote:

> On 2008-05-21 23:08:09 +0900, Clifford Caoile wrote:
>
> > Here is a proposed fix.
>
> I don't claim to understand any of the design issues around this,
> but your patch certainly fixes my problem (once I managed to apply
> it, which involved working around the lack of headers, non-matching
> offsets, and whitespace damage -- luckily it was just two hunks).
> So:
>
> Tested-by: Karl Hasselstr=F6m <kha@treskal.com>
>
> Thanks for taking the time.

How are things going with this fix? Junio, I expect you're waiting for
a properly cleaned-up patch, possibly with acks from relevant people?

I think it would be a mistake to release 1.5.6 with this bug still in
it; if not this bugfix, then a revert of the offending commit.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
