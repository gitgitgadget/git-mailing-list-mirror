From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: git-am and git-rebase inconsistency
Date: Sat, 20 Jan 2007 00:53:11 +0100
Message-ID: <873b66infc.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jan 20 00:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83Xx-0004a1-Jo
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 00:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbXASXxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbXASXxW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 18:53:22 -0500
Received: from main.gmane.org ([80.91.229.2]:33887 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964983AbXASXxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 18:53:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H83Xq-000287-BR
	for git@vger.kernel.org; Sat, 20 Jan 2007 00:53:18 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Jan 2007 00:53:18 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Jan 2007 00:53:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:xyCWNPrxhNmmRAhwE+vT2S4/Dso=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37223>

The git-am and git-rebase commands have some similarities in that both
try to apply patches and may fail in the middle.  Both commands can be
rerun to continue the application.  The --skip option is used in both
to skip one patch, but when a conflict has been resolved, git-rebase
uses --continue, and git-am uses --resolved for what seems to me to be
the equivalent action.

It would probably be good, although not terribly important, if these
commands were change to be in harmony.  But I'm not sure which option
I like best...

--=20
David K=C3=A5gedal
