From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 37/44] refs.c: pass NULL as *flags to read_ref_full
Date: Wed, 21 May 2014 16:50:40 -0700
Message-ID: <20140521235040.GM12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-38-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:50:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnGHX-0006Rj-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 01:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbaEUXuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 19:50:44 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40575 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaEUXun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 19:50:43 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so1866749pde.0
        for <git@vger.kernel.org>; Wed, 21 May 2014 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3P/Pol2gbOrsJEL4MYXo5/vAzUb6gByaqjUNRcIlkOU=;
        b=K39fZPPhZSQYG3jCIYk5gse36pqMr5j6e+cpyDdlZ57mX4c5d9k6oWNruFdapsc6Hg
         VhEnmdGnm9uzJD1RWRS8BmmBmbjbodRnAqzQF2YtHDJ0jd6AoUwQeXaOBwcCFbnWpo0w
         Vi425hTN0NquB3f778nCVmf6PgGVbM6VsBzyRWD6Tl1KYIZqabAuqnEo5XB85ST4tINV
         EmwP+epWmNIwSX+mwV3zdRFFJq64/fULHfdJUja1NmYPdxHoSyLO8C+ogeIZZvn4bSqc
         IdyUOManNXwQ0BBlLnLeCHmRNxMkNKsUHLaHUcYVD24CJYN5+HNH3STcdjTHD2bHShSa
         mcuQ==
X-Received: by 10.66.150.228 with SMTP id ul4mr63536138pab.16.1400716243137;
        Wed, 21 May 2014 16:50:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vm3sm9921584pbc.45.2014.05.21.16.50.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 16:50:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-38-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249861>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
