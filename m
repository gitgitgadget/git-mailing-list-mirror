From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] fetch-pack: make the ssh connection quiet
Date: Wed, 27 Oct 2010 11:24:29 -0400
Message-ID: <1288193069.15518.40.camel@drew-northup.unet.maine.edu>
References: <1288189628-4883-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?UTF-8?Q?St=C4=99pie=C5=84?= <jstepien@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7sF-0001Ex-0c
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692Ab0J0PY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 11:24:57 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:34983 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933342Ab0J0PYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:24:53 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9RFOYOW003927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Oct 2010 11:24:39 -0400
In-Reply-To: <1288189628-4883-1-git-send-email-jstepien@users.sourceforge.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9RFOYOW003927
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288797880.774@iT+ogE6s8NZwlt1ELVaO9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160089>


On Wed, 2010-10-27 at 16:27 +0200, Jan St=C4=99pie=C5=84 wrote:
> The --quiet option passed to fetch-pack did not affect the ssh child
> process. When an ssh server sent a motd it was displayed because the =
ssh
> client wasn't launched with the -q option. This patch makes ssh run q=
uietly
> when fetch-pack is called with -q.
>=20
> An analogous change should be made to other commands which accept --q=
uiet
> and connect to remotes using ssh.

I'm not so sure that's a good idea. Quoting from the (Open)SSH man page=
:

-q      Quiet mode.  Causes all warning and diagnostic messages to be s=
uppressed.

Somehow I doubt that's what you intended or a good idea.

--=20
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
