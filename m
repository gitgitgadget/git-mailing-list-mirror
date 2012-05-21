From: David Bremner <david@tethera.net>
Subject: doc bug for git-patch-id ?
Date: Mon, 21 May 2012 10:37:29 -0300
Message-ID: <87zk911wpy.fsf@zancas.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 16:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWTHh-0007cV-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 16:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab2EUOIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 10:08:25 -0400
Received: from tesseract.cs.unb.ca ([131.202.240.238]:33602 "EHLO
	tesseract.cs.unb.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab2EUOIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 10:08:24 -0400
X-Greylist: delayed 1827 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2012 10:08:24 EDT
Received: from fctnnbsc30w-156034089108.dhcp-dynamic.fibreop.nb.bellaliant.net ([156.34.89.108] helo=zancas.localnet)
	by tesseract.cs.unb.ca with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <bremner@unb.ca>)
	id 1SWSo7-0002Ee-OW; Mon, 21 May 2012 10:37:55 -0300
Received: from bremner by zancas.localnet with local (Exim 4.77)
	(envelope-from <bremner@unb.ca>)
	id 1SWSnh-00077k-Dw; Mon, 21 May 2012 10:37:29 -0300
User-Agent: Notmuch/0.13 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
X-Spam-Score: -1.0
X-Spam_bar: -
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198106>


I just discovered that 
  
  git log -p $ref | git patch-id 

works in place of a corresponding loop using git show | git patch-id

This makes a script I'm hacking on about 10 times faster. 

Am I correct in thinking this should be documented better in the man
page?  At least the intent of the source "generate_id_list" seems to be
to support multiple patches on stdin.

I can probably work up a doc patch; of course if somebody else actually
knows what the doc should say is welcome to write it ;).

David

 
