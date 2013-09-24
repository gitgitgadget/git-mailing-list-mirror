From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] sample pre-commit hook: Use --bool when retrieving
 config var
Date: Tue, 24 Sep 2013 12:22:59 -0700
Message-ID: <20130924192259.GN9464@google.com>
References: <1380009176-10490-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 21:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOYCT-0005MW-As
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 21:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab3IXTXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 15:23:05 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:57552 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab3IXTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 15:23:03 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so4972142pbc.4
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+Zorrfcu6AbioYeT0tr8CBTePT9TdHHhtWKXr+Y6Xnk=;
        b=DFt0cnIYg+PNV7wPwOmivQHqH+IxwfYgAQo1FnYkmaTh9JbXZF4uszuq9G9zb6mbZ3
         mC3jtSf/9PdOPT/JwTA2JRWms09NDuti+yB3FWBbRVXHtqkcPNvi3L+Ml0za1LOs4vvu
         dx0PvvkUP5XVtZ+5ijzwxV5yNvEc1DLRUh9KQJ04rf+fAgQyRBp/xMgV5vvVVjO/0Qg0
         xrX9q+cR1uQTk7B8bVjiWrveluhT6cIZNjVsWdyWZ13bjKDKMZsmuDRNB7dqWDddc0i8
         RgKK8YMDgBxKL545vgQXy6aoWU4AtFQL9XkymRHW03IkwpnMk3CIOpoRxXBWDvctc9dS
         nDvQ==
X-Received: by 10.66.154.1 with SMTP id vk1mr30098259pab.85.1380050582946;
        Tue, 24 Sep 2013 12:23:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ct4sm42605000pbb.41.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 12:23:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380009176-10490-1-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235309>

Johan Herland wrote:

> Signed-off-by: Johan Herland <johan@herland.net>

Thanks.

What symptoms does this alleviate?  Is this to allow configurations like

	[hooks]
		allowNonAscii = 1

and

	[hooks]
		allowNonAscii
		
to do the expected thing, or is it something more subtle than that?

Curious,
Jonathan
