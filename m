From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git rev-list formatting
Date: Mon, 22 Mar 2010 18:22:34 +0100
Message-ID: <4BA7A75A.6060909@lsrfire.ath.cx>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 18:22:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtlKy-0001iD-J9
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 18:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab0CVRWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 13:22:43 -0400
Received: from india601.server4you.de ([85.25.151.105]:33249 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab0CVRWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 13:22:43 -0400
Received: from [10.0.1.100] (p57B7D73F.dip.t-dialin.net [87.183.215.63])
	by india601.server4you.de (Postfix) with ESMTPSA id 6C9892F807B;
	Mon, 22 Mar 2010 18:22:41 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142951>

Am 22.03.2010 12:30, schrieb Eli Barzilay:
> Possible bug -- IIUC, this:
>=20
>   git rev-list --pretty=3D"%w(40,2,2)%b" $rev
>=20
> should show all bodies wrapped as specified, but with 1.7.0.3 I see
> only the first one wrapped, and the rest don't show up.  In one of my
> attempts to sort this, I saw all bodies, but all bodies after the
> first were not wrapped as specified.

I can't reproduce this when running this command against git's own repo=
=2E
 Or perhaps I just fail to see it.  Is the one you're trying this on
public?  Does it work as expected with some other version of git?

Thanks,
Ren=E9
