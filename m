From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 2/2] Remove dead code after direct graph drawing
Date: Sat, 21 Oct 2006 08:35:46 +0200
Message-ID: <e5bfff550610202335rcb83ea8mf7ec2dd79ec6dd90@mail.gmail.com>
References: <200610191613.19142.Josef.Weidendorfer@gmx.de>
	 <200610200111.26259.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 08:37:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbAUK-0006a8-O6
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 08:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWJUGhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 02:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWJUGhi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 02:37:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:23730 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751746AbWJUGhi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 02:37:38 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k9L6bOxn001499
	for <git@vger.kernel.org>; Sat, 21 Oct 2006 06:37:37 GMT
Received: by py-out-1112.google.com with SMTP id z74so119867pyg
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 23:35:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=epT8MLPy+0Ojy7NwPiNjhM2kQ6OzV3sd/oeUxnIDvagXxb689q3Me8AwmAm0TsHmcqLhs6c0ONwHlvmTibVNfMj0gWCK/EGzN/CbMS2mcqAEyEuHowXckuILzRYitP2D6cSgHL2wsDhFttXrgqu1QoZtrkubO1GoDi1OzINtZFI=
Received: by 10.35.119.8 with SMTP id w8mr2124887pym;
        Fri, 20 Oct 2006 23:35:46 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Fri, 20 Oct 2006 23:35:46 -0700 (PDT)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610200111.26259.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/2060/Fri Oct 20 19:45:33 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29586>

Josef,

 I think ther's a leak somewhere.

Checking memory use with ksysguard is see memory use going up
scrolling up and down also on the same revisions list view subset.

I'm not sure it depends on your patch though.

Marco
