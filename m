From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Git vc-git.el versus Emacs vc-git.el versus Gits git.el
Date: Tue, 03 Feb 2009 11:34:42 +0100
Message-ID: <87ab93yfjx.fsf@wine.dyndns.org>
References: <18823.47791.359047.560149@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 11:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUIde-0001pX-Sg
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 11:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbZBCKey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 05:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZBCKex
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 05:34:53 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:55056 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbZBCKew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 05:34:52 -0500
Received: from adsl-84-226-106-21.adslplus.ch ([84.226.106.21] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LUIc8-0006YP-TL; Tue, 03 Feb 2009 04:34:51 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 937511E728C; Tue,  3 Feb 2009 11:34:42 +0100 (CET)
In-Reply-To: <18823.47791.359047.560149@hungover.brentg.com> (Brent Goodrick's
	message of "Mon, 2 Feb 2009 19:31:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108175>

Brent Goodrick <bgoodr@gmail.com> writes:

> Hi,
>
> I have some questions concerning the Emacs Git integration:
>
>  1. What is the difference between git.el and vc-git.el in the
>     git/contrib/emacs directory?

vc-git.el is a backend for the Emacs VC mode, which supports the
standard C-x v commands. The advantage is that you can use the same
commands for all VCS.

git.el is a project-wide status manager equivalent to pcl-cvs, but
specialized for git. Its advantage is that by not trying to be generic
it can offer more git-specific functionality that isn't available with
VC mode.

They are not exclusive, you can use both at the same time, depending on
what operations you are doing.

>  2. There is a vc-git.el in the Emacs top-of-trunk sources, and
>     another one in the git/contrib/emacs directory in the Git
>     sources. Which one should I use?  If I should use the one in
>     Emacs, then why is there one in the Git source tree?

The most recent one is the one in the Emacs trunk, so you should use
this if possible. The one in the Git tree is an older version that's no
longer maintained, though it can still be useful if you are running an
old Emacs version.

-- 
Alexandre Julliard
julliard@winehq.org
