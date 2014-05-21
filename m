From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 33/44] refs.c: remove lock_ref_sha1
Date: Wed, 21 May 2014 15:09:36 -0700
Message-ID: <20140521220936.GH12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-34-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:09:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEhj-0001ej-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbaEUWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:09:40 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46127 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbaEUWJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:09:39 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so1812867pbb.21
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FZcIQuYsiuGuUSlLrnv13SsoXFq9x8WGZvhKLYvPnic=;
        b=H06L0n8fdiK4382iJiVVrARSKGkgdVx8ywbE5tA2an+1pxeAZPlksQuMr+8hGCm9+1
         w01s4V+9eOhTFsKsmoPQSHme26EVKFCs9rXtUY7BVYa0rEly4rjBTCSdQFULl/YJlfgV
         /qKTlo08kNoVdpNp4lnFhbDgWU0VKixWbzQyI2XcxhAt2laiPKbUGzsOypws+n+ksUzm
         9yeQnXCsBjOUj9JL0tudAJ/295+raen57F27s02Ba0abVMYq+yYIReqUsD5WlI5qoh3h
         +qtzHMbmX0KVWEVjf8WzoFo0E8uurUtyCmpEa7Vc4B8NRHWj84f1CTpCOkgIB0NsfmVW
         d+Jg==
X-Received: by 10.68.197.134 with SMTP id iu6mr30374891pbc.164.1400710178578;
        Wed, 21 May 2014 15:09:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ek2sm9720628pbd.30.2014.05.21.15.09.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:09:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-34-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249847>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Heh. :)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
