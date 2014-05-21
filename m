From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 29/44] refs.c: make lock_ref_sha1 static
Date: Tue, 20 May 2014 17:52:30 -0700
Message-ID: <20140521005230.GZ12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-30-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 21 02:52:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmulp-0001se-3H
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaEUAwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:52:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47045 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaEUAwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:52:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so835664pbb.5
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kGWzkw3jGPErjXuFpm3hsXJPHFlGsWWvegqRWxCUtUc=;
        b=EWXONwamCsgrqi6IN5x0UUaT0wVlzuEpWHozKhbyEojbKqhAbCdlbzLVgmMQdxlwhI
         gAQRtKfwrz7vklHJX1ECVkM9pQpDKY7vFTXX+J6m4MeCM4UkdwSt98BwjoY5bn31ERQ/
         o/8NAc3cE579hcoFZ3MlwCuXZn7jRzl8YEsIrvyXVN99NujpeAfdIraHPb9ai4NmeuzU
         KAV9uXglwpO0zhZX8d7AFUe/tYcfTAGATKVuHbcCnyPmVVPVtu7vWDKc/h3mIejhpg5Z
         1N0j2RYAnC0JB3t+Dx6dQB1KELP01EYImPjpFpvBaiFNmhqdIZHQVhLU7cSX4VFON4lI
         hzlg==
X-Received: by 10.68.186.130 with SMTP id fk2mr41050254pbc.60.1400633553084;
        Tue, 20 May 2014 17:52:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yx3sm5152136pbb.6.2014.05.20.17.52.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 17:52:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-30-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249770>

Ronnie Sahlberg wrote:

> No external callers reference lock_ref_sha1 any more so lets declare it static.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 2 +-
>  refs.h | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
