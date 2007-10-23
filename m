From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 18:19:42 +0200
Message-ID: <vpqejflolb5.fsf@bauges.imag.fr>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 18:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkMUk-0007ZT-A4
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 18:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbXJWQUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXJWQUa
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 12:20:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:34106 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbXJWQU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 12:20:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9NGJgPp029378
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 18:19:42 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IkMTm-0001S5-Fx; Tue, 23 Oct 2007 18:19:42 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IkMTm-0003Yg-Dc; Tue, 23 Oct 2007 18:19:42 +0200
In-Reply-To: <20071023152445.GA10070@piper.oerlikon.madduck.net> (martin f. krafft's message of "Tue\, 23 Oct 2007 17\:24\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 23 Oct 2007 18:19:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62134>

martin f krafft <madduck@madduck.net> writes:

> Now I woul like to undo the merge.

Dirty solution: export the patch corresponding to the merge (diff
M..M^), and apply it on master. If you have no conflicts, it should be
doable. If you have conflicts, it will probably be painfull.

-- 
Matthieu
