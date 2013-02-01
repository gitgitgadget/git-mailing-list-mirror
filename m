From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATH/RFC] Revert "compat: add strtok_r()"
Date: Fri, 1 Feb 2013 12:49:27 -0800
Message-ID: <20130201204927.GG12368@google.com>
References: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1NYY-0005AN-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367Ab3BAUtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:49:33 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:42947 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756967Ab3BAUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 15:49:31 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so2304939pbc.31
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 12:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=r/Z42lybYDQjAFWxAYFY2ja1KrUk144CAFwX+RjjujE=;
        b=cV6OIEw8d3rxuQsVayx0yhNIJ//UODdTtKDmc+7iJEBucYCE1PhO2MZZDhCKMG+A9H
         FUCEZJoww1co3/lwj+TW5JBbGeMMV0ZYx3+qzsVYtLiqN4utpshaRZZq4hnxVqcvMQWg
         wMJI9DVIJisX9n+FHYYqBuCwS7mmwDR17d3BmKcf5WS6M0I4kc1xzRfaXyIK1JQ0a/ZD
         rWOC8eX6JExfzGek5ssvBlwpEY0kYAzLXhxNU0coEN7w+pVpzsL2XrxXMg27Yc6TeszS
         5nGpwfVfWP1iIGRtQ0NlZ1Nj441aKxLhOznuZwa2ZS8+dwKWYyen5m55VEYKeTehsGpf
         tWNQ==
X-Received: by 10.68.223.35 with SMTP id qr3mr36203941pbc.27.1359751771232;
        Fri, 01 Feb 2013 12:49:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id m3sm10181006pav.4.2013.02.01.12.49.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 12:49:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215271>

Hi Erik,

Erik Faye-Lund wrote:

> This reverts commit 78457bc0ccc1af8b9eb776a0b17986ebd50442bc.
>
> commit 28c5d9e ("vcs-svn: drop string_pool") previously removed
> the only call-site for strtok_r. So let's get rid of the compat
> implementation as well.

Yes, good idea.  Sorry I didn't take care of this at the time.

> Conflicts:
> 	Makefile
> 	config.mak.in
> 	configure.ac

Since the conflicts were straightforward, I'd drop this or replace it
with a quick description of any surprising choices made in resolving
them.

Thanks.  With the fixup from your reply squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
