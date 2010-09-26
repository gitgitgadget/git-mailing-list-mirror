From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] Porcelain scripts: Rewrite cryptic "needs update" error message
Date: Sun, 26 Sep 2010 18:31:09 +0200
Message-ID: <vpqiq1spiuq.fsf@bauges.imag.fr>
References: <4C9E07B1.50600@workspacewhiz.com>
	<1285514516-5112-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 18:34:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzuBg-000224-GQ
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 18:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144Ab0IZQer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 12:34:47 -0400
Received: from imag.imag.fr ([129.88.30.1]:53436 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab0IZQeq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 12:34:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8QGVA5E004735
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 26 Sep 2010 18:31:10 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ozu85-0003WF-QG; Sun, 26 Sep 2010 18:31:09 +0200
In-Reply-To: <1285514516-5112-3-git-send-email-artagnon@gmail.com> (Ramkumar Ramachandra's message of "Sun\, 26 Sep 2010 20\:51\:56 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 26 Sep 2010 18:31:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157239>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  		# Run in subshell because require_clean_work_tree can die.
> -		if ! (require_clean_work_tree)
> +		if ! (require_clean_work_tree "rebase")
>  		then
>  			warn "Commit or stash your changes, and then run"

That will make a duplicate "commit or stash your changes" message.

Otherwise, the patch seems OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
