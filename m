From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: file named - on git commit
Date: Mon, 4 Feb 2013 11:32:48 -0800
Message-ID: <20130204193248.GB15552@google.com>
References: <51065540.1090007@renemoser.net>
 <87txq11sbk.fsf@pctrast.inf.ethz.ch>
 <20130128204140.GA7759@google.com>
 <7v8v742cwh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Rene Moser <mail@renemoser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 20:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Rn3-0001Q5-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 20:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab3BDTcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 14:32:55 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:63937 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab3BDTcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 14:32:54 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so2820968dak.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 11:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EgbxkxezVYnCWnXWHp+2f+JfrTxaTOtznnZ4kegAdNc=;
        b=SNVImwRVLwqU/Wgz61b9P+vPhseO5+o2A/lq4zIdTl7CStLA0m/sVJ2mPD0YYFuzOk
         0ZRpcAW2w/HhkniXVPIuURCufIy1FJM4VLwueacHprdGG6IVqoMXUI3IOX+3o/ap/rLR
         MukFyAbooK0352QRHma7vGMk7pMWeIWIQELntePKWGJLOanYdRX695hXxqTUH3FRwGNH
         pB7a4axHRz/Aq/vZX0QhcLkhnTSh1msn1p0vZJXUOIB/K1WzVavL/yDW/M5dTG1V+wm6
         NyleSMm974+uikwS4q7hLNNqlkPyOGz5ixmBgEvFoCCYA/sWDZcZip9K29JWgB5XeEod
         dh1A==
X-Received: by 10.66.72.226 with SMTP id g2mr55532866pav.67.1360006374051;
        Mon, 04 Feb 2013 11:32:54 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id x2sm23576118paw.8.2013.02.04.11.32.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 11:32:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8v742cwh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215410>

Junio C Hamano wrote:

>            (some may be too minor to be worth backproting, for
> example).

Yes, this is the part I was asking for help with.  Backporting is easy
but convincing the release team and upgrade-averse sysadmins to like
the result generally isn't.  Occasional nominations of the form "this
change is important in my workflow" could help.

Continuing to stick to fixes to very severe bugs that stand out plus a
random assortment of problems people have reported can also work fine,
though.

Thanks,
Jonathan
