From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Wed, 20 Mar 2013 11:32:55 -0700
Message-ID: <20130320183255.GL3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINpJ-0004dC-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3CTSdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:33:01 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:42784 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab3CTSdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:33:00 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so1583519pbc.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iHvrvzoh7gRkYDdb8lvWVnzey5C8LyCy9uZYi6P2s0g=;
        b=qK10os3N0ju4oPzg3f7mAJc4fBpjxIYLCRJ86kmUKXrijqEAGtkemy0EUc3RjWDJKb
         XR3m4f/yL3tG30qmTnDsueAGrJnvCKW8Wl0+hiWwJetF5HRy7cwbmwGB2y6eWy9W+pEr
         rT/q/ex57tqqgO7qMZ9EkR+IsB20gi4WHHJR1XQq4LuYrImqTtIPBMqKx4yXO3j4fNoP
         /uAffM4YY3QGWBI6/h3burHOyTqrm0QEhnPsKO9zZwCFTyzrCm2+BAJkPYGeZ4/J3hVZ
         fC9he5Z5uVTQjgHToSA/MQy93CdbLNunsgEVaIjy2SvTAWhCtPhNc8QNLzUh33h43KG7
         TTHA==
X-Received: by 10.68.212.233 with SMTP id nn9mr10485098pbc.144.1363804380078;
        Wed, 20 Mar 2013 11:33:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qd8sm2954426pbc.29.2013.03.20.11.32.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:32:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363783501-27981-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218642>

Ramkumar Ramachandra wrote:

> This new configuration variable defines the default remote to push to,
> and overrides `branch.<name>.remote` for all branches.

Micronit: I think this would be easier to explain if it came after
patch 6, since then you could say "In other words, it is a default for
branch.<name>.pushremote for all branches" and readers would not have
to wonder "Why does the more generic configuration override the more
specific one?".

My two cents,
Jonathan
