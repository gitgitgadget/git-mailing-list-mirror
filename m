From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on pathinfo-style project URLs
Date: Mon, 15 Dec 2008 00:55:38 +0100
Message-ID: <200812150055.40463.jnareb@gmail.com>
References: <1229195421.3943.8.camel@mattlaptop2.local> <1229217235.3360.13.camel@mattlaptop2.local> <200812150039.58797.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0pg-0006qJ-F9
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbYLNXzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYLNXzu
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:55:50 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:64546 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYLNXzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:55:49 -0500
Received: by ewy10 with SMTP id 10so2744005ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fv7/QjnsAsSdFr4WIKN3gB9iP5EKZectSFJJVngIwXk=;
        b=uzZFuE9mLQZz0AdcIrrlZBGLUfk63UZzRdlndciTEp9R06p6ENpQth8GRDNa1tK9W1
         EWj4NjeBkgQHt14o8LrfgvZpd3yLNN1Uh8olktkg2gI/htpdYPTXD6dVAVjZpm9ZMe+I
         3PRRqwuKIWmqC501R2tJzHSKZaHvK9+hnKiWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MhxABC/ci0zKeGooTqIeeaM4RMA6PEJnZJpygCso8t7rs8PXJYQpPg91Zk6J62tqCc
         Y48UE+FXbe1g9+7M1PxeteGB/P6WobyoW/FeZMyI6GhujWNkxDMKe60xZidpM61MCLu2
         6GILadv2KZETpyY4409pjRg4+KKphIu9EXdnw=
Received: by 10.210.54.17 with SMTP id c17mr3754587eba.14.1229298947914;
        Sun, 14 Dec 2008 15:55:47 -0800 (PST)
Received: from ?192.168.1.11? (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 3sm877680eyi.30.2008.12.14.15.55.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 15:55:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200812150039.58797.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103110>

Jakub Narebski wrote:
> On Sun, 14 Dec 2008, Matt McCutchen wrote:

> > I was thinking of proposing the addition of some info about my setup,
> > including the rewrite rules, to the documentation.  Maybe we could do
> > that after dealing with the patches.
> 
> Do you plan updating "Webserver configuration" section in 
> gitweb/README? 
> 
> BTW. could you please check if the $my_uri and $my_link need to be set
> in gitweb config for your configuration, or did some of Giuseppe's
> path_info improvements took care of that, and it is no longer needed?

It would be I think good idea to describe there _and_ in the commit
message why would you prefer for gitweb path_info links to be generated
with trailing slash; how it looks resolution for URL with and without
trailing slash. 

-- 
Jakub Narebski
Poland
