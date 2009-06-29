From: David Reitter <david.reitter@gmail.com>
Subject: bzr to git syncing
Date: Mon, 29 Jun 2009 15:12:24 -0400
Message-ID: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com>
Reply-To: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 21:18:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLMMe-00043t-4P
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 21:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbZF2TRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 15:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbZF2TRu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 15:17:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:31538 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZF2TRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 15:17:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1328890rvb.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:reply-to:subject:date:message-id:to
         :mime-version:x-mailer;
        bh=QcOa4/rMBDw3uHj+G8DIe1KuFDPcB2BOidLk5lok0ds=;
        b=nzlgTCT4RjbhjSbeQAmoHZRzuQs5Fy45idhYdLQwBOwNfcL2VS6gruk5zCWWhIheS+
         0dMiIoAdcOniI1+6oOkX0fW5ImMnJD8whOraQ/FCiEIWl8atuphjO9OB3Uab/D8OBUma
         ZFTgmCxK5ZVlDPKO7pDS+CRt7U1hreDYIuMko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:reply-to:subject:date
         :message-id:to:mime-version:x-mailer;
        b=q8GQgpg/o3+CbASq/4knvwIEQ2kd+d2hHHX7VHYqm5bBWO1yFFrKNUoyrX44iMwyBI
         xiH953UEWhChN7mnnERNwVeFGwE1gIt/VXqkA/ZZoQBj4aUrjZtFXYNVPMrnYWTkRn5M
         cZVhFOBPpjAXhPcpf2esSOuAE+pZlD24G6YqQ=
Received: by 10.141.22.2 with SMTP id z2mr1643393rvi.5.1246302749004;
        Mon, 29 Jun 2009 12:12:29 -0700 (PDT)
Received: from scarlett.psy.cmu.edu (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id c20sm3901510rvf.49.2009.06.29.12.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 12:12:28 -0700 (PDT)
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122453>

Does anyone have experience syncing a Bzr repository to git?
I would ideally want two-way syncing, but even the bzr->git route  
would be a start.

We're starting with a Git repo that was converted from CVS and it  
being kept up to date.  The CVS repo will be converted to Bzr sooner  
or later, and at that point we'd need to sync from that one.  We would  
need to keep the revision IDs coherent, i.e. not re-convert.

I have looked at the git-bzr scripts that go the fast-im/export route;  
this fails unfortunately (bzr side I think).    Also, I'm not sure if  
that would preserve revids.

It strikes me that patches / merge bundles would be cleaner way to do  
this.

(If you care: The background of this is that Emacs is switching to  
Bzr, but my downstream project, Aquamacs, and a bunch of Emacs devs  
want to use git themselves, so I'm trying to find someone who can do  
this.)

Thanks in advance for your suggestions.
