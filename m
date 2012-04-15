From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sun, 15 Apr 2012 12:59:45 +0200
Message-ID: <20120415105943.GD6263@ecki>
References: <4F893CD8.5020700@gmail.com>
 <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com>
 <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:01:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJNCe-0002VR-Iz
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab2DOLBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:01:03 -0400
Received: from smtpout14.highway.telekom.at ([195.3.96.79]:55693 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752845Ab2DOLBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:01:01 -0400
Received: (qmail 2617 invoked from network); 15 Apr 2012 11:00:58 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL506.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub80.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <stefano.lattarini@gmail.com>; 15 Apr 2012 11:00:57 -0000
Content-Disposition: inline
In-Reply-To: <4F8A8211.2010908@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195557>

On Sun, Apr 15, 2012 at 10:08:49AM +0200, Stefano Lattarini wrote:
>
> trace: run_command: 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
>
> trace: run_command: 'git-fast-import' '--quiet' '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'

Ok, so the above two commands seem to be deadlocking for you.  Could you
please run git fast-export with the arguments above from the directory
t/trash directory.t5800-remote-helpers/server and check the output? In
my previous email I also gave further instructions on how to pipe
fast-export output to fast-import.  Maybe you missed it, or is anything
unclear?
