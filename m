From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/4] completion: couple of cleanups
Date: Thu,  2 Feb 2012 03:15:16 +0200
Message-ID: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 02:17:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RslIb-0006nq-T4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab2BBBRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:17:13 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61764 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482Ab2BBBRM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 20:17:12 -0500
Received: by lagu2 with SMTP id u2so1000086lag.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ow8VyOlStSJjBuU4L8pzDcVGkqgj7+qhYDZ9PCjToFs=;
        b=nW899CzhjiDBFbYS9+7Cn8uOcZWAmcT8Mh5OHOzVV3PULKV5jFoQh2WM8lTe6W+JQx
         oTD6v2CVVakvVz2pAQeTnh4eDJxACGxss7LLyP37NTDN95L7LE49WexU0+YLAt/wS8J/
         968qbG9IZWvb5fgcOfHxO5TTF0hv4iQ1uad5g=
Received: by 10.152.145.101 with SMTP id st5mr471399lab.1.1328145362550;
        Wed, 01 Feb 2012 17:16:02 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id z2sm627749lbk.7.2012.02.01.17.16.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 17:16:02 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189567>

And an improvement for zsh.

Junio: I see you already picked most of them for 'pu', but I've made further changes based on the feedback:

 * completion: be nicer with zsh
	Improved the code-style

  * completion: simplify __gitcomp*
	Fix
	Improved commit message

Cheers.

Felipe Contreras (4):
  completion: be nicer with zsh
  completion: simplify __git_remotes
  completion: remove unused code
  completion: simplify __gitcomp*

 contrib/completion/git-completion.bash |   66 +++++---------------------------
 1 files changed, 10 insertions(+), 56 deletions(-)

-- 
1.7.9
