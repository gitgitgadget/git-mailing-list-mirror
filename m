From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 15/35] remove_lock_file(): call rollback_lock_file()
Date: Tue, 16 Sep 2014 15:13:12 -0700
Message-ID: <20140916221312.GO29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-16-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:13:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU0zv-0005hF-2A
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbaIPWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:13:16 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38733 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbaIPWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:13:15 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so659417pdj.20
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YGXmhgktmMprClxs9Ft4S5YxVTNnqnrUtngy4n8etoQ=;
        b=AeVNhmzsQgaXyvBYazHpdRW9RN75Te5ygd4QUEZ6uwpsE1EqZk4rlVOG6bEmbdlaxe
         0pAtnCq7v57vx9SzXKKsyW5zR0E0SCN1/ME0E1mCHE15lQpLNUnnCx63fc3x4v555PYv
         98/ttQfN9xhOB4O4G8PSWdTgj8042rmtwYREVZySYNVv3uLB3GHMPrWNVg/kBjaMNNes
         5YsJ7tD+qLRsMTrhMGNZBqgqaK5RFtdBhH/3t7uDt/DrSiWrxKp5w/YPsyczXJ8kPvnL
         6fAG+MxZFzEetpbio+a2l36++WdeEQXaWXdyluCXpnX52juiFuLla4m+y3Fspn6wFNkU
         fUtA==
X-Received: by 10.68.133.199 with SMTP id pe7mr28434108pbb.132.1410905595098;
        Tue, 16 Sep 2014 15:13:15 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id du5sm14968767pbb.80.2014.09.16.15.13.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:13:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-16-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257199>

Michael Haggerty wrote:

>  lockfile.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Nice.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
