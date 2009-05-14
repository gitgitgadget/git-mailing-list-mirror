From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Thu, 14 May 2009 22:58:17 +0300
Message-ID: <4A0C77D9.5050402@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <alpine.DEB.2.00.0905141441200.20117@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu May 14 21:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4h4m-0001kp-HU
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 21:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbZENT6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 15:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbZENT6a
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 15:58:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:52079 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZENT63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 15:58:29 -0400
Received: by ey-out-2122.google.com with SMTP id 9so461250eyd.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6vsOIXX5jtK9OT6N/3jY1eIjt6aFnmc6ElpbiG/jv60=;
        b=Xn50lnaIaQsjE8HHf+PG/M+PzMXkhzF+o/JmUL5NftOD3n3tphOZrUcDPE8rt+YzyE
         F3I7cqMZr/5N+cVhAKg1V79mgNwjK60mNRKjHl53SUyRCEJeb4eULdLo+wVI7hjGeedq
         40OyL/+jQ1wO62/TWGmS+mxigpWdg8LWtQ/5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nFbjgX8jS5+kijTqMh6PYz/T1fUx4xwS7iLsApKHuNBXINT3onD+Z2n8mHQd+M3BVZ
         RJfQwEP4qaJUrHeXbWzOu3gmA8UNLK/PDl3idDVcjMxmlbhxJgF1/V6t1CR1mtCuAOEH
         pQHcAmmPF3mUdNXrqXO3brD3zfOxA2j74NHMQ=
Received: by 10.210.51.18 with SMTP id y18mr3193056eby.8.1242331109674;
        Thu, 14 May 2009 12:58:29 -0700 (PDT)
Received: from ?10.0.0.2? ([88.195.117.100])
        by mx.google.com with ESMTPS id 28sm572756eyg.4.2009.05.14.12.58.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 12:58:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.2.00.0905141441200.20117@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119219>

Peter Krefting wrote on 14.5.2009 16:48:
> Is it really necessary to store the encoding for every single file name, 
> should it not be enough to just store encoding information for all file 
> names at once (i.e., for the object that contains the list of file names 
> and their associated blobs)?

What about if some disorganized project has people committing with many 
different encodings? Should we allow it, that a directory has the names 
of some files using one encoding, and the names of other files using 
another encoding? Or should we force the whole repository to use the 
same encoding?

> The best way would be to define this in the Git core once and for all, 
> and add support to it for all the platforms in the same go, instead of 
> trying to hack around the issue whenever it pops up on the various 
> platforms.

+1

-- 
Esko Luontola
www.orfjackal.net
