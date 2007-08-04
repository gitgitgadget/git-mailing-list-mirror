From: Mark Levedahl <mlevedahl@gmail.com>
Subject: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 11:07:03 -0400
Message-ID: <46B49617.3070402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLDo-0004gu-9U
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbXHDPHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbXHDPHK
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:07:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:43212 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756898AbXHDPHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 11:07:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1063961wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 08:07:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=TIRBnmb7xA2Ze3dnmZvnb6seJNjeTrn7Ufu5uXmqHFAIr3PxrU35OT6RmCFmMd66IJqVY5NU9bQ1fK5c4aYRPnNRp8gvf/B3K5PmUQXtxaORbokzY4m9IpXVlwOaeNK3o3p8q6+JhlmDhU6xihTiJtZIdDYWZRi21E7l9ysXX+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ka4IF49nljg1NZU9/zZVTSyrFq+/XHMcT83EwTL1cVi6dIYtY9UMnwMJ007/kqu4GG2CIvnr8U97aMXTN4cWSyp4xz0W2PuOMORKQmrZJU/o8QIYHHTP6AcYOGC9YQckVf8UgWls9rOf9ZGiI2Pk+9N3BAxzGOJUtIjuUW2nXnU=
Received: by 10.90.51.17 with SMTP id y17mr3853233agy.1186240027845;
        Sat, 04 Aug 2007 08:07:07 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id g7sm4695994wra.2007.08.04.08.07.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 08:07:05 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54862>

Beginning with commit

6490a3383f1d0d96c122069e510ef1af1d019fbb Fix work-tree related breakages

install-doc-quick.sh no longer installs man pages, at least not to the 
defined $mandir (if "git-checkout-index" is putting them somewhere else, 
I haven't discovered where). Reverting the above commit eliminates this 
problem. This is on Cygwin, haven't tried on Linux.

Mark Levedahl
