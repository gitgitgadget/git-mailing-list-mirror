From: David Rientjes <rientjes@google.com>
Subject: external static var initialization
Date: Mon, 14 Aug 2006 23:10:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608142309030.23498@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 15 08:11:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCs8h-0005Vw-FU
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 08:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWHOGKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 02:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWHOGKr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 02:10:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:671 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965197AbWHOGKq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 02:10:46 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7F6AiOJ000584
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:10:44 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=sU2UbFX3/qT6Q3CTYNFPJrAe2YMCE6MkkmZRqnTCH+aPdkOxSNYM9bLWiXTmQpVgx
	zeac4Ov/y6M69fc/Lb9iA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7F6Ai7Q031233
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:10:44 -0700
Received: by localhost (Postfix, from userid 24081)
	id 2920B87D71; Mon, 14 Aug 2006 23:10:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 2433A87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:10:44 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25437>

Is there a plan to eliminate the ~100 unnecessary external static variable 
initializations to 0 that occur in the code base?

		David
