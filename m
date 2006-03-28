From: "Tony Luck" <tony.luck@intel.com>
Subject: Re: Problem with git bisect between 2.6.15 and 2.6.16
Date: Mon, 27 Mar 2006 16:22:33 -0800
Message-ID: <12c511ca0603271622n6e4614b2s6f936469863efd9d@mail.gmail.com>
References: <BAYC1-PASMTP036F0DBE8F7101BCAD5470AED30@CEZ.ICE>
	 <0e7e01c651fc$e30a2860$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 02:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1z7-0006yF-CD
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWC1AWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWC1AWf
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:22:35 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:5548 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751165AbWC1AWe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 19:22:34 -0500
Received: by zproxy.gmail.com with SMTP id m22so1497887nzf
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 16:22:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IyjDsedU/QVJrZLleFlTqF2skUqphKehS0i1bl1fEtkpbVJe3dMvl9/lsiD/l0XGvIxzdWbFunbYqLylowe6bUsDap0Eoeu7ucllwwpHbypfik3gjqsq/251VkYGzuvnJgzh58CsOuesVDZtZX+A2g8ftFgCIqjwTv2ETpxlvkM=
Received: by 10.65.176.8 with SMTP id d8mr2913198qbp;
        Mon, 27 Mar 2006 16:22:33 -0800 (PST)
Received: by 10.64.27.14 with HTTP; Mon, 27 Mar 2006 16:22:33 -0800 (PST)
To: "Greg Lee" <glee@casabyte.com>
In-Reply-To: <0e7e01c651fc$e30a2860$a100a8c0@casabyte.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18096>

> No, the problem was fixed in 2.6.16 and I'm trying to figure out what fixed it so that I
> can back-port the fix into a previous kernel version, so 2.6.16 is good and 2.6.15 is bad.

You'll need to invert "good" and bad" for this.  I.e. mark 2.6.15 as
good, 2.6.16 as bad, and
then as you test mark kernels with the bug as good, and ones without
as bad.  Try not to go
insane while working in this inverted parallel universe :-)

-Tony
