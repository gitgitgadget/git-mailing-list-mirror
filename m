From: Kevin Ballard <Kevin@sb.org>
Subject: commit 'git-send-email: add support for TLS via Net::SMTP::SSL' causes warnings
Date: Thu, 26 Jun 2008 13:19:51 -0700
Message-ID: <DF091369-1771-4405-8705-BDBC59C7E48A@sb.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Thu Jun 26 22:20:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBxxc-00015b-VW
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbYFZUTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 16:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbYFZUTz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:19:55 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:40431 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752412AbYFZUTy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 16:19:54 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id 5226590BBF;
	Thu, 26 Jun 2008 13:19:53 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86480>

Your recent commit to next (f6bebd1) causes warnings when no form of  
encryption is specified. Specifically, lines 755 and 765 reference  
$smtp_encryption, but when no encryption is given at all this variable  
is undefined.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
