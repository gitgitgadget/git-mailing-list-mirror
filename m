From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v5] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sun, 20 Jan 2008 10:23:26 +0300
Message-ID: <20080120072326.GN14871@dpotapov.dyndns.org>
References: <12007651514111-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	torvalds@linux-foundation.org, gitster@pobox.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 08:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGUXe-00081M-UV
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 08:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760125AbYATHXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 02:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760115AbYATHXd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 02:23:33 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:64325 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbYATHXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 02:23:32 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id BBEB430DFF;
	Sun, 20 Jan 2008 10:23:26 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-190-198.pppoe.mtu-net.ru [85.141.190.198])
	by smtp02.mtu.ru (Postfix) with ESMTP id 240B2304FB;
	Sun, 20 Jan 2008 10:23:24 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JGUWc-0002Sz-B2; Sun, 20 Jan 2008 10:23:26 +0300
Content-Disposition: inline
In-Reply-To: <12007651514111-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71161>

On Sat, Jan 19, 2008 at 06:52:31PM +0100, Steffen Prohaska wrote:
>
> +test_expect_failure 'safecrlf: autocrlf=input, all CRLF' '
> +
> +	git repo-config core.autocrlf input &&
> +	git repo-config core.safecrlf true &&

repo-config is deprecated. Please, s/git repo-config/git config/
here and in other places.

Dmitry
