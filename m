From: "John J. Franey" <jjfraney@gmail.com>
Subject: changing history once public
Date: Fri, 30 May 2008 17:24:50 -0400
Message-ID: <1212182690.8311.30.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 23:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2C6v-0005AR-R5
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbYE3VZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbYE3VZE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:25:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:62957 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYE3VZC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:25:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so20874ywe.1
        for <git@vger.kernel.org>; Fri, 30 May 2008 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=6f5mXec/4kg8Pf6Ui6a3WJSXc0RXRNK/b1J2XYhOgaE=;
        b=VHUewjV8gtFeOeMd5K4Rqz5U4QmaksecEX7tNmLdL75mFr1WLKZiHM0tStw3k3x+kU8JuYrO3Ky7kXmRyrQ2vnJZ1Z5ncLVWx0USddrsdU5vAnhQhx+JHMbrgKYwVPgDrp+tMR1j0duBICzhGddCzo+xxIUwaXXN01uPuH//Eyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=aendyteQJ9ToUu/ZZrsFgq08Ad1JUFJDuD63OPrrHNt6Q10jHMu3JyDBc5bmYC3EqPwukttHbcR1CUtk8bUBxgoR0MiTLfTwbv1laf5jUx/tTJ/m0CeZr+kVKXchQB2xVDOYP/oyjVT8PXaLbRalLxmVxl0PtPL+Xxl7FKn3Qeg=
Received: by 10.150.51.4 with SMTP id y4mr2076113yby.35.1212182692057;
        Fri, 30 May 2008 14:24:52 -0700 (PDT)
Received: from ?192.168.2.102? ( [70.21.168.140])
        by mx.google.com with ESMTPS id 30sm134368yxk.4.2008.05.30.14.24.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 14:24:49 -0700 (PDT)
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83337>

I think I understand the issue with changing history on branches that
have been made public.

What is the negative of publishing a branch and not being able to apply
history changing commands?

If I want to keep this branch current (in public), I would pull from the
tracking branch resolve conflicts and push to my public repo.  This
action leaves my commit as the parent of another commit; it is not
longer at HEAD.  Does it matter if my commit is no longer HEAD of my
branch?

I think the downside of not keeping my branch current is that I'd be
handing off to my colleagues the task of resolving merge conflicts.  Is
that right?

Thanks,
John
