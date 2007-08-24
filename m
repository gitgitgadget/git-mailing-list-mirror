From: David Kastrup <dak@gnu.org>
Subject: Problem with git-gui and relative directories
Date: Fri, 24 Aug 2007 15:40:31 +0200
Message-ID: <868x81vynk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 15:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOZPh-00084o-8w
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 15:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169AbXHXNlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 09:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbXHXNlN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 09:41:13 -0400
Received: from main.gmane.org ([80.91.229.2]:56895 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbXHXNlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 09:41:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOZPG-0002zK-Hz
	for git@vger.kernel.org; Fri, 24 Aug 2007 15:40:58 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 15:40:58 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 15:40:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:PoqukNz9prfeRfXSlDipmI7QZrU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56575>


Doing something like

mkdir -p junk/woozle
cd junk
git-init
cd woozle
echo "hooray" > plop
git add plop
git commit -m "x"
git gui blame plop

errors out with

fatal: cannot stat path woozle/plop: No such file or directory

Obviously, git-gui is confused about relative paths here.

-- 
David Kastrup
