From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Wed, 4 Apr 2012 15:20:05 -0500
Message-ID: <20120404202005.GC17544@burratino>
References: <20120403144505.GE15589@burratino>
 <4F7B650C.9060800@sohovfx.com>
 <20120403210815.GB19858@burratino>
 <20120403211219.GC19858@burratino>
 <4F7B69FE.9010600@sohovfx.com>
 <20120403212650.GD19858@burratino>
 <4F7B839D.2020808@sohovfx.com>
 <20120404181148.GB16993@burratino>
 <4F7C9FAE.5050806@sohovfx.com>
 <20120404201610.GB17544@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:20:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWgs-0005k4-I3
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab2DDUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:20:15 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37543 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab2DDUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 16:20:11 -0400
Received: by gghe5 with SMTP id e5so425140ggh.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eyF/04FKKC/zBVL8m9fclMh859SFQWQVHv9dg7GWU+U=;
        b=KpWsdLECAzhVGwnINXwTLsC2Hc0jcfPeHyQi+AdmlbzpkjCnhV/8vxoDmr9oVnwms7
         4jttguxb/j875MBg2FY+v8csFnHUX9V3otwTpwDAv1B+VDeiSHrjgh3CCjmIg3PaRngm
         4K1qernbeofIV1wMoypdLTwqoX+ZWapEpZGDQC5UQyQwQcSf0nQC7aGVsRt7OtgO4Uje
         /1JEXaiywDdca8Q4PyTk4U+ZS7hEbjBcR2njgrF+IkcmVKcejhS9Nsv/s1hy5CismXny
         lLcCiCuywCB4zAqGVpOd5+1qMLIpfP0dqTLrjpe8q5uiRdHtYNjMgthUW5erqRKRghqn
         v5Ug==
Received: by 10.50.94.227 with SMTP id df3mr3335533igb.22.1333570811076;
        Wed, 04 Apr 2012 13:20:11 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ke7sm4444207igc.10.2012.04.04.13.20.09
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 13:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120404201610.GB17544@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194735>

Jonathan Nieder wrote:

>  - when "git cherry-pick" performs a merge and encounters conflicts,
>    it prints a message and exits, writing CHERRY_PICK_HEAD to tell
>    the operator what command to use (instead of "git commit" or
>    "git cherry-pick --continue") when the problem is resolved.

The above paragraph doesn't make any sense.  I meant:

	When cherry-pick encounters conflicts, it prints a message
	telling the operator what command to use (namely "git commit"
	or "git cherry-pick --continue") once the problem is resolved
	and writes CHERRY_PICK_HEAD to make that command work.

Sorry for the noise.

>    If my script sets GIT_CHERRY_PICK_HELP, it will print a different
>    message and cherry-pick does not write CHERRY_PICK_HEAD because
>    the operator is going to run "myscript --resume" instead of
>    "git commit" or "git cherry-pick --continue" when the problem is
>    resolved.

Jonathan
