From: ycollette.nospam@free.fr
Subject: Problem while cloning a git repo
Date: Tue, 12 Nov 2013 13:50:24 +0100 (CET)
Message-ID: <597769726.308442105.1384260624974.JavaMail.root@zimbra35-e6.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 13:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgDRJ-0002jA-T3
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 13:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab3KLMvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 07:51:09 -0500
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:34552 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3KLMvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 07:51:08 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id EEBD8D1A7EB
	for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:51:02 +0100 (CET)
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1CB89D480DE
	for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:50:25 +0100 (CET)
X-Originating-IP: [93.31.210.54]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237708>

Hello,

When I clone a repository, I get an error from git:

git clone http://192.168.0.18:8080/test test_Gerrit
Clonage dans 'test_Gerrit'...
remote: Counting objects: 25106, done
remote: Finding sources: 100% (25106/25106)
error: RPC failed; result=56, HTTP code = 200iB | 8.12 MiB/s   
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

The repo has some "big" zip files commited inside.
I use fedora 19 64 bits  and git version is 1.8.3.1.

Best regards,

YC
