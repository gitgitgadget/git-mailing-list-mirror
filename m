From: picca <picca@synchrotron-soleil.Fr>
Subject: Re: newby question about merge.
Date: Tue, 15 May 2007 13:37:20 +0200
Organization: Soleil
Message-ID: <20070515133720.20d76042@localhost.localdomain>
References: <20070515113820.2621c8d5@localhost.localdomain>
	<f2c23k$dm0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 13:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnvLQ-0002cG-QB
	for gcvg-git@gmane.org; Tue, 15 May 2007 13:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030820AbXEOLhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 07:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030814AbXEOLhY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 07:37:24 -0400
Received: from dns2.synchrotron-soleil.fr ([195.221.0.6]:44540 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030782AbXEOLhX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 07:37:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 0FF9B783E2;
	Tue, 15 May 2007 13:37:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLjoV2oBZFTz; Tue, 15 May 2007 13:37:19 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id E3D7278362;
	Tue, 15 May 2007 13:37:18 +0200 (CEST)
Received: from localhost.localdomain ([195.221.5.120]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 15 May 2007 13:38:58 +0200
In-Reply-To: <f2c23k$dm0$1@sea.gmane.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-OriginalArrivalTime: 15 May 2007 11:38:58.0296 (UTC) FILETIME=[A0369F80:01C796E5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47338>

On Tue, 15 May 2007 12:34:55 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> [Cc: picca <picca@synchrotron-soleil.Fr>, git@vger.kernel.org]
>=20
> picca wrote:
>=20
> > My question is how can I keep the upstream version of the configure
> > file instread of the one in the working directory.
> >=20
> > I read about the stage(1:2:3) but I do not know how if it is
> > related to my problem.
>=20
> You can just do "git cat-file -p :2:filename > filename", then
> "git add filename" (or "git update-index filename") to resolve
> conflict.
>=20
> Check first if :2: is correct file (and not for example :3:).

In fact the right file was the :3: one.

Thank you very much.

Is it possible to add this git cat-file -p :2:filename > filename in
the man page of git-merge in the resolve conflict part ?

Or a link to the documentation speaking of this stage part.

Thanks

=46r=C3=A9d=C3=A9ric
