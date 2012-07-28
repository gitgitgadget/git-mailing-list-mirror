From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Make git-svn Use accessors for paths and urls
Date: Fri, 27 Jul 2012 22:10:43 -0500
Message-ID: <20120728030959.GA3020@burratino>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 05:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuxQq-0008G5-0Z
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 05:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab2G1DKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 23:10:52 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53909 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab2G1DKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 23:10:51 -0400
Received: by obbuo13 with SMTP id uo13so5220936obb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vy6giouKujAjQJrAQj++5dR+G33znvX2K/AO1Zssf2Q=;
        b=Rt/Zm67yy7iVY4PbcZrYadZWsW0m1dRZnifrgPRuSOjHmgJ1IM947L5dLUuRZ6NwAc
         x17Xj3Dplcqn6pRrSSHBzViMTOQs138K4hnx4VRhPd0X+JbVKwA6mI2+34Tko1IGF6Gi
         BUuB1g2q9wtMIEWIeT2Gt+HcfD242et6yTq/+FD13nFDmIkEnC2oTkexNBw33/rtkX14
         BrVzxrR9KhAXDGauIf7TvWaNbKPrp26uEjGFg65m8vM7ydNVOg6k2j6YC8K89qwl/v+a
         2Uh4OedPOhHjqKdILtdthXLWDCH1a38wTMm0Ahn+nI03a9kCSxwKHWo5j3+8X6MaIGyD
         yKaA==
Received: by 10.50.186.131 with SMTP id fk3mr6426705igc.31.1343445050621;
        Fri, 27 Jul 2012 20:10:50 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z8sm796769igi.5.2012.07.27.20.10.49
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 20:10:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343419252-9447-1-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202400>

Michael G. Schwern wrote:

> This is the last refactoring patch series.  After this bugs, start
> getting fixed.

I just wanted to say thanks for your thoughtful presentation of this
code.  I was worried before, but these have been pleasantly submitted.

If you have a chance at some point to offer advice, I'd love to add
the information to Documentation/SubmittingPatches that was missing.
Proposed text is ideal, but outline form or a list of missing aspects
and confusing existing coverage would be fine, too.

Jonathan
