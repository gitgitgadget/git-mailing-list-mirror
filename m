From: Ronny Borchert <mister_rs@web.de>
Subject: [BUG] --bare is ignored before command word
Date: Wed, 18 Nov 2015 17:20:01 +0000 (UTC)
Message-ID: <loom.20151118T181639-5@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 18:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz6Tw-0007Fn-CG
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 18:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbbKRRZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 12:25:15 -0500
Received: from plane.gmane.org ([80.91.229.3]:35258 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497AbbKRRZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 12:25:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Zz6Tg-0006tU-C7
	for git@vger.kernel.org; Wed, 18 Nov 2015 18:25:04 +0100
Received: from p4FD718D0.dip0.t-ipconnect.de ([79.215.24.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 18:25:04 +0100
Received: from mister_rs by p4FD718D0.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 18:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.215.24.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281453>

I was trying to clone a bare repository. Not sure why I did, maybe
description on website was wrong.
My try:

git --bare clone https://github.....

This was leading in creating a none bare repository! No error or warning
message here!
I guess this behavior is also for other --xxx commands.
