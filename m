From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Change checkout remotely.
Date: Mon, 08 Sep 2008 17:47:19 +0200
Message-ID: <48C54907.4040408@gnu.org>
References: <f5cc88f60809080842l34760997r4b821a79e7727d91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcello Henrique <faraohh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:59:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcj9L-0000XN-PY
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbYIHP62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 11:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYIHP62
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:58:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbYIHP61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 11:58:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1523306fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=N0DSZ/KW9Yi5tRAoxlKFMkL+vjAooBVbpFGnRqF69ys=;
        b=naJO2a11vJK4K7MzWeNRKZBUrt/y9kZBSnbZGdahGhS/tYcxJFcPr+dy10qfI8PyiG
         LC/yKOgyVicQ/1S93CtaDOIIboh1dB+nIAI19VOG9jOQPYym0w9YlqA05CqJu4DSas+9
         nX1buo7i9ov1tLEvRxGdc7mTpcqW2aJ8EXZ8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=TN+6J+k5gQ+2sVYWpC2O7xBiG8mVDFKB3L8A3KBTYlpX0K3jEj0jH4Ww2hLofjeIEx
         WuFCggQAqhVDNu/riPHoSUCygJ+tYJTD7UCdjbAODM9sARXTKfdpJGyP37jGEmz0OdnE
         uy35hse1FIZsm38FWoeFLSvS5MpDACnJzLlDs=
Received: by 10.86.70.3 with SMTP id s3mr11433385fga.51.1220888841204;
        Mon, 08 Sep 2008 08:47:21 -0700 (PDT)
Received: from scientist-2.lan ( [89.96.108.150])
        by mx.google.com with ESMTPS id l19sm4686651fgb.7.2008.09.08.08.47.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 08:47:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <f5cc88f60809080842l34760997r4b821a79e7727d91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95267>

Marcello Henrique wrote:
> Hello,
> 
> Is it possible change checkout another work tree remotely and refresh all files?
> 
> For example: git remote other checkout other-branch-x

Yes, either

   git checkout origin/other-branch

or if you want to work on your own local branch, starting from the
remote tree:

   git checkout -b my-branch origin/other-branch

and "git pull" (or "git pull --rebase") when you want to synchronize
with upstream.

Paolo
