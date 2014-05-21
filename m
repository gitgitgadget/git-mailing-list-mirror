From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 31/44] refs.c: remove the update_ref_lock function
Date: Wed, 21 May 2014 15:01:34 -0700
Message-ID: <20140521220134.GF12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-32-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:01:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEa3-0006LD-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbaEUWBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:01:39 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48117 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbaEUWBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:01:37 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so1813001pbb.35
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Oj8tEIw/Wm7MkWKGL0zzRwjyIrK5JUPVEM9ztPiVEqg=;
        b=yCvx2x5wbQh4viFyB2lrCEX/pl3+N6vgtTB3xt5v/VlqJlJeW1M75jgVImNxLM5EJX
         IDa7vnu/3oGcDskN7QnlFUnYLHoH841Q0lgf6hJo9vG/1UwEKqOBVR8cS/NOFjF/GUmJ
         hmXiG7bFW1Tkho7Vk0101jQyXqXWMXSgpRKt7ea16OU4d5sos2Yo3xAu2j9TF+N4VWrq
         RaMI7SAgED9EU5RHgwD0vXz/O8NqArS/JlEfJcU1g43cM4AmYHN3XAGVuNb6WgYBp3ZE
         sMhu/0xwDV3GsEhPk8kmFirxnd+zfn+Mgs1mI1mDCKVScYstok7w0smTmQXTmlbvInlQ
         nVWQ==
X-Received: by 10.66.157.200 with SMTP id wo8mr61743146pab.92.1400709696897;
        Wed, 21 May 2014 15:01:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yw3sm9684769pbc.69.2014.05.21.15.01.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:01:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-32-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249844>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
