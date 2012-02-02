From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to tell when git release changes porcelain stdout/stderr
Date: Thu, 2 Feb 2012 13:11:00 -0600
Message-ID: <20120202191100.GA19859@burratino>
References: <jgeert$qeg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt248-0004QI-KA
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208Ab2BBTLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:11:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42845 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933175Ab2BBTLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:11:23 -0500
Received: by iacb35 with SMTP id b35so3516473iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yfa88cXa2i+U3rBD3EAjdqKn9yHyrlMXCAVrhhYNSCM=;
        b=nb1x+FUhH3aRxRp0s+Rm4ixE/MQF9EDgIJLmp/pagBqwvqSbqNCUUDcXFlRyp8mlA0
         aQwPXqzOu7Z+iDBtgBzTvJ3J2qTE9IGgFReZu9SDkdFYi1DiJz80jXV8dcdIz0hRDrmk
         7H0Hm8Wer7mSILimahgLrqhQQUAuwgM1etIMo=
Received: by 10.43.47.135 with SMTP id us7mr3750885icb.31.1328209882813;
        Thu, 02 Feb 2012 11:11:22 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bj3sm1064226igb.4.2012.02.02.11.11.21
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 11:11:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <jgeert$qeg$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189675>

Hi Neal,

Neal Kreitzinger wrote:

> What is the best way for me (a git user) to tell when a new git release 
> changes the stdout/stderr formatting of a porcelain command?

They almost always do.  Maybe that will be happening less often as
messages get translated, but if you really need reproducible output,
your life will be much easier if you just use plumbing instead (and
please report problems when they arise).
