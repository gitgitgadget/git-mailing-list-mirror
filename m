From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Tue, 17 Jun 2008 15:53:27 +0200
Message-ID: <4857C1D7.2020702@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806161843.09372.jnareb@gmail.com> <4856DFE8.9010809@gmail.com> <200806170034.42621.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 15:55:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8bdf-0003xH-N3
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 15:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751AbYFQNxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759071AbYFQNxY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 09:53:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:40229 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759029AbYFQNxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 09:53:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3549953fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=IvEWygyrMSIAyXg2DVi1HSLqCVOt+kTnK0fqwZcnmlk=;
        b=J4aVEFBRaTpeHWElbK2peBNLt+emKE6Cfo3B5lW4KOSrsuB/CjLiUaLzQx++UManjt
         Oloz1hM4MiXUhY1eSM1zN+tuEIm/sQledA8P7634T9LJcrx16QhdYVOJmlCnRfE6uTe/
         tBpQg0d9EeF6eir8XgWUFzzilstAxTbotTtzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=Xphl7EKRsjhN1UV35ZLPWk2F4vD/sgV70m2VDMm30mfWexO+EQxystDM/RV52P9ymc
         pYII5xgIgXzZHdWshLbvpu17k49hz5hS0msyI8r0iLfY+jDih2yz2MA4Q98i2RYdI+Ak
         6R0v11n+iMJba3zj06IrG95v4xsF0GEGIFf8Y=
Received: by 10.78.179.3 with SMTP id b3mr3089680huf.80.1213710801638;
        Tue, 17 Jun 2008 06:53:21 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id 23sm10713164hud.52.2008.06.17.06.53.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 06:53:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806170034.42621.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85297>

Jakub Narebski wrote:
> I have thought that Git.pm API together with catching (and examining)
> Error, perhaps with redirecting STDERR somewhere (but it would be best
> if it would not be needed) would be enough.

(Just to clarify, I'm not touching Git.pm with my current work; I'm 
adding a few Git::* modules instead, and they work differently from 
Git.pm.  So there's no Error, and there won't be any STDERR to catch at 
all.)

-- Lea
