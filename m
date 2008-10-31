From: Ian Hilt <ihilt@mcgregor-surmount.com>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 16:11:27 -0400
Message-ID: <20081031201127.GA21345@maintenance05.msc.mcgregor-surmount.com>
References: <200810312050.31167.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:28:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0bB-0008HH-E9
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYJaU0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 16:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYJaU0s
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:26:48 -0400
Received: from mail.mcgregor-surmount.com ([70.61.40.162]:56731 "EHLO
	mcgregor-surmount.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752035AbYJaU0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:26:47 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Oct 2008 16:26:47 EDT
Received: from maintenance05.msc.mcgregor-surmount.com ([70.61.40.162]) by mcgregor-surmount.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 16:11:31 -0400
Content-Disposition: inline
In-Reply-To: <200810312050.31167.fg@one2team.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 Oct 2008 20:11:31.0163 (UTC) FILETIME=[DD59FAB0:01C93B94]
X-TM-AS-Product-Ver: SMEX-8.1.0.1092-5.500.1027-16252.001
X-TM-AS-Result: No--12.785300-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99637>

On Fri, Oct 31, 2008 at 08:50:31PM +0100, Francis Galiegue wrote:
> Le Friday 31 October 2008 19:39:33 Jeff King, vous avez =E9crit=A0:
> [...]
> >
> > Agreed, and actually I found such a bashism (test =3D=3D) last week=
 (though
> > of course it also broke on FreeBSD).
> >
>=20
> As for bash-isms, a hunt for $(...) also looks necessary...
>=20
> $ grep -rl '\$([^)]\+)' $(find -type f)|wc -l
> 272
>=20
> Unless I'm mistaken (and I probably am), the $(...) construct is=20
> bash-specific, isn't it?

Nope.  Read section 2.6.3 Command Substitution here,

<http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.htm=
l>
