From: Aaron Digulla <digulla@hepe.com>
Subject: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 08:49:26 +0000 (UTC)
Message-ID: <loom.20090410T084314-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 10:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsCXR-0007DU-Pd
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 10:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762500AbZDJIzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 04:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761378AbZDJIzI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 04:55:08 -0400
Received: from main.gmane.org ([80.91.229.2]:60825 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762197AbZDJIzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 04:55:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LsCVq-0005QZ-Ph
	for git@vger.kernel.org; Fri, 10 Apr 2009 08:55:02 +0000
Received: from 194.230.154.168 ([194.230.154.168])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 08:55:02 +0000
Received: from digulla by 194.230.154.168 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 08:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.230.154.168 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116248>

Hello,

I need a way to safely synchronize data between several places using an unsafe
storage (USB stick, Internet drive). So my question is: How much work would it
be to patch GIT to encrypt all files in the repository using AES-256?

I'm aware that this leaves an issue unresolved (where should I store the
password so that GIT doesn't have to ask for it all the time?) but one step at a
time, please :)

Regards,

-- 
Aaron "Optimizer" Digulla
