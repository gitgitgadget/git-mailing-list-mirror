From: linux@horizon.com
Subject: Re: [PATCH] PPC assembly implementation of SHA1
Date: 23 Apr 2005 13:03:25 -0000
Message-ID: <20050423130325.31913.qmail@science.horizon.com>
References: <20050423124246.30071.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Apr 23 14:58:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPKDd-0006M1-HL
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 14:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDWND0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 09:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVDWND0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 09:03:26 -0400
Received: from science.horizon.com ([192.35.100.1]:31813 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261577AbVDWNDZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 09:03:25 -0400
Received: (qmail 31914 invoked by uid 1000); 23 Apr 2005 13:03:25 -0000
To: paulus@samba.org
In-Reply-To: <20050423124246.30071.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

One bug I spotted too late: the first line of the STEPD2
macro still references %r15; that should be the new home of k, %r5.

Sorry about that.
