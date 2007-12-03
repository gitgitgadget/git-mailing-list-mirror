From: "Ollie Wild" <aaw@google.com>
Subject: git-svn: .git/svn disk usage
Date: Sun, 2 Dec 2007 22:17:28 -0800
Message-ID: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 07:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4cs-0007jg-Px
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXLCGRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXLCGRe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:17:34 -0500
Received: from smtp-out.google.com ([216.239.33.17]:19020 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbXLCGRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:17:34 -0500
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id lB36HVbL002164
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 06:17:32 GMT
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=EZRm6VhKqsay4GcKwLY7xOD6GagNQ1USHlRsnfxwz7MzyBCGEjc4YSljHO79hdSLc
	bTE8n9jwSS82bL4JL1gtA==
Received: from py-out-1112.google.com (pybp76.prod.google.com [10.34.92.76])
	by zps18.corp.google.com with ESMTP id lB36HUhH000466
	for <git@vger.kernel.org>; Sun, 2 Dec 2007 22:17:31 -0800
Received: by py-out-1112.google.com with SMTP id p76so6815950pyb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 22:17:30 -0800 (PST)
Received: by 10.35.27.1 with SMTP id e1mr5050853pyj.1196662649111;
        Sun, 02 Dec 2007 22:17:29 -0800 (PST)
Received: by 10.35.106.4 with HTTP; Sun, 2 Dec 2007 22:17:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66873>

Hi,

I've been using git-svn to mirror the gcc repository at
svn://gcc.gnu.org/svn/gcc.  Recently, I noticed that my .git directory
is consuming 11GB of disk space.  Digging further, I discovered that
9.8GB of this is attributable to the .git/svn directory (which
includes 200 branches and 2,588 tags).  Given that my .git/objects
directory is 652MB, it seems that it ought to be possible to store
this information in a more compact form.

I'm curious if other developers have run into this issue.  If so, are
there any proposals / plans for improving the storage of git-svn
metadata?

Thanks,
Ollie
