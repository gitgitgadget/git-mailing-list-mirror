From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 02/41] refs.c: ref_transaction_commit should not free
 the transaction
Date: Tue, 27 May 2014 16:20:20 -0700
Message-ID: <20140527232020.GG12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 01:20:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpQfW-0003YL-1a
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 01:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbaE0XUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 19:20:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45110 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbaE0XUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 19:20:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so9966317pab.33
        for <git@vger.kernel.org>; Tue, 27 May 2014 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RQjc61pD6KVpaBvcE44WeHYAnt+yeG0E7zCPyCb4UrI=;
        b=HA8JMKMo8lkHlE1VlCIUXJrXPy6Sv45cwcjSAKB6PHVrBTOszzcVnl77D2HhUX+E2z
         lm346PQ+o5C6a8injKU3GUPFD/Xw+evdl1dwBKlrBopGqB19lXiqYhdpDEokcD0O4IyL
         Z6h390kGo77x2ONWcVfnTFCRkoEJAS5WJUtpNbgihqnf0jWPkEkuklzIWztorXor6MOe
         A5MIT6HDlqxeKf9M9bSg03f0Tfil/ttGSAae44D4mOHKpfINmmiW08IZbvnIgzdPoWTs
         6Ab2k6s7EWmOVO7ucNvvgTe7/Si+S3deahttGF07XZs7LVOihlZ/VQYmFb32dr699cAc
         M62Q==
X-Received: by 10.66.122.6 with SMTP id lo6mr25804406pab.138.1401232823024;
        Tue, 27 May 2014 16:20:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vn13sm3618179pab.8.2014.05.27.16.20.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 16:20:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-3-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250248>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c | 1 +
>  refs.c               | 1 -
>  refs.h               | 5 ++---
>  3 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
