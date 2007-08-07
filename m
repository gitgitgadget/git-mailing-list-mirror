From: Brian Swetland <swetland@google.com>
Subject: git-p4.py: doesn't handle symlinks
Date: Mon, 6 Aug 2007 21:59:50 -0700
Organization: Google, Inc.
Message-ID: <20070807045950.GA9644@bulgaria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 07:01:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIHBg-0004nz-6J
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 07:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbXHGFAp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 01:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbXHGFAp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 01:00:45 -0400
Received: from smtp-out.google.com ([216.239.33.17]:16295 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbXHGFAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 01:00:44 -0400
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id l7750cIH014505
	for <git@vger.kernel.org>; Tue, 7 Aug 2007 06:00:39 +0100
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:subject:message-id:mime-version:
	content-type:content-disposition:organization:user-agent;
	b=oru6bSh6FdAWw+OrfjaoKlm0V3FwlA8Dhz2rVCn/diTNnQH5+I257YTBt7u1Fho5E
	bcY+6kj0aVkp+XGtx/Hrg==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps77.corp.google.com with ESMTP id l7750WRY005450
	for <git@vger.kernel.org>; Mon, 6 Aug 2007 22:00:34 -0700
Received: by bulgaria (Postfix, from userid 1000)
	id 2B2B58F363; Mon,  6 Aug 2007 21:59:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55217>


My python-fu is weak and I don't have the time tonight to unravel it,
but in case somebody cares (or has a quick fix), it appears that the 
git-p4.py script deals with symlinks in p4 by checking in a textfile 
(to git) containing the name of the target of the symlink.

Of course there *shouldn't* be symlinks in the p4 depot I'm importing
from at all, but that's a different sort of problem.

Brian
