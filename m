From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 1/4] get_pathspec(): die when an out-of-tree path is given
Date: Fri, 7 Mar 2008 19:29:42 +0100
Message-ID: <200803071929.42499.robin.rosenberg@dewire.com>
References: <1204879119-7528-1-git-send-email-gitster@pobox.com> <1204879119-7528-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhKz-0007dQ-2o
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042AbYCGS3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757618AbYCGS3q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:29:46 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18927 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757829AbYCGS3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:29:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 777638026D5;
	Fri,  7 Mar 2008 19:29:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y+aQpeyN2aDB; Fri,  7 Mar 2008 19:29:43 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 1E6C0802671;
	Fri,  7 Mar 2008 19:29:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1204879119-7528-2-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76513>

My gcc refuses to cooperate, giving me SEGV at line 666 or combine-diff, so 
I'll ask instead of testing.

Do absolute paths to diff still work without exiting?

-- robin
