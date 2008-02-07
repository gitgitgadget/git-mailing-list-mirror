From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: automatically revert emacs buffers
Date: Thu, 07 Feb 2008 13:57:41 +0100
Message-ID: <87ir10q5yy.fsf@wine.dyndns.org>
References: <874pcnh4ej.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 13:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6Kg-0000b8-TO
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYBGM5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYBGM5x
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:57:53 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53011 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYBGM5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:57:52 -0500
Received: from adsl-84-227-175-174.adslplus.ch ([84.227.175.174] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JN6K0-0006yC-2n; Thu, 07 Feb 2008 06:57:51 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 9AC561E7141; Thu,  7 Feb 2008 13:57:41 +0100 (CET)
In-Reply-To: <874pcnh4ej.fsf@osv.gnss.ru> (Sergei Organov's message of "Mon,
	21 Jan 2008 21:07:59 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72935>

Sergei Organov <osv@javad.com> writes:

> If new custom variable git-auto-revert is 't', after git-revert-file,
> revert corresponding emacs buffers from reverted files provided the
> buffers were not changed. This is how pcl-cvs behaves.
>
> * git-auto-revert: new customizable variable.
> * git-revert-some-buffers: new function.
> * git-revert-file: call git-revert-some-buffers.

I had implemented this a bit differently in the patch series I just
sent, I did it the VC way by also checking for modified buffers and
refusing to revert their corresponding files. I didn't add a custom
variable for it though, so I'll merge that part of your patch.

-- 
Alexandre Julliard
julliard@winehq.org
