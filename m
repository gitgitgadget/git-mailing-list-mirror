From: Mark Burton <markb@ordern.com>
Subject: Git commit won't add an untracked file given on the command line
Date: Tue, 18 Nov 2008 21:12:37 +0000
Organization: Order N Ltd.
Message-ID: <20081118211237.234d8035@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 22:13:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2XtV-0001ld-2z
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 22:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYKRVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbYKRVMl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 16:12:41 -0500
Received: from c2beaomr09.btconnect.com ([213.123.26.187]:1863 "EHLO
	c2beaomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbYKRVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 16:12:40 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2beaomr09.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BFO05314;
	Tue, 18 Nov 2008 21:12:38 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id D1B27190C96
	for <git@vger.kernel.org>; Tue, 18 Nov 2008 21:12:37 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0202.49232FC6.0099,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101286>


Hi,

When I try: 

git commit -m "New file." .gitignore

Where .gitignore is not yet tracked, I get: 

error: pathspec '.gitignore' did not match any file(s) known to git.

Is that result by design, sloth or bug (or me being stupid)?

Thanks,

Mark
