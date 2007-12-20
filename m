From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Reallow git-rebase --interactive --continue if commit is unnecessary
Date: Thu, 20 Dec 2007 08:52:21 +0100
Message-ID: <vpqodcl247e.fsf@bauges.imag.fr>
References: <20071220071212.GA20534@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 08:53:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5GDr-0005oe-8b
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 08:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbXLTHxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 02:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXLTHxH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 02:53:07 -0500
Received: from imag.imag.fr ([129.88.30.1]:55977 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbXLTHxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 02:53:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBK7qM4n010336
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 08:52:22 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J5GCb-0003jt-Af; Thu, 20 Dec 2007 08:52:21 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J5GCb-0002mY-8N; Thu, 20 Dec 2007 08:52:21 +0100
In-Reply-To: <20071220071212.GA20534@spearce.org> (Shawn O. Pearce's message of "Thu\, 20 Dec 2007 02\:12\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 20 Dec 2007 08:52:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68982>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> -		git commit --no-verify -F "$DOTEST"/message -e ||
                                                                  ^
Wouldn't it be sufficient to add a backslash here ----------------' ?

> +		if ! git commit --no-verify -F "$DOTEST"/message -e
>  			die "Could not commit staged changes."
> +		fi
>  
>  		require_clean_work_tree
>  		do_rest

-- 
Matthieu
