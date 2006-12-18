X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] make git a bit less cryptic on fetch errors
Date: Mon, 18 Dec 2006 23:22:05 +0000
Message-ID: <200612182322.15703.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0612181505320.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 23:27:17 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RbGjMccQKbxgUoL0ZO9y1stTtC46RvoJrcQIQGcr9JIBvOb7KszO0OGvfMfyVenyE10dZA6lHM/lraDVwmZhHcHXOyD5Eg8D2avGP8d7e/fPPrQbc10ed5xUE0IFpKgwdlE5KRL4x1aQj2eNSzgZejDWFlcRF37i/lx3+W+IRiE=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612181505320.18171@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34760>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRr2-0004Ss-04 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754758AbWLRXZE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 18:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbWLRXZE
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:25:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:10390 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1754758AbWLRXZD (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 18:25:03 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1638983uga for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 15:25:01 -0800 (PST)
Received: by 10.66.216.1 with SMTP id o1mr5994040ugg.1166484301303; Mon, 18
 Dec 2006 15:25:01 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id m1sm9877116uge.2006.12.18.15.25.00; Mon, 18 Dec
 2006 15:25:00 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006, December 18 20:16, Nicolas Pitre wrote:
> -			die("unexpected EOF");
> +			die("for some reason the remote end hung up unexpectedly");

If we don't know the reason; then saying this makes it sound like we just 
couldn't be bothered to write the message.  How about just:

"The remote end hung up unexpectedly"

?

Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
