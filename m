From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: re[2]: sparse checkout file with windows line endings doesn't work
Date: Fri, 20 Sep 2013 13:22:58 +0930
Organization: AI
Message-ID: <SDZYU1EwTCM8XlI0PVQvMjQyMDIzNzAz@IBMLT4>
References: <20130920033821.GD15101@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 05:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMrnz-0005Pk-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 05:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab3ITDyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 23:54:51 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49036 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab3ITDyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 23:54:50 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so211036pac.31
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 20:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :mime-version:organization:content-type:content-transfer-encoding;
        bh=LvJMMLPvE1jWKsXBPXgP4aB0SKupg5rk4wWxUJGBHZM=;
        b=iRgkdYrXScIBmO95HpW5JgtSmQ+3DZlFWgMZBnrUwuc9iY3YAIclvlt7XdADcMaGvn
         FcqV77OuAYmKNAIPE6a1tEbWR8li1sNSFPWnC4XZVeWvqvd+FwzTKji5zX/SRwNNiLBG
         ajJfJzIyqWYRMaaHqfDzp9ap3fA45hCM6eS+cy3Xt0sKgq5/BIp5OBivzY66HbY/N1+F
         VWsvPGqCpXrL9NEBETYN5J4vrfCKvfBMrMFkYtdviAbVYA84MgD0n8SzhhYI+aUl8VVF
         GFge+dc77XINES85lGQ8j1pazKhlw0i6nod+5vFdu5IjiCtzZTHj//RcdSE4q0eiuQCy
         7p1A==
X-Gm-Message-State: ALoCoQng0F4ITG9uUZcSGUtGouHB8zPKQ1Vg4KS3DV8PE9BfB8Y5mbCUy9+d60k+TAD9gtDOB5uV
X-Received: by 10.68.163.132 with SMTP id yi4mr537046pbb.160.1379649290426;
        Thu, 19 Sep 2013 20:54:50 -0700 (PDT)
Received: from IBMLT4 (ppp121-45-31-21.lns20.adl2.internode.on.net. [121.45.31.21])
        by mx.google.com with ESMTPSA id py4sm12754431pbc.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 20:54:49 -0700 (PDT)
In-Reply-To: <20130920033821.GD15101@sigill.intra.peff.net>
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235056>

>>  I don't mind a special option to turn this on for debugging, but the
>>  normal "-v" for read-tree is not "show me random noise", but rather
>>  "keep me occupied with a progress bar". If it were triggered by two or
>>  more "-v" options (which could also contain other debugging output), I'd
>>  be more sympathetic.

Right totally - sorry, I'm not familiar with what -v would normally do (! I better get!)

My suggestion is more along the lines of "it would be really helpful to have a really
verbose debugging option for sparsecheckout (be that read-tree or something else),
because it can be quite hard to work out why it's not working the way you expect'.

Regards,

Martin
