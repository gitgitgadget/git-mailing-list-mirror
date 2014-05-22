From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 22 May 2014 12:58:08 -0700
Message-ID: <20140522195808.GX12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnZ83-0000xE-T6
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbaEVT6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:58:12 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41966 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaEVT6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:58:11 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so2945547pab.17
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B9uRz85MuV2u6NA6iQwqQc/BzqD1zDlTWz1g5KbTHuc=;
        b=l+VCu2NoEbEzVQeDp+7aYla9UCaMLPUfJYw7CaxxgQ3iG/uS2ySHxuT1fNS+WVrbD0
         ZPYdqVULzpkWIlpJKZSr6hcfIN3J/ksWByRGVSlvdn8KhNRotGaXEhc0skf8CeoFk+Vc
         3R5lmTXTgJu+gpis7AGS/UkTb+MUc/LsBQUZbciTb375lsmBpcGMbDGZnbQ/HreHrvAB
         DnYQdhNOXxVb3hoHatioNDGUD1IWvemtMSRYBsRtvssyFBdAuCzbTHwmHPzPtLOmSlAL
         Szhj53t20Zj7SDpBsdghunSQdRwSEHMOBysNKJywNfpkGIp+albSqKBrVNuVBTcfNi+t
         X1yQ==
X-Received: by 10.68.237.228 with SMTP id vf4mr70228616pbc.131.1400788690798;
        Thu, 22 May 2014 12:58:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ov4sm974058pbc.46.2014.05.22.12.58.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 12:58:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249942>

Ronnie Sahlberg wrote:

> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions

Thoughts on 65a1cb7b (2014-05-22 12:08):

 01/40 remove ref_transaction_rollback
 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 02/40 constify the sha arguments for ref_transaction_create|delete|update
 still Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 03/40 allow passing NULL to ref_transaction_free
 The third paragraph ("This allows us to write code like") is still
 confusing.  Why not drop that paragraph?

 04/40 --- oh, lunch time.  Will pick up when I get back.

Thanks,
Jonathan
