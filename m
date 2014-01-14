From: Ivan Zakharyaschev <imz@altlinux.org>
Subject: BUG: manpage for git-pull mentions a non-valid option -m in a comment
Date: Tue, 14 Jan 2014 02:09:47 +0000 (UTC)
Message-ID: <loom.20140114T025825-557@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 14 03:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2tX7-0003Sg-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 03:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbaANCPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 21:15:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:45496 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbaANCPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 21:15:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W2tWx-0003D3-Iz
	for git@vger.kernel.org; Tue, 14 Jan 2014 03:15:03 +0100
Received: from host-79-165-57-121.qwerty.ru ([host-79-165-57-121.qwerty.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 03:15:03 +0100
Received: from imz by host-79-165-57-121.qwerty.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 03:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.165.57.121 (Emacs-w3m/1.4.466 w3m/0.5.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240386>

Hello!

git-1.8.4.4

The manpage for git-pull mentions -m in a comment:

--edit, -e, --no-edit
Invoke an editor before committing successful mechanical merge to further edit
the auto-generated merge message, so that the user can explain and justify the
merge. The --no-edit option can be used to accept the auto-generated message
(this is generally discouraged). The --edit (or -e) option is still useful if
you are giving a draft message with the -m option from the command line and
want to edit it in the editor.

but it is not accepted actually:

git pull --no-edit -m 'Restoring config etc from server' \
  origin server/GITCONFIG/master
fatal: No such remote or remote group: Restoring config etc from server

I'm not sure whether it is a bug of the implementation or of the documentation.

(I've also written down this issue at
https://bugzilla.altlinux.org/show_bug.cgi?id=29718 .)

Best regards,
Ivan
