From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 29/41] refs.c: remove the update_ref_write function
Date: Wed, 28 May 2014 13:39:04 -0700
Message-ID: <20140528203904.GZ12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-30-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 22:39:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpkd2-0003pd-1b
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 22:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbaE1UjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 16:39:11 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60081 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaE1UjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 16:39:08 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so11803380pbb.39
        for <git@vger.kernel.org>; Wed, 28 May 2014 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UMmpvoMDb8Itk6S3Wh1Lcp72NK231nizqL5zFnXfBOA=;
        b=rFzSbLDxVMvlC3H7F+6/EdCZZ42YOsTxLqillk6C1ybv2H530mejCQAMQVlByLLUZW
         wEa/fO7cCmhUd9YLAEQI8HNBLIbhQA599H0sN8/E6T294QZk3wKm8VVRJq/zK3HWqVfw
         ZsUJc/NKUhcoQBy67vwQx3ve450o2R14BhA9jBnZjillK82RSHtHa0Odel3oN7YSHoSc
         /sLlkh7G/uSs1nVsw5UuDZYI8yORUzE9qXrdMMUGIPZMFEFC1iksAqPbLLrdgtEtkkWL
         4AuDt/Jda0KBi+1HEwSn61YlImnOgWOpovtINSBmd9HuIoycOJ9EeGnsbZU0NU+743Aq
         iCyg==
X-Received: by 10.68.237.133 with SMTP id vc5mr2780560pbc.92.1401309547245;
        Wed, 28 May 2014 13:39:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id io8sm29812100pbc.96.2014.05.28.13.39.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 13:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-30-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250326>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 35 +++++++++--------------------------
>  1 file changed, 9 insertions(+), 26 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
