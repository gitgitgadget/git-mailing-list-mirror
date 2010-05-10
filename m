From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Help with a possibly corrupt repo
Date: Tue, 11 May 2010 00:17:20 +0400
Message-ID: <20100510201720.GH14069@dpotapov.dyndns.org>
References: <AANLkTiks5g7BvLXBrUcb0m5dCiIrBifjDUKBDScXd1dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Leto <jaleto@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 22:17:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBZPu-0005f3-Kh
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 22:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab0EJURZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 16:17:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62974 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab0EJURY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 16:17:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so945357fgg.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=m195pr/9nnIaAMB3ATr3PeQS3Ok4s3wwiOSKx3fOPpY=;
        b=TiMVxoi1V9e+MQaDRdjSqqnoah1uP7zbK+9PJUT+1JSCQRjzFY1c1CNMGp1ILoi7Z2
         w2rV6Tsz9Lx8DMFwWvWgh4CjTrwJDKzcbwOfDAEBjbCrF423kiivqidXqI7DdzMpO8jU
         OH6X2wIaSUgDNpRAaL/ScYRZi2SpTyK07mrZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IRFUzDUViedfDCP7Nsh8GOmDCXVYTuVdYmnQn/78V6f03M3m/RlAVxMpgP4JSuyGiU
         tkoUB3EyqUpV6tNZgfCpLffGYzLnc6rDcEjYTwTK8952kTkDJc0o65n6XpRpzFwdvcnf
         qiKrwjj+a4CoqXReRfEIeNJVJdZIxc3svrCvM=
Received: by 10.223.144.79 with SMTP id y15mr5063666fau.22.1273522642686;
        Mon, 10 May 2010 13:17:22 -0700 (PDT)
Received: from localhost (ppp85-140-167-246.pppoe.mtu-net.ru [85.140.167.246])
        by mx.google.com with ESMTPS id 2sm23045809faf.3.2010.05.10.13.17.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 13:17:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiks5g7BvLXBrUcb0m5dCiIrBifjDUKBDScXd1dw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146849>

On Mon, May 10, 2010 at 12:37:36PM -0700, Jonathan Leto wrote:
> Due to a network (or possibly disk) error, I started getting this error:
> 
> $ git --version
> git version 1.7.1.166.gf2086
> error: garbage at end of loose object '66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba'

The object is "loose", so it should be a file:

.git/objects/66/fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba

it would be interesting to look at it to see what is wrong...


Dmitry
