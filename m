From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 00:09:24 -0700
Message-ID: <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Henrik Austad" <henrikau@orakel.ntnu.no>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:10:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqjyy-0006j8-FF
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbYD2HJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbYD2HJo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:09:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:27214 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbYD2HJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:09:43 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1273403ywh.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vD1uTS0pPd/R7e9knzuQELirTjDuN0A8MO0A89IyZhU=;
        b=r7xENT+BTP280sbv1OiTKmFWBPnVQ9KgM6T7Xb5AZ1KSpfYFDqiW6sLWMFN8bxSVVv8pZKynzq0JjJkC38F06u86cs6KEgq56oH+hwbuaIiRrS6wEy6ummcvWcoD/wAZdIX9eTRzlk5SPaB9MaPw5bv6LCdb/WZkMEebZDIPNDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nzEQvJ0m4RiypDIZ3Gvl7MO8wKBwl7b27weUW0hwO7Qj7lK6bCZbxOoBb3uBKALrhosj5MwczXBZHh+te3LJZioDabPv/NVTFtaA0l6ruSqi4NI2wqkPIywONuNiG4xfkwz4cSTUbNQB2BeIVK4xfpistzEl4qETs8AgSBe43Lk=
Received: by 10.150.86.10 with SMTP id j10mr4728023ybb.202.1209452964959;
        Tue, 29 Apr 2008 00:09:24 -0700 (PDT)
Received: by 10.150.228.20 with HTTP; Tue, 29 Apr 2008 00:09:24 -0700 (PDT)
In-Reply-To: <4816C26D.9010304@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80659>

>  Colliding objects can never enter a repository. Git is lazy and will reuse the
>  already existing colliding object with the same name instead.
>

I think you are missing the point. One of the pluses behind originally
using SHA-1 and the signed tags is that the system as a whole is
cryptographically secure. You can verify from the public key of
whoever made the tag that yes, this really is the source and history
they tagged. Not only can DNS attacks be made, fooling users into
thinking that they are really connecting to kernel.org, or whatever
else server they expect to be connecting to, but also, the server
itself may be hacked and objects replaced.

I'm just not sure how much time it would take to find a collision.
