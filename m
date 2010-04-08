From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/2] Document update for 'git-blame' '-M' and '-C' option
Date: Wed,  7 Apr 2010 23:51:28 -0700
Message-ID: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 08 08:51:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlaM-00010g-Kt
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355Ab0DHGvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:51:25 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43264 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758290Ab0DHGvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:51:25 -0400
Received: by pva18 with SMTP id 18so1199735pva.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GVIo5HXsqPNfPe7p4lnCGpRb6rJ7914wh13bZhGyUyQ=;
        b=bObGhDMXYTDMGOSyOhul7mLyUl/nLQCXjm2fZpMur6hRONAQhodPZhPpoSupKwsqKX
         YHgx5IJRmvgzqcBF7MEmhONWLD5VZVxV9pet6sCwyU/rqq8+Q7CeQ/hgQZdDHmWGY6uJ
         w8bUPs4f3WsumcyJH0NzQtfgpVdRnq7qsoJfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fMDzel4gO2vf3E9lyJuAeooOIEDxtCslirdw9dxBhbqGIqhlpi9YHec1W7v9bYL394
         yv5wb6/4N8TxBnQL5rAe9xgnmoNmZARN2sn37tSTkDdzqhz01yMN+ZzEtEWEQ54Sr44a
         euKG3MvjEZlPqvSMINxNJRoX9Z0A72BaR/6ug=
Received: by 10.142.2.2 with SMTP id 2mr3940293wfb.75.1270709484430;
        Wed, 07 Apr 2010 23:51:24 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id 22sm3689059iwn.12.2010.04.07.23.51.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 23:51:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144330>

The current 'git-blame' manual state that '-M' detect code move and '-C' detect code copy. After read some code of 'git-blame' and some expriments with it. I found that both '-M' and '-C' detect code move and copy. So, I think the document should be updated.
Thanks Thomas Rast a lot for his help on this patch.

Bo Yang (2):
  Add a basic idea section for git-blame.
  Change the description of '-M' and '-C' option.

 Documentation/blame-options.txt |   41 +++++++++++++++++++++++---------------
 Documentation/git-blame.txt     |   32 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 16 deletions(-)
