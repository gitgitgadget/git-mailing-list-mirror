From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 28 Apr 2014 12:44:49 -0700
Message-ID: <20140428194449.GM9218@google.com>
References: <1398713704-15428-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com, gitster@pobox.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerU6-0005tO-4Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbaD1Tox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:44:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40840 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbaD1Tow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:44:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so6155597pab.40
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZSmWukJiYzc/5fKKvbNkEGO9KfzUWoxqLbGV3eaDkus=;
        b=wyz7KctXY951gMf8GEW8qEbx7sQachTp75aPQBsrJmFjXjceKFXpL48tFHJJuvf8IH
         ay73FlHmue9h0kM72VKmj5H01bgV8kdYFMsKYkrggoGcRIf9tTaE6nKASVHcR5SsuvU2
         FcGVb4qp/e/p0cIv+cHwiGKbACPhdAmoncmwGCUlYgJ81UoZMeiltoDvBqTjwy5mxgpG
         k1wChn1VSQQJCUYRcxLk9JI7f9SOis6iCJEiEYWic+ySf36o9ZUOvl/IMkoCXx86d1B+
         KJUQGFox0IWk9q1xrVpKkgQs5k0frdhvJOviNNkjIpk9a7g2JslI/OoF1tNE+WBCZAWa
         gnSA==
X-Received: by 10.68.189.232 with SMTP id gl8mr27550837pbc.89.1398714292117;
        Mon, 28 Apr 2014 12:44:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kn10sm36755052pbd.60.2014.04.28.12.44.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:44:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398713704-15428-1-git-send-email-dborowitz@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247420>

Hi,

Dave Borowitz wrote:

> curl-config is usually installed alongside a curl distribution, and
> its purpose is to provide flags for building against libcurl, so use
> it instead of guessing flags and dependent libraries.

The previous version of these two patches is already part of "master".
Could you make an incremental patch?

Sorry for the fuss,
Jonathan
