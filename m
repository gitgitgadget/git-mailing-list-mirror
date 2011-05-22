From: Dave Zarzycki <zarzycki@apple.com>
Subject: git svn fetch error
Date: Sun, 22 May 2011 16:39:32 -0700
Message-ID: <3504B354-D3F2-4419-B2EC-E14F83EC0371@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 02:41:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJCd-0003Yp-Rb
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab1EWAkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:40:55 -0400
Received: from bramley.apple.com ([17.151.62.49]:53463 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab1EWAky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:40:54 -0400
X-Greylist: delayed 3681 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 May 2011 20:40:54 EDT
Received: from relay13.apple.com ([17.128.113.29])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LLM00MJTF1K18L0@mail-out.apple.com> for git@vger.kernel.org;
 Sun, 22 May 2011 16:39:33 -0700 (PDT)
X-AuditID: 1180711d-b7c70ae00000719a-4d-4dd99eb40890
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay13.apple.com (Apple SCV relay)
 with SMTP id 63.B8.29082.4BE99DD4; Sun, 22 May 2011 16:39:33 -0700 (PDT)
Received: from [17.153.34.10] (unknown [17.153.34.10])
 by koseret.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPSA id <0LLM0034UF1WRNA0@koseret.apple.com> for git@vger.kernel.org;
 Sun, 22 May 2011 16:39:32 -0700 (PDT)
X-Mailer: Apple Mail (2.1231)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174206>

Has anybody seen the following error with git svn fetch? I've seen this both with 1.7.4.4 and top-of-tree.

Argument "195270*" isn't numeric in numeric le (<=) at /usr/libexec/git-core/git-svn line 3840.
Argument "195270*" isn't numeric in numeric le (<=) at /usr/libexec/git-core/git-svn line 3840.
Argument "195270*" isn't numeric in numeric gt (>) at /usr/libexec/git-core/git-svn line 3822.
Argument "195270*" isn't numeric in numeric ge (>=) at /usr/libexec/git-core/git-svn line 3823.
Argument "195270*" isn't numeric in numeric gt (>) at /usr/libexec/git-core/git-svn line 3118.

How alarmed should I be?

Thanks,

davez
