From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine
 lseek on mingw-w64
Date: Mon, 28 Apr 2014 19:09:24 +0400
Message-ID: <20140428150924.GA19167@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
 <CABPQNSYOy3k4-4p08wRcWyiVW-SPqp4Ax_oMc8eACRcTSSHvaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenBr-0003PR-Io
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbaD1PJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:09:45 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:44783 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbaD1PJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:09:43 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WenBM-0004zZ-QY; Mon, 28 Apr 2014 19:09:25 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSYOy3k4-4p08wRcWyiVW-SPqp4Ax_oMc8eACRcTSSHvaA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247355>

On Mon, Apr 28, 2014 at 05:02:09PM +0200, Erik Faye-Lund wrote:
> msysGit has a declaration of it in io.h as well. But it's not a
> preprocessor-definition... Are you saying that it's a
> preprocessor-define in mingw-w64, that points to a 64-bit version? If
> so, looks good.

MinGW is x86 only.

MinGW-W64, a separate project, provides both x86 and x86_64.

And here's relevant part of io.h from MingW-W64:
http://sourceforge.net/apps/trac/mingw-w64/browser/trunk/mingw-w64-headers/crt/io.h?rev=5437#L321
