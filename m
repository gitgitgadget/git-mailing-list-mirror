From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Automatically add GIT as a VC backend
Date: Fri, 02 Mar 2007 12:12:22 +0100
Message-ID: <87zm6vvqzt.fsf@wine.dyndns.org>
References: <28587.1172793178@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5gb-0002bU-KE
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423020AbXCBLM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423024AbXCBLM0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:12:26 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:35772 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423020AbXCBLM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:12:26 -0500
Received: from adsl-89-217-28-37.adslplus.ch ([89.217.28.37] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HN5gW-0002EF-TA; Fri, 02 Mar 2007 05:12:25 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 6CF524F691; Fri,  2 Mar 2007 12:12:22 +0100 (CET)
In-Reply-To: <28587.1172793178@localhost> (Xavier Maillard's message of "Fri\, 02 Mar 2007 00\:52\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41189>

Xavier Maillard <zedek@gnu.org> writes:

> @@ -22,18 +22,19 @@
>  ;; This file contains a VC backend for the git version control
>  ;; system.
>  ;;
> -;; To install: put this file on the load-path and add GIT to the list
> -;; of supported backends in `vc-handled-backends'; the following line,
> -;; placed in your ~/.emacs, will accomplish this:
> -;;
> -;;     (add-to-list 'vc-handled-backends 'GIT)
> +;; To install: put this file on the load-path.

Simply putting it on the load-path is not enough to make it work,
you'd still have to load it explicitly; it's not clear to me that this
is better than adding it to vc-handled-backends. We can of course
support both approaches, so the rest of your patch is fine, I just
don't think the installation instructions should be changed.

-- 
Alexandre Julliard
julliard@winehq.org
