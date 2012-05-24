From: David Barr <davidbarr@google.com>
Subject: [PATCH 0/7] vcs-svn: housekeeping
Date: Fri, 25 May 2012 00:04:12 +1000
Message-ID: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfQ-0003cl-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab2EXOFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:24 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:43505 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab2EXOFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:23 -0400
Received: by ghrr11 with SMTP id r11so1860662ghr.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nqTiIxLBoGIb6YratXxTO9WAZJnrqSQ5qv0LRz2JSBk=;
        b=MXjlXT1zPDic70Mr6vFycdIqXmKdDryZfOVrgZ6U8/5zEHn+lVb7d0GeyTvM0Ofb2u
         C69eT4ggOU+98DQ6kRiPm4+hAuQNzlTb4hO7Lox2WhfC6sVSiulK9RPhZTeYpd3uLWn5
         87NyJm7IsepdLo0F35rj2Ju4oDhfwP9+NFwNCr+hG+73OuU4Ds3stYUqXzC7MHjOx/Ni
         TzrN1n9kfvYv4XcRNSnoIxQdFWaaDmDmcbzcGkyLNDXxZ5nVy5+wd0zOCdR6CZdF1Sk1
         recVvwPgJ/KA745K9T2TKihRNasnAcmjQvf0X0+07fKX03w3uMrID9zpFdKof/1HPIpq
         ySEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=nqTiIxLBoGIb6YratXxTO9WAZJnrqSQ5qv0LRz2JSBk=;
        b=jDdW1wPaQocXCsen25/NqoDHmRi4NOxYsBvBOFl/7wtcWz9MVRIzn7L8VlOv1S5foB
         y+Hx541ppd9kXt2pqR2Zw8Ry+ZkMSnF9payojo7qQsgiZo7KOJi1l7j/3JclLXPmeqJZ
         e8GTkh5C7CSuIdGZGvBObZ75851o2yzokfu/YIo42U40IBwXYB25aT0cMkanTJsaabKq
         hxNIuYhNdHQL3tzb/6ww7JD9c1OK/YPggwQTV8xhCzoSPgU8WTWs15ThaT533GzH5zpG
         bKNupTy/AfxyualFXI9uKN8nSmEULTqF6UIK1CrX/WqNumaAWhCo2M0FzckvdMdjCQSz
         Iraw==
Received: by 10.68.190.131 with SMTP id gq3mr191390pbc.17.1337868322731;
        Thu, 24 May 2012 07:05:22 -0700 (PDT)
Received: by 10.68.190.131 with SMTP id gq3mr191352pbc.17.1337868322491;
        Thu, 24 May 2012 07:05:22 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
X-Gm-Message-State: ALoCoQlzaFCgtA2bVix4cvQF9FbQoQS56F/c1QMlHk37GH82bEIpEs3B5trVyFWQB+GJe/PZX1sk0SPnCU1XdWUYQmL5gejN6BfDYMy/bl9nWMUE5ZUBgFVW+S3hQyDD7QmJjDGRkZFq/2n4k1VnPnF1WIgn6LjB20LHXHe9TaQrLhyIKiEJPLk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198376>

I've begun to upstream the changes made in the git fork
of svn-dump-fast-export in vcs-svn back to the original
project. This series contains the fixups I needed to
compile without errors or warnings and pass static
analysis.

--
David Barr
