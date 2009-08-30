From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Make it easy to add unmerged files
Date: Sun, 30 Aug 2009 17:58:53 +0200
Message-ID: <87ws4l47k2.fsf@wine.dyndns.org>
References: <4A9A92F4.2090209@chromecode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin Nordholts <martin@chromecode.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 17:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhmoC-0002Uj-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 17:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbZH3P7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 11:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbZH3P7C
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 11:59:02 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:52490 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbZH3P7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 11:59:02 -0400
Received: from adsl-84-226-49-96.adslplus.ch ([84.226.49.96] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Mhmnv-0002Jj-WB; Sun, 30 Aug 2009 10:59:03 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 52EC31E73AD; Sun, 30 Aug 2009 17:58:53 +0200 (CEST)
In-Reply-To: <4A9A92F4.2090209@chromecode.com> (Martin Nordholts's message of
	"Sun, 30 Aug 2009 16:55:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-Spam-Score: -3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127414>

Martin Nordholts <martin@chromecode.com> writes:

> (Resending as I managed to mangle the previous patch despite trying not to...)
>
> It is nice and easy to git-add ignored and unknown files in a
> git-status buffer. Make it equally easy to add unmerged files which is
> a common use case.

That's not quite what adding a file means in git.el, unmerged files are
considered added already, and marking them resolved is done through the
git-resolve-file command. Of course that was implemented before git
overloaded the meaning of git-add to mean git-update-index, so maybe we
should follow the trend and use git-add-file for all index updates. In
that case git-resolve-file should probably be removed.

-- 
Alexandre Julliard
julliard@winehq.org
