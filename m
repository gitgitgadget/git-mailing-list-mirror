From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Hosting Git repositories: how useful will git-gc be?
Date: Thu, 03 Sep 2009 11:45:25 +0200
Message-ID: <vpq1vmo9xai.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 11:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj8vq-0007qj-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 11:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbZICJs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 05:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZICJs0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 05:48:26 -0400
Received: from imag.imag.fr ([129.88.30.1]:59922 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340AbZICJsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 05:48:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n839jdBu016424
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 3 Sep 2009 11:45:39 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mj8sf-0007Bx-4o; Thu, 03 Sep 2009 11:45:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mj8sf-0003tW-3a; Thu, 03 Sep 2009 11:45:25 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 03 Sep 2009 11:45:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127643>

Hi,

I'm helping my sysadmin to set up some Git repository hosting via
gitosis. I'm trying to keep it as simple as possible.

A question: is it necessary/recommanded/useless to set up a cron job
doing a "git gc" in each repository? My understanding is that a push
through ssh will do some packing, is it correct? Does receiving a pack
trigger a "git gc --auto"?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
