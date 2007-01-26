From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 10:39:10 +0100
Message-ID: <38b2ab8a0701260139w25d3e6c7ka8a0097f247f8421@mail.gmail.com>
References: <20070125173954.GA13276@spearce.org>
	 <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
	 <7v7ivaailb.fsf@assigned-by-dhcp.cox.net>
	 <20070125214923.GD13874@spearce.org>
	 <Pine.LNX.4.64.0701251830400.3021@xanadu.home>
	 <7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
	 <38b2ab8a0701260052q517285e8l2505114a48d34558@mail.gmail.com>
	 <7vlkjq17sm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:39:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANYD-0005K2-7W
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbXAZJjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXAZJjN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:39:13 -0500
Received: from hu-out-0506.google.com ([72.14.214.235]:18952 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161002AbXAZJjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:39:12 -0500
Received: by hu-out-0506.google.com with SMTP id 36so624238hui
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 01:39:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ksW0ORGgezOv70LwfSHjOW74jIeECwAqF+DxOklKUZzifcF8hQhxqO86nHR03yF0Z3rYP9Z4gLw89y17ybEvmZqrpMphKUvzRLIRDHRF2fe9Ie9SyuD1m3G9GiYuY0cfaaEKOeivnWjQBl8CktEuxs24pVIwee7s+0H5brs7KEs=
Received: by 10.49.19.5 with SMTP id w5mr2934376nfi.1169804350648;
        Fri, 26 Jan 2007 01:39:10 -0800 (PST)
Received: by 10.49.30.4 with HTTP; Fri, 26 Jan 2007 01:39:10 -0800 (PST)
In-Reply-To: <7vlkjq17sm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37824>

On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
> There is no fundamental change between 1.4.4 series and the
> upcoming 1.5.0 -- only superficial ones.  I do not think it

But there are incompatibilities.

Another example, which may be a bad one since I unfortunately don't
have time to follow closely git's development: the internal of 'git
pull' has completely changed. If I clone a repo with git v1.4.x and I
pull in this repo with git v1.5.x, does it still works ?

thanks
-- 
Francis
