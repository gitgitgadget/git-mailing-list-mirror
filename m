From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: checkout detached work tree
Date: Tue, 18 Mar 2008 23:32:26 +0000 (UTC)
Message-ID: <slrnfu0k9d.kfv.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 21:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4rA-0004ng-6c
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762690AbYCSUDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 16:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762688AbYCSUDh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:03:37 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2833 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762686AbYCSUDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:03:35 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2A59A488036; Wed, 19 Mar 2008 00:51:08 +0100 (CET)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JblIA-0000eS-Tq
	for git@vger.kernel.org; Wed, 19 Mar 2008 00:32:27 +0100
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1205883146 32649 192.168.0.5 (18 Mar 2008 23:32:26 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-97 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77531>

Hi,

is it correct that this checkout fails?

% git --git-dir=3D$HOME/git/git/.git --work-tree=3D/tmp/git symbolic-re=
f HEAD
refs/heads/master
% git --git-dir=3D$HOME/git/git/.git --work-tree=3D/tmp/git checkout
fatal: /usr/bin/git-checkout cannot be used without a working tree.

I want to do a checkout in a script without need to worry about the
current working directory. But it seams this is not possible. Many
commands fail. Is this behaviour expected?

Bye, J=C3=B6rg.
--=20
Als deutscher Tourist im Ausland steht man vor der Frage, ob man sich
anst=C3=A4ndig benehmen muss oder ob schon deutsche Touristen dagewesen=
 sind.
	  	   	     	      	        (Kurt Tucholsky)
