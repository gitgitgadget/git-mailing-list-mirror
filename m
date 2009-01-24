From: Chad Dombrova <chadrik@gmail.com>
Subject: Re: read-only working copies using links
Date: Sat, 24 Jan 2009 10:39:46 -0800
Message-ID: <AE9781AD-0B63-4AEE-9B62-20F9720B5DC4@gmail.com>
References: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com> <bd6139dc0901240302q6b3c9a13p56fe39a976882133@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Tim 'Mithro' Ansell" <tansell@google.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:41:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnRR-0002xJ-VT
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbZAXSju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZAXSjt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:39:49 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:30833 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbZAXSjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:39:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5237753rvb.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 10:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=H8YJRke61xzr8BJWCOt6PxOcfE5d/oQjDhZfKK3t23Q=;
        b=WHWkJJF43NqkBP+iR9IJtJ5YMnPL4DVUL9vtT3jfg8yrXCTBHNYDWiI4cAS7j3qR1y
         ur5v8ZA5aEIoLQz6kGJFrvEFokD/CuYSGIy2sGH31nwW3PUJldz22E9OQrOuU5nfoo7o
         mZEoLxblYK+XBqPlt+Bz6yNfn9pKjMkSRHHZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=ffI9o6i6R0mKvyd5q9aKBAl+yQ4CCbWq6zkIXzO4/y9bRUXkhhhEgTbcqoeL8jIHum
         3lULIn4ABLNJl/slohmDMmcr3Lp5mpYGeSRICupl0+WqRGAT/m8bNXzqI9WAQfIzjSyR
         g+uPnMzH0B56J8Y+LY1t5ZQH8qg5qbOMtqIN4=
Received: by 10.141.198.9 with SMTP id a9mr46301rvq.248.1232822388231;
        Sat, 24 Jan 2009 10:39:48 -0800 (PST)
Received: from ?10.0.1.100? (pool-71-106-182-59.lsanca.dsl-w.verizon.net [71.106.182.59])
        by mx.google.com with ESMTPS id f21sm25670324rvb.7.2009.01.24.10.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jan 2009 10:39:47 -0800 (PST)
In-Reply-To: <bd6139dc0901240302q6b3c9a13p56fe39a976882133@mail.gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106986>

>
> I think Tim Ansell (cced) was talking about this at the gittogether
> (storing the metadata seperately), as it would benefit sparse/narrow
> checkout, another advantage supporting his case?
>

what's the case against it, other than the obvious, that it will take  
more work?


-chad
