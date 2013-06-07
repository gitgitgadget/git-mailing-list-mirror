From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 22:06:57 +0200
Message-ID: <20130607200657.GC31625@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <7vli6mwx07.fsf@alter.siamese.dyndns.org>
 <20130607193444.GB31625@goldbirke>
 <CALkWK0mkQqopPBrmO1e20nN_kbNLgcR4cA9z7nOfA4q_2GxvMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2wM-0007O6-V7
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab3FGUHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 16:07:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52026 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab3FGUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:07:08 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MLAED-1UlJv10EeP-0005rl; Fri, 07 Jun 2013 22:06:58 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0mkQqopPBrmO1e20nN_kbNLgcR4cA9z7nOfA4q_2GxvMg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:c+oocDZbLz4qFHxXZz2hdd24s26SEkgnCTFHR9SuOra
 8FlFuIfBKLhHpmHwbwnED5QB8daytfQMl2/hUbRiPmSn6ivHJg
 aD3Fi4NZAlEj/eZknhBA0eMRf83KuXR035wgLvmS0ifAjPbYwe
 kt30KCVnU/Kd+TFa+EXVT7XbNvU7XtivF779EziSAyQiXdUtAx
 iatRRK5Pu34CxfN4f59sP89ZHTXSLzzn70DAorni80esZm1M70
 KOnyR6Vv5ZwqUd9cstTXJgFkVASuxnrNMo/pYYtFqj/r2fLvtj
 /Rv9xtTfs4akTJXhw6/eMx+Rq6gRsZ0TzZJ5FlcwyPwqEVcVpZ
 beyO5M1jVzoRT/TkV7N/Rma6ghXzLwH4xcEkv44f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226692>

On Sat, Jun 08, 2013 at 01:17:28AM +0530, Ramkumar Ramachandra wrote:
> SZEDER G=E1bor wrote:
> > because nowadays __git_complete_file() is a wrapper around
> > __git_complete_revlist_file().
>=20
> What?  It was never anything different from a poorly-named alias for
> __git_complete_revlist_file().

Again: __git_complete_file() has been there since the completion
script was first included in git.

>  You have already agreed that
> __git_complete_file() is a horrible name, so why not deprecate it?

I am not against deprecating it, and by "it" I mean the function name.

> Whom is this confusion benefiting, and how is it any "cleaner"?

It's clearer because of the reasons I gave in my other email in the
discussion of the patch.

Plus it would avoid commits on master with incorrect commit messages.

> If
> you're arguing about expanding __git_complete_file(), don't do that:
> just write a new function and give it a proper name.

I am not arguing about that.
