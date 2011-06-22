From: David Barr <davidbarr@google.com>
Subject: [RFC/PATCH 0/3]
Date: Wed, 22 Jun 2011 00:33:29 -0700
Message-ID: <1308728011-14136-1-git-send-email-davidbarr@google.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 09:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZHxc-0005HD-PU
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 09:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab1FVHep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 03:34:45 -0400
Received: from smtp-out.google.com ([74.125.121.67]:38502 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab1FVHen (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 03:34:43 -0400
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com [172.25.149.5])
	by smtp-out.google.com with ESMTP id p5M7YfuC018413
	for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:41 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308728081; bh=AViSY5Hj4JBTZXXRbAqAId0Hcok=;
	h=From:To:Subject:Date:Message-Id;
	b=c6YkXU+Fc5ZptRaR8wgUi5emI5BMen858hpL0Ym/F+Inpm4GabdHDzcoqr/72dZ4/
	 K+a1ZPnc0hhhRfXV8yc5Q==
Received: from pwi4 (pwi4.prod.google.com [10.241.219.4])
	by hpaq5.eem.corp.google.com with ESMTP id p5M7YdIi001982
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:40 -0700
Received: by pwi4 with SMTP id 4so477068pwi.15
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=lboewIhSRC55GQmlz9kaq4VNbkt069205blutMR+s/s=;
        b=vxUZCg3075omRKwusTi650ZDfNaiwYJVQFnsMA9dP7n2xqDzcU3DLxjMHQtyhCOAGE
         OII6w7DjBtzvD1F+5FcA==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=from:to:subject:date:message-id:x-mailer;
        b=KcKdxnOTxYwVHQSiI+z1MrWbdRBYb+1F/D7CsXws6Rt4f/b7yTFDNETKcEOEMvKH11
         sfUWvih1SMAOidAQbTlg==
Received: by 10.68.8.105 with SMTP id q9mr146833pba.3.1308728078798;
        Wed, 22 Jun 2011 00:34:38 -0700 (PDT)
Received: from localhost.localdomain (173-167-127-66-sfba.hfc.comcastbusiness.net [173.167.127.66])
        by mx.google.com with ESMTPS id p5sm248637pbd.92.2011.06.22.00.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 00:34:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176223>

This series is the early stages of adding infrastructure to git
to memory-effective but fast and scalable caching of object
graphs.
The inspiration comes from a desire to build a libfastimport and
also the outstanding FIXME in hash.c
Patches 1 and 2 are the first small components that have emerged
from my experiments with different ways of representing and
indexing graphs. Patch 3 doesn't exist at the time of composing
this summary but will be an alternate hash table implementation
the builds on the first two.

I'm putting this out for early feedback, to be incorporated into
a future complete series.

--
David Barr
