From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Problems pushing???
Date: Sun, 8 Jul 2012 16:21:23 +0400
Message-ID: <20120708122122.GB14518@localhost.localdomain>
References: <1341738766823-7562695.post@n2.nabble.com>
 <4FF97463.90002@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pbGit <pblakeley@gmail.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 14:21:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnqUn-0007By-3M
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 14:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab2GHMVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jul 2012 08:21:31 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:33987 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab2GHMVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 08:21:31 -0400
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q68CLNJQ025212;
	Sun, 8 Jul 2012 16:21:24 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 669DBB20158; Sun,  8 Jul 2012 16:21:23 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <4FF97463.90002@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201175>

On Sun, Jul 08, 2012 at 01:52:03PM +0200, Holger Hellmuth wrote:

>>http://www.petermac.com/setup-git-local-and-remote-repositories/ this=
 .  All
>=20
> The recipe at this address seems to have a "--bare" parameter
> missing at the git init in step 7
The OP stated that =ABThis is intended to be the remote machine too.=BB
wich hints he wants to also receive changes to this repo from the
outside.
Supposedly he should stick to pulls only.
Or set up a bare repo on the local machine and then clone it to its
"working" repo using a plain path like /path/to/that/shared/repo.
