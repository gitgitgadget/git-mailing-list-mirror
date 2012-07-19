From: "Rafal W." <kenorb@gmail.com>
Subject: Bug: Git-Svn creates wrong tag when svn tag contains spaces
Date: Thu, 19 Jul 2012 15:41:32 +0200
Message-ID: <3760846560270293323@unknownmsgid>
Mime-Version: 1.0 (iPhone Mail 8A293)
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 15:49:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srr6L-0005IU-JS
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 15:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962Ab2GSNtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 09:49:04 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58785 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSNtC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 09:49:02 -0400
Received: by qadb17 with SMTP id b17so3662851qad.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:mime-version:date:message-id:subject:to:content-type;
        bh=hGgSPxLmUgY+AcQLGSBBkXfZTfYEuCtwZhi9t/38gHY=;
        b=XZ2PwBDtMlmFXlIocYpmD8t0/UwqYtOUcTlkgT7IGP9To+i4iSzPVpEqNUJJr4qATI
         fpHT069QhZzir8Cj2CUE/V4rLNRWg4NDupqe6rdGa9zFGNJvQNcx/E4rF56cQpOgz0vp
         WAd8ARYCnCIibRn4TpyFogISzp11co/pxwwqLmI83QNxbXZeDQlyayjD0pTfVIhAV6St
         EiaDNaVI9uhwRiC5J9bve8bYZGtycIDB4cLdF5cfmJb+78tM9g4Ps7yxAz8W4FPBjoig
         +Y4sWjmIY7txoCy6FvvK+kQ85Nk1lh7UB8Qo+8Eo0Vj7q3MJzlMLXU0mQFyes08pEgjo
         oKuw==
Received: by 10.224.178.73 with SMTP id bl9mr488059qab.89.1342705741494; Thu,
 19 Jul 2012 06:49:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201734>

I've the problem described here:
http://code.google.com/p/git-core/issues/detail?id=16


Kind Regards,
Rafal

Sent from my iPhone
