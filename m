From: Thomas Koch <thomas@koch.ro>
Subject: Re: [Request] Git export with hardlinks
Date: Sun, 10 Feb 2013 11:33:26 +0100
Message-ID: <201302101133.28746.thomas@koch.ro>
References: <201302061619.07765.thomas@koch.ro> <20130208095819.GA17220@sigill.intra.peff.net>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 11:33:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4UEO-0002vG-Kx
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 11:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab3BJKdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 05:33:33 -0500
Received: from koch.ro ([88.198.2.104]:57398 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab3BJKdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 05:33:32 -0500
Received: from 123-16.2-85.cust.bluewin.ch ([85.2.16.123] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1U4UDy-00034H-3H; Sun, 10 Feb 2013 11:33:30 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20130208095819.GA17220@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215899>

Jeff King:
> [...]
> So a full checkout is 24M. For the next deploy, we'll start by asking
> "cp" to duplicate the old, using hard links:

Hi Jeff,

thank you very much for your idea! It's good and simple. It just breaks down 
for the case when a large folder got renamed.

But I already hacked the basic layout of the algorithm and it's not 
complicated at all, I believe:

https://github.com/thkoch2001/git_export_hardlinks/blob/master/git_export_hardlinks.py

I had to interrupt work on this and could not yet finish and test it. But I 
thought you might be interested. Maybe something like this might one day be 
rewritten in C and become part of git core?

Regards,

Thomas Koch, http://www.koch.ro
