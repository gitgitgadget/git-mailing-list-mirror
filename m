From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Sun, 3 Feb 2008 23:43:54 -0800
Message-ID: <402c10cd0802032343k60b78796ycdb36e2a74594a27@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	 <402c10cd0802032313la7d3a8cqa4ec34e100385fb4@mail.gmail.com>
	 <7vsl09kwjg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:44:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLw0T-0002WM-Rh
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbYBDHn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbYBDHn6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:43:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:20500 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbYBDHn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:43:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1918226fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YclOb4P6U8GcI8a+UXfQ0vWBasc9znfd8osMAfSYB8E=;
        b=IcDorxSL3aYstNkpiTPrAIVwUUz+mFAi5jILHNnQb7dtvam/nVvzTuWys/JhGA8XIwe2G64hoe1dXPf/j9vfZyApByth+S/joOUHHgrBLRgBQT9lg3Mo/l1eHvbTpuFu0HXVwb+jwqFtA2CELnVjN9m8NN9I2kWCoOYMQ7uVZ1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QgU9EpQd2deS84J4qxi1YGO6tfk6/bsjGxNwMeoVb5+b03BQmtV9fR5Qnm9npm3crFvDfLTCIvIeSPv0Po1MpmiW0RGYPPU1SVS2lFzquewO+L4bOJ+8YOmXZmBnF1OHO9T8T2NcH/fZtsKQ94VXY30pZ7d4/YcodzUFIjiziSk=
Received: by 10.82.134.12 with SMTP id h12mr12494442bud.29.1202111034269;
        Sun, 03 Feb 2008 23:43:54 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Sun, 3 Feb 2008 23:43:54 -0800 (PST)
In-Reply-To: <7vsl09kwjg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72472>

> Just add contrib/multi-pull/ directory and put your shell script
> there, something like: ...

Thanks will do.

> If it turns out to be useful for many people, it may become part
> of the main Porcelain.  It's too early to talk about touching
> git-pull at all.

I agree.

-- 
Sverre Hvammen Johansen
