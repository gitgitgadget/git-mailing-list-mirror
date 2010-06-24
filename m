From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] git gui blame: Show History Context [still] broken since 29e5573d
Date: Thu, 24 Jun 2010 18:28:59 +0200
Message-ID: <vpqy6e4v1h0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 18:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORpLb-0002ID-OT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 18:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab0FXQcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 12:32:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:48057 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070Ab0FXQcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 12:32:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o5OGT0px001159
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Jun 2010 18:29:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ORpIS-00054i-0S; Thu, 24 Jun 2010 18:29:00 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 24 Jun 2010 18:29:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149602>

Hi,

I reported this bug a while ago:

http://kerneltrap.org/mailarchive/git/2010/2/22/24038

In short, the "Show history context" item of the context menu of "git
gui blame" is broken since february. Two patches were proposed:

http://thread.gmane.org/gmane.comp.version-control.git/140688
http://thread.gmane.org/gmane.comp.version-control.git/140288

But I've just noticed that none of theme were applied.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
