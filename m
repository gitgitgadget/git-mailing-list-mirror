From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Return code in cmd (git describe)
Date: Tue, 31 Jul 2012 16:27:15 +0400
Message-ID: <20120731162715.f1f01a825a7a0f74a2e3b412@domain007.com>
References: <op.wia7q0jqt21y7h@id-c1003.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: manuelah@opera.com
X-From: git-owner@vger.kernel.org Tue Jul 31 14:27:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwBXw-0007Ru-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 14:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab2GaM11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 08:27:27 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:34327 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026Ab2GaM10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 08:27:26 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q6VCRF1L005406;
	Tue, 31 Jul 2012 16:27:16 +0400
In-Reply-To: <op.wia7q0jqt21y7h@id-c1003.oslo.osa>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202649>

On Tue, 31 Jul 2012 14:02:50 +0200
"Manuela Hutter" <manuelah@opera.com> wrote:

> we have some python scripts that are run from Visual Studio, and one
> of them fails because of a wrong git return code when calling
> 'git describe --dirty'
[...]
> Run from wingw, the return code is 0.
> Run from cmd, the return code is 1.
> 
> Why?
Supposedly, when you run Git from cmd.exe, the git.cmd top-level script
(which wraps the git.exe binary) gets executed, and it's currently
affected by this bug [1] (fixed).  When you run Git from Git bash, the
git.exe binary runs directly and hence the bug is not exposed.

1. https://github.com/msysgit/msysgit/issues/43
