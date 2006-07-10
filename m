From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2/2] Move all builtin .c files into builtin/
Date: Mon, 10 Jul 2006 02:41:19 -0400
Message-ID: <1152513679.3504.47.camel@dv>
References: <1152507249880-git-send-email-ryan@michonline.com>
	 <11525072492717-git-send-email-ryan@michonline.com>
	 <11525072491512-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 08:41:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzpSh-0001nj-EN
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 08:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWGJGlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 02:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWGJGlj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 02:41:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:9088 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161352AbWGJGlj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 02:41:39 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FzpSZ-0005VG-3W
	for git@vger.kernel.org; Mon, 10 Jul 2006 02:41:37 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FzpSJ-0000rN-P7; Mon, 10 Jul 2006 02:41:19 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11525072491512-git-send-email-ryan@michonline.com>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23596>

Hello, Ryan!

On Mon, 2006-07-10 at 00:54 -0400, Ryan Anderson wrote:
> Signed-off-by: Ryan Anderson <ryan@michonline.com>

I agree that the top level directory is overcrowded, but wouldn't it be
better to move libgit.a sources to "lib" and then classify the remaining
files in some way (e.g. "git" or "src" for builtin commands, "commands"
for the rest)?  While at that, the "buildin-"  prefix could be stripped.

The main "git" executable is nothing but several builtin commands rolled
together.  It's not like a shell, which has functionality beyond the
builtin commands.  So "builtin" is git.

Or you can say that the git executable is a command line frontend to the
git library (it's moving in this direction anyway).  Then you can have
"client" and "server" directories.  That's more important for
understanding the source than "builtin", "standalone" or any
classification based on technical details.

-- 
Regards,
Pavel Roskin
