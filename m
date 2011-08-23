From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: What's the difference between `git show branch:file | diff -u
	- file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 14:52:11 +0400
Message-ID: <1314096731.15017.2.camel@n900.home.ru>
References: <loom.20110823T091132-107@post.gmane.org>
	  <4E537AF0.9070604@drmicha.warpmail.net>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 16:13:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvrjM-0002E7-8n
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 16:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab1HWONX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 10:13:23 -0400
Received: from static.231.38.47.78.clients.your-server.de ([78.47.38.231]:34242
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab1HWONV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 10:13:21 -0400
X-Greylist: delayed 1738 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Aug 2011 10:13:21 EDT
Received: from [85.26.155.112] (helo=[172.18.255.151])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <marat@slonopotamus.org>)
	id 1QvrDW-0006oq-S5; Tue, 23 Aug 2011 17:40:36 +0400
X-Mailer: Modest 3.90.7
In-Reply-To: <4E537AF0.9070604@drmicha.warpmail.net>
Content-ID: <1314096731.15017.1.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179937>

> Is that a very large tree or a very slow file system?
Tree is large (500k files), file system is irrelevant since all time is spend on CPU.

> Do we enumerate all
> differing files and only then limit diff output by path??

Dunno, that's why I am asking why it is so slow.
