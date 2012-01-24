From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Correct way to pull using subtree merge without guesswork?
Date: Tue, 24 Jan 2012 18:49:19 +0100
Message-ID: <jfmr88$1p8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 18:54:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpkZq-0001Lq-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 18:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab2AXRyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 12:54:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:56146 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244Ab2AXRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 12:54:33 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RpkZj-0001GF-PO
	for git@vger.kernel.org; Tue, 24 Jan 2012 18:54:31 +0100
Received: from p4fd19416.dip0.t-ipconnect.de ([79.209.148.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 18:54:31 +0100
Received: from Manuel.Spam by p4fd19416.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 18:54:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd19416.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20111221 Firefox/9.0.1 SeaMonkey/2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189051>

Hello,

can someone please tell me, if this is the correct syntax for using "git pull" 
to pull in "subtree merging strategy", if I don't want to allow git to guess 
where to do the changes:

git pull -s subtree -X subtree=path/to/subtree externalproject master

Returns with success, but is "-X subtree=" the right way to force a subtree path 
and disallow git to autodetect the subtree?

$ git --version
git version 1.7.4.4

Thank you very much in advance

Yours

Manuel
