From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 23:30:56 +0200
Message-ID: <op.wbwgpus00aolir@keputer>
References: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino> <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328204221.GE8982@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"James Pickens" <jepicken@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:31:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0SR-0007Qf-FA
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079Ab2C1VbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:31:01 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58030 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab2C1VbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:31:00 -0400
Received: by eekc41 with SMTP id c41so447688eek.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=IVPFj8pzBx3yWHPLRSr0xwH3AQcVZDJBNBN/QYmHq5Q=;
        b=BIb39vy3mfzouixL+WOmXbJpgEmUPmIClLJyrndi5cna4+hBW/n0YyGF3Sx39DyDVq
         3oz3WKZb06tGy94dwD2ndrpXpnciNgEmPBgrZIukFtb+gShiv7oMHDnIOMv74BjIdF0w
         T455nrvx6jph80oP5wkpxT22sJbuCO21TBvmmM0c1D8iGtoaODLsp2v8CIhjzeJf581K
         q+DLSK2+akEP/YgeS5rdIC/9TjNUAf8eaO58YvlPktUEUMRNtH2q5a61oAhgC3Iqxn8d
         0ZohqY1ZSBNe5yfa6hL1bwjVam47/EBXdSm+YxGCcKZUUcKGOfXZ0lINry011UMFxS1A
         XBVQ==
Received: by 10.14.53.8 with SMTP id f8mr4225736eec.102.1332970259371;
        Wed, 28 Mar 2012 14:30:59 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id p57sm14511043eei.8.2012.03.28.14.30.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 14:30:58 -0700 (PDT)
In-Reply-To: <20120328204221.GE8982@burratino>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194202>

On Wed, 28 Mar 2012 22:42:21 +0200, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> (cc-ing Frans who had a related itch if I remember correctly[1])

Thanks.

> [1]  
> http://thread.gmane.org/gmane.comp.version-control.git/189077/focus=189913

Reminds me that I need to get me some time to work on that again.

Frans
