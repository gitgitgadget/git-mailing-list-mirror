From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 22:52:01 +0100
Message-ID: <200704172252.03622.andyparkins@gmail.com>
References: <200704171041.46176.andyparkins@gmail.com> <alpine.LFD.0.98.0704171708360.4504@xanadu.home> <Pine.LNX.4.63.0704171352280.1696@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: David Lang <david.lang@digitalinsight.com>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 23:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdvbI-0000Ll-IB
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031260AbXDQVwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031237AbXDQVwT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:52:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:24312 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031260AbXDQVwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:52:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so278803uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 14:52:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uYTlNDSl33+3tIebwEoqq1DMT2ebcO+tOu/nZlBwFnqL+XAA1SuelZqZ3iJdEycKkzutp2fr/feEEFpYyVRicbc+Xji14ml1/990Z5K+hzEKjRJ3NxEjBfNCZu3wHXpW6+DVsh+bFKc2ah1+zAJOAEBApkz5CrWkbRqjW14dKFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RyIFp7mUwHySdkc1ydg+Ee72tKx8rnfhSjlm2G/9r1OPgeN5a6mdm6kn2z9SaRPfIt49kkW70IDxKKL/yd22c/j7E/x0FfqAzYfPLOkOOn8I1jmxcsy//tcVaYp1tCEqtWCcAZiZz1bil/OIpvDiSoh/9ml1HRPxEXrKG/YmDxM=
Received: by 10.67.32.19 with SMTP id k19mr485701ugj.1176846736553;
        Tue, 17 Apr 2007 14:52:16 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id x37sm1137664ugc.2007.04.17.14.52.14;
        Tue, 17 Apr 2007 14:52:15 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.63.0704171352280.1696@qynat.qvtvafvgr.pbz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44834>

On Tuesday 2007, April 17, David Lang wrote:

> I'm pretty sure that hooks for an external helper would satisfy Andy
> with his keyword expanstion as well.

It would.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
