From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] submodule: preserve all arguments exactly when
 recursing
Date: Wed, 3 Nov 2010 00:47:51 -0500
Message-ID: <20101103054751.GE10631@burratino>
References: <1288758882-77286-1-git-send-email-kevin@sb.org>
 <20101103043725.GA10311@burratino>
 <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDWCm-0005st-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab0KCFsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:48:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50258 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KCFsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 01:48:08 -0400
Received: by yxk8 with SMTP id 8so207877yxk.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8xVBdADr5aNbB+50uoyCcAwtpWCN3jhn/76etvMrEfc=;
        b=k3scUlbkQjyufMfDkla1SNxGbGUz/GKsuvT+8DNL/AIfFYmGW841E7X1grDXIku+xr
         xn8W+Vi9K3nUrbVjiAtXpvkDN1Xaj1AfX59wJLqRC7Cro3eAmy5LGI6rwh/10QeCm4pZ
         26Yj+CJ4pJ1crujLIOU+cHQkf07FqoQynOves=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DuUgUuYJMJtKyC8SeRJleeXrY1oQe0TUkDpDmGZQLkgyh7GCLvCLMy6s9Q8MApkYdb
         ounkN6CUVKhBM3tx0MVt2wjhlBIYF6qCwFfFRDHsKSiEi7PbNCsWNuzEOLaVcJpFo6C7
         jHQNgDR4DiLpFbgF7pzN8w0s0HdolMvAlBZWI=
Received: by 10.150.95.13 with SMTP id s13mr600701ybb.146.1288763288140;
        Tue, 02 Nov 2010 22:48:08 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id q18sm278607ybk.3.2010.11.02.22.48.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:48:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160585>

Kevin Ballard wrote:
> On Nov 2, 2010, at 9:37 PM, Jonathan Nieder wrote:

>> Have you looked into "git rev-parse --sq-quote"?
>
> Well crud, I wish I'd seen that before. Looks like it does pretty much the
> exact same thing as my quote_words function. I'll send out another patch
> that uses this instead of quote_words. Thanks for the info!

Incidentally, if you still remember where it might have been useful
to find this advertised (git-sh-setup?), maybe we can find a way to document
it better.

Thanks for the submodule fix.  Well spotted.
