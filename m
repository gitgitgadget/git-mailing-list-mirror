From: Peter Simons <simons@cryp.to>
Subject: gitweb sets incorrect <base> header
Date: Tue, 28 Apr 2009 14:41:11 +0200
Organization: private
Message-ID: <877i15uf14.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 14:41:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lymcx-0001RB-3O
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 14:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbZD1Ml1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 08:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbZD1Ml0
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 08:41:26 -0400
Received: from main.gmane.org ([80.91.229.2]:38118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbZD1Ml0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 08:41:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lymcn-0001Ev-80
	for git@vger.kernel.org; Tue, 28 Apr 2009 12:41:25 +0000
Received: from p54bd255c.dip0.t-ipconnect.de ([84.189.37.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 12:41:25 +0000
Received: from simons by p54bd255c.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 12:41:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bd255c.dip0.t-ipconnect.de
Cancel-Lock: sha1:FBJapG/8wq03rtM5lkQ7gxrX/A8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117770>

Hi,

after a recent gitweb update to revision v1.6.3-rc3-12-gb79376c, the CGI now
generates an incorrect <base> header. For example, the first "patch" on the
page

  http://git.cryp.to/fastcgi/commitdiff/9ad9965b3fa293c458df14391f181f2f8f1197cd

erroneously refer to http://git.cryp.to/cgi-bin/gitweb.cgi#patch1, but that
page doesn't exist. It appears that $base_url is not determined correctly.

Does anyone have a clue how that problem can be fixed?

Take care,
Peter
