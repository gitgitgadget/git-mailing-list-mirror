From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 17:20:38 +0200
Message-ID: <vpqvegpe4e1.fsf@olympe.imag.fr>
References: <1174825838.12540.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 17:21:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVUWl-0005qx-0B
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 17:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbXCYPUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXCYPUu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 11:20:50 -0400
Received: from imag.imag.fr ([129.88.30.1]:39432 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbXCYPUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 11:20:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2PFKckE000588
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 25 Mar 2007 17:20:38 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HVUWM-0000s7-8r
	for git@vger.kernel.org; Sun, 25 Mar 2007 17:20:38 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HVUWM-0006BW-6N
	for git@vger.kernel.org; Sun, 25 Mar 2007 17:20:38 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <1174825838.12540.5.camel@localhost> (Eric Lesh's message of "Sun\, 25 Mar 2007 05\:30\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 25 Mar 2007 17:20:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43057>

Eric Lesh <eclesh@ucla.edu> writes:

> .gitlink is for a lightweight checkout of a branch into a separate
> directory on the local filesystem.

I think it's a pitty to restrict yourself to _local_ filesystem. There
are tons of cases where you have a fast, non-NFS, access to a machine
and would like to host your repository there.

That said, I suppose removing this restriction moves the solution from
the category "quick and efficient hack" to something much harder.

> A .gitlink'ed checkout has its own index+HEAD, but otherwise refers
> back to the main repository for objects, refs, etc.

Stupid question: why .gitlink, and not .git/link or so? This file is
not versionned, I don't think it should be in the working tree.

-- 
Matthieu
