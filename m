From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] refs.c: add a function to append a reflog entry to a
 fd
Date: Thu, 20 Nov 2014 14:11:10 -0800
Message-ID: <20141120221110.GM6527@google.com>
References: <20141120023655.GG6527@google.com>
 <1416508657-9057-1-git-send-email-sbeller@google.com>
 <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
 <20141120215941.GB22370@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:11:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZwe-0001j5-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 23:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbaKTWLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 17:11:16 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:53799 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbaKTWLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 17:11:15 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so5613471igd.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 14:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vr6uBPV8eemDtapfLf95IVHQtYvFM/xm2Zq4GGsccvk=;
        b=RcpJ1itmUO18boR5tO8LWEBM4wPkuk7yT5DRHu7srC6MteoROtDeeFqY7J0xpkrT+z
         nTpIKX5IKiK36oZuQ7LmU7YCzf9KajywCOOOXqLgmRJ89EjM26eqq9JHXkdn/2ZANDxh
         ig7psKz5DZkUR1ypmd+B+cHpLDc2BvEf7WU5U6VjP7hf1OO9EKuvS8K5gv56cCUIHNZU
         NVd5xSMlWKA5ekTPeqFm4dgGX5QCAhGm93kZJHyQ8D/fZJrjPeMkAIM1Hs7pG1CVfWH1
         D30ipJmAqBprVj4Tf4tu6BiJTr1J/eyHGQZHp8QRFfWutLzZnT1sAiM0lb9hMtNtVUXo
         TTYg==
X-Received: by 10.107.3.157 with SMTP id e29mr849581ioi.44.1416521475101;
        Thu, 20 Nov 2014 14:11:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id b123sm1884016iob.4.2014.11.20.14.11.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 14:11:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141120215941.GB22370@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
[...]
>  refs.c | 48 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 18 deletions(-)

The --patience diff makes review of this version very simple.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
