From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: am: be more helpful
Date: Sat, 10 Apr 2010 00:59:11 +0200
Message-ID: <t2kfabb9a1e1004091559u92230e17h957f2c5565c133e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 00:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NAn-0005EU-Lv
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 00:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab0DIW7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 18:59:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47178 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0DIW7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 18:59:32 -0400
Received: by gwj19 with SMTP id 19so44840gwj.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=7vVSzxxmeWQirNNlVvBq+o5rY7NapiGHOzXTXz1/JMo=;
        b=BbQ85Rpr6z57niUyIQyQX9oeooO2TbEGeicnQBkLXvoLoBK3Jz4nJdYoMJYDue1rUm
         4nZnfq5cVUsS1l+5ofuWyKh/PJmxKtpRl8pf02pBgPEOadR8he+ADVTIOnQVTNb6To9V
         V5zkhbPe/inmJG75NVcFyrn2Grf9yFUnqN5Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=vzysLbcGGIQxfAGOj2uCXYIdj5gWnI+v+9lS+cNPZKTw2BcGOx6LvhQJvKVZrck+TH
         AvOdWu1bgdR2oSFkVYdODc+BfPf85f+e9dK8NxMX/kCXNf3IitGyx0M48TCM9Sy5kLFb
         jDewQj4W1ICLvFvdQv+7NcPoX32uJHa2BCcY0=
Received: by 10.100.206.13 with HTTP; Fri, 9 Apr 2010 15:59:11 -0700 (PDT)
Received: by 10.101.177.39 with SMTP id e39mr971453anp.32.1270853971163; Fri, 
	09 Apr 2010 15:59:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144481>

Heya,

I run into this problem every now and then when I manually apply a
patch. I apply it, do some stuff, and then having forgotten I already
applied it, try to apply it again, and am confused as to why it won't
apply. Would it be difficult to teach 'git am' to see if the patch-id
of the patch that couldn't be applied has been applied already
(similar to what 'git cherry' does I guess?) and print a helpful
message saying "warning: patch already applied" when there is a
conflict trying to apply such an already-applied patch?

-- 
Cheers,

Sverre Rabbelier
