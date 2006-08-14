From: David Rientjes <rientjes@google.com>
Subject: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 13:17:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:17:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCisU-0005kc-Cv
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWHNURa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWHNUR3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:17:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:34701 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932695AbWHNUR2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:17:28 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7EKHO1d019085
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:17:24 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=ntABGBmILe9v6VYjzNUBLHFxww47wlsDEpmyWtmoZfp37NSRE1dx1Wu7aeJOK24Ds
	ru/FqE9m7axBs0249JrpQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7EKHGbW016507
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:17:21 -0700
Received: by localhost (Postfix, from userid 24081)
	id 9928087D71; Mon, 14 Aug 2006 13:17:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 8A8F387D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:17:16 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25380>

This patch series cleans up a number of static function returns that are either 
meaningless or could be more efficiently written.

		David
