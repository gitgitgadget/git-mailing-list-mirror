From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: cmd_cherry in builtin/log.c?
Date: Tue, 07 Dec 2010 19:57:38 +0100
Message-ID: <4CFE83A2.8070004@lsrfire.ath.cx>
References: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com> <20101207173923.GA21483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:57:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2jZ-0006EN-SQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab0LGS5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 13:57:48 -0500
Received: from india601.server4you.de ([85.25.151.105]:52690 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0LGS5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:57:47 -0500
Received: from [10.0.1.101] (p4FFDA351.dip.t-dialin.net [79.253.163.81])
	by india601.server4you.de (Postfix) with ESMTPSA id B6ADF2F80C5;
	Tue,  7 Dec 2010 19:57:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101207173923.GA21483@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163113>

Am 07.12.2010 18:39, schrieb Jonathan Nieder:
> while the core of the builtin version is
>=20
> 	get_patch_ids(&revs, &patch_id_opts, prefix);
>=20
> The latter function is static, introduced by v1.4.1~12^2~5
> (format-patch: introduce "--ignore-if-in-upstream", 2006-06-25).
>=20
> So the answer is that "git cherry" is considered a variant on
> "git log" (like format-patch, show, and whatchanged) and that it uses
> "git log" internals.

That's right.  get_patch_ids() could be moved into patch-ids.c now and
then cmd_cherry() could get its own file in builtin/, though.

Ren=E9
