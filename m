From: "Mike Coleman" <tutufan@gmail.com>
Subject: bug: git-diff silently fails when run outside of a repository (v1.5.4.2)
Date: Tue, 29 Apr 2008 15:04:32 -0500
Message-ID: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 22:06:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqw4q-0000vR-Sa
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759264AbYD2UEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759174AbYD2UEe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:04:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:31680 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759059AbYD2UEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:04:33 -0400
Received: by wa-out-1112.google.com with SMTP id m16so220884waf.23
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=APg569XYZwDXsNgpRWePE754K+8pnjdvXthorzjjffM=;
        b=rsdufBvFLkvsdDqFkSvrY7wv91GScGphKPZUj91fMW8b241r7TC95kPujoLxtTFSABS9+4WoszFdUio5z0MTP2i7YqsY0hoPmBcKUrdAWImZ4JS4v3qhzKUR19Li3ndn3D3iQNOuLvsWi/9nsBw/nh3qoJINcC+y17/3zbRnQHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fyDwXiitmuUrgRqJxfP/hJabgr8nCpvFFnd6KskszI80PuflDePJjWWb29geYF+iPQSEps33Xaz+1wBKvn+mUuiBaYA7f2h2mioKxSVbfrnEbfD509LOtuQdV7Crg4pu8YGk+gSAGEAU4vrELA6UOgvBwgpgD6sNYzY7YQ5KB3E=
Received: by 10.114.126.1 with SMTP id y1mr5080760wac.41.1209499472451;
        Tue, 29 Apr 2008 13:04:32 -0700 (PDT)
Received: by 10.114.92.7 with HTTP; Tue, 29 Apr 2008 13:04:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80722>

At least in version 1.5.4.2, git-diff silently fails when not run
inside a repository.  It should give an error diagnostic, especially
since "no output" would otherwise be a meaningful response.

I think there are other git programs that have this problem as well.

Mike
