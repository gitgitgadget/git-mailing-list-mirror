From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: git push --no-mirror ?
Date: Mon, 8 Mar 2010 13:34:23 +0100
Message-ID: <20100308123423.GA20486@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 13:34:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NocAJ-0001Ki-6m
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 13:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab0CHMe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 07:34:26 -0500
Received: from francis.fzi.de ([141.21.7.5]:7313 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753304Ab0CHMeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 07:34:24 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Mar 2010 13:34:23 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 08 Mar 2010 12:34:23.0677 (UTC) FILETIME=[AEF27ED0:01CABEBB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141763>

Hi,


I have a remote that I use mainly for backup with 'mirror =3D true' in
gitconfig, but also for sharing my "bleeding-edge" code with a
student.  Now I came across the situation where I would liked to push
only a single branch to that repo, only to discover that 'git push'
has no '--no-mirror' option to override the related configuration
setting.  Removing the 'mirror =3D true' line from the config, doing th=
e
push, restoring the config did the trick, of course, but I think there
should be a simpler way to do that.  Is there a fundamental reason why
there is no 'push --no-mirror', or just noone has noticed/bothered
before?


Thanks,
G=E1bor
