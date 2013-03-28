From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] cat-file: Fix an gcc -Wuninitialized warning
Date: Thu, 28 Mar 2013 12:36:38 -0700
Message-ID: <20130328193638.GT28148@google.com>
References: <5151F4EB.80909@ramsay1.demon.co.uk>
 <20130326193539.GB28244@sigill.intra.peff.net>
 <5154908B.1040801@ramsay1.demon.co.uk>
 <20130328190226.GB17178@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULIdM-0005uw-G8
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab3C1Tgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 15:36:44 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59252 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab3C1Tgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 15:36:44 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so51190pab.7
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=X6qVXJ4GQxCMT0Bpk1FvxU9cLb4Re6aY20Ld/Lg24GU=;
        b=a/NADSRyTJ4NNuYwma9zx7sWaCbKtRdY/8DN166as/6T9R+C6xyX5M4eAemfJJCQyV
         CXFEC20rWUK667L3LWqGJq6D0wAQpQIEQ6dmUO3iXB+JBxafa320IHGpovyBEJXFDVwm
         3kC7fBigzqthaB9+jrVW+cahcC7bgI9jL5nP7HA7z+zvjwUOEXMQSdhmmLHmC0SQodcx
         N7WZpfyvIbj+5nFc9sBqiSbktT9/74kDRQF6VQq0AlbHvEf9htKL5f1aBabp/mCCB6Nn
         34JoZK5Upi7nA6NOx2SnKIR19nwrOnwfSEylPyKyfthqd5wFGZiTbXvhc+b1uS5xxJNO
         mF7Q==
X-Received: by 10.68.129.9 with SMTP id ns9mr37921176pbb.16.1364499403433;
        Thu, 28 Mar 2013 12:36:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 1sm26562380pba.32.2013.03.28.12.36.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 12:36:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130328190226.GB17178@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219452>

Jeff King wrote:

> When we can make the code more readable _and_ help the compiler, I think
> it is a no-brainer.

Yep. :)
