From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP
 files.
Date: Mon, 30 Aug 2010 09:16:02 -0500
Message-ID: <20100830141602.GF2315@burratino>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
 <4C7B8E1E.6050708@drmicha.warpmail.net>
 <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5BN-0001Su-Ol
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab0H3ORx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:17:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37378 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab0H3ORw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:17:52 -0400
Received: by ewy23 with SMTP id 23so3186920ewy.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5Gn27aqlgv9dB6axK9dOdvvKVqACBcd3XOq8Xrrq8Xs=;
        b=BXznsDLLsuNoOg5Dajvgmim9D4ui+vMcK+UjwSygn/x41R+uy2NVZGCVbEY34dpHDB
         U+wTQiXrgl5nGwHvMWPQOfCtg5zrDrasywno/6zTI6MKbi1dCFFiEcT2YjVGuuY0k92C
         snqhwpLt6irH9H8cE9JP0WKaGDrtAGMzD5Y7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VVrC8jAwYt1ueVNsvBwWWB36dOK8WXieohWq7D4Uhd732t++hZQnLfq5Na8/kJJdEI
         oZaqWqViaWRjhb26I7oG7j7sLiZDXFiiQRLgbFZPZB02V71pTppb1RAd2bxvVTPS0h1I
         sjquz2P7+tFE1ZFneC/mhQG1KEUXn/dN6wX7M=
Received: by 10.216.12.139 with SMTP id 11mr5004958wez.63.1283177868003;
        Mon, 30 Aug 2010 07:17:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v16sm4472832weq.32.2010.08.30.07.17.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 07:17:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154809>

Chris Patti wrote:

> That's great, thanks!  That gets me the file names.  Now, how do I get
> to the contents of each file?

Why not "git diff --raw" (or its plumbing equivalent "git diff-tree")?
