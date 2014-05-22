From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 22 May 2014 12:51:52 -0700
Message-ID: <20140522195152.GW12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnZ1z-0000E6-LR
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbaEVTv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:51:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55376 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaEVTv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:51:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2960154pbb.19
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=64qjitsQ2nXVGS7ygHTDqv+NwL05JwcLYcrCI83+dPI=;
        b=KuONjFaXGPTfJUWVErZlhPsFYO0025gQphtZCp+cOlPkGwFlgQdfNbH8t6SM/E6Ekl
         LxfLYt3xp5eVVC6kL5xKllomvmq5CM0Qx+r3H2BiSmI9VD9o/D1+kl/SHbaHxKXkcI9K
         75icDz2FR9N3fRuihcREw/bMVY0NnE9Bayf1r0Gt7RnInfHDmP3WJFgHJ0nyjduCEJ+c
         am9WIQFt/a5NlOmgmFSUUiQrCWYqmqmRULtjqjy1zuadkhwkMFmIr4dnzTHXxpKlyqa+
         K7yBw6SarMcOOhY6Zz+zK3S+QhSp9SnB1cU+75G7AtmytWoAyQ7gAK1n/VDZ9NsMWFpv
         4LaA==
X-Received: by 10.68.194.202 with SMTP id hy10mr70719054pbc.94.1400788315499;
        Thu, 22 May 2014 12:51:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xz7sm3268921pac.3.2014.05.22.12.51.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 12:51:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249941>

Ronnie Sahlberg wrote:

> This version completes the work to convert all ref updates to use transactions.

Finally got through this.  It had thorny bits but generally goes in a
very good direction.  Thanks for a pleasant read.

Feel free to send another iteration if you'd like review for the newer
code.  I expect except for the part about renames that most of what's
left is just nits so it should go faster.

Thanks,
Jonathan
