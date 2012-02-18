From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: SIGPIPE handling (Re: [PATCH v3 0/3])
Date: Sat, 18 Feb 2012 04:10:20 -0600
Message-ID: <20120218101020.GA9054@burratino>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
 <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
 <20120218005148.GA1940@sigill.intra.peff.net>
 <7v8vk0r481.fsf@alter.siamese.dyndns.org>
 <20120218085221.GA13922@sigill.intra.peff.net>
 <20120218100517.GA8998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jehan Bing <jehan@orb.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 18 11:10:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyhFl-000166-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 11:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab2BRKKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 05:10:49 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62598 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2BRKKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 05:10:48 -0500
Received: by iacb35 with SMTP id b35so5436086iac.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 02:10:48 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.208.4 as permitted sender) client-ip=10.50.208.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.208.4 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.208.4])
        by 10.50.208.4 with SMTP id ma4mr2476450igc.4.1329559848461 (num_hops = 1);
        Sat, 18 Feb 2012 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6A+8m/KhYrjljBI3LmX8ps/nS1K1k35gWPRr0G1MTI8=;
        b=KZkcLhkNIhTx8yWMAfmhRQPJr1mQcPx+VCTKqqnwiS7gdflWef1fndRT+LWNG5hIOX
         IgfKNQrEcDQjXfv6TUQxoKWaGtzOx+xaFEpKXTrqx3xSTxnSCADUONSXAqviuZXLEcl1
         QxcsT2XuPc/FKct/1siunZprrxG/7xUJmKl1w=
Received: by 10.50.208.4 with SMTP id ma4mr2009303igc.4.1329559848406;
        Sat, 18 Feb 2012 02:10:48 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f8sm19161000ibl.6.2012.02.18.02.10.47
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 02:10:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120218100517.GA8998@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191002>

Jonathan Nieder wrote:

> There's a subtlety I'm glossing over here, which is that for commands
> that produce a lot of output (think: "git fetch --all"), output may
> still not the primary goal.

Gah.  The output that goes to the terminal may not be the primary
goal, I mean (missing "be").

Sorry for the noise.
Jonathan
