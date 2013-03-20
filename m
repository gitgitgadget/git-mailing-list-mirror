From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t: don't redefine test_config() in various places
Date: Wed, 20 Mar 2013 11:40:21 -0700
Message-ID: <20130320184021.GN3655@google.com>
References: <7vk3p3jrrw.fsf@alter.siamese.dyndns.org>
 <1363767703-12936-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINwa-0001C4-HL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570Ab3CTSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:40:28 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:48261 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab3CTSk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:40:26 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so1145890dae.31
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OAhDf3PGjhlk6yc+yiZDAV20ucH1Yp3SK/AeIj1vEAI=;
        b=fIzMMDZ3+SMksi0G3ewQmWHzGrtLIktdGdTrJsgie7MpCL9Aqp7RTL5E2IWyyODgyW
         tlQ4OCl8474MiwBOva1vOP6HLcr0t5XM8MHweWDhewUbJ3jL8EQesxmVQ0RCyVqnL+3m
         0sb9uX+XINJmRtxMtg8tsqe+Qc32Uk80qgtD5kmc+aRiB2CiJJOeGgjMmv5iSMtvVLwo
         WofqsXx2w/4U8EKZLEk0HoymjCQglj23z1RP50UecdMcC4GUseRTQdhtDywT0Kx4nX2w
         eNwlzDi80Z0mBiGNKJou5BLOLf0sIOgB0R3DBzp4R6rSlDTlHqPhaNmErSfUeee53/PT
         EbAw==
X-Received: by 10.66.121.133 with SMTP id lk5mr10670166pab.171.1363804825925;
        Wed, 20 Mar 2013 11:40:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id dl1sm2982603pbc.17.2013.03.20.11.40.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:40:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363767703-12936-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218648>

Ramkumar Ramachandra wrote:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Thanks, Junio.
>
>  t/t4018-diff-funcname.sh | 5 -----
>  t/t7810-grep.sh          | 5 -----
>  t/t7811-grep-open.sh     | 5 -----
>  3 files changed, 15 deletions(-)

Yeah, that looks like all of them.  FWIW,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
