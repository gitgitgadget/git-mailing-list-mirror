From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Changing Spell checker under GIT
Date: Thu, 17 Jan 2013 12:17:11 -0800
Message-ID: <20130117201711.GB13449@google.com>
References: <189327E1D7E3B64286ED8625AAEC642C08633B01@MDHQEXCH01.enginsol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Mike Hall <mikehall@enginsol.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:17:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvvuA-00034n-Se
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 21:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3AQURU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 15:17:20 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:45607 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab3AQURU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 15:17:20 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1669609pad.25
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 12:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5Ja9AQFYeE0B6G6Gvs32rXZtOiUiI0A0lDKLND9nuqw=;
        b=mvDS9m0ErEHa6DmTUlUKmll8a9DsrIXk+JDgo05XlzRBF9wCvouf8Yi0aooGZS7XxW
         KbMkrrapTiel4znzy7r13/W35xHKBOCuAio4sPQuB2Yyjd0ygkLp8AuCJFJTWQNednFy
         UyfXOOKJP/GHdCTPRyp0iBrJykEd8rORlqxl2hpM5j9T5nUWwa8pA420mPbyqwwM/GpJ
         R2vC2cfPi08RMWmBrVAWHHNyZ5bqrGiDFtl1rwqMuKSJwSDTs4A9Yh077SrqgNnL8RlS
         VRsUPpVxQgykk30I3FaRRELwi0f7xlIFKuTS1Y4mtSwtnPaFpj553bb6LUItqLN2Sv3t
         y3kw==
X-Received: by 10.66.80.162 with SMTP id s2mr16663362pax.61.1358453839689;
        Thu, 17 Jan 2013 12:17:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id oc8sm447877pbb.39.2013.01.17.12.17.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jan 2013 12:17:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <189327E1D7E3B64286ED8625AAEC642C08633B01@MDHQEXCH01.enginsol.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213874>

Hi Mike,

Mike Hall wrote:

> As my organization has change from RedHat 5 to RedHat 6 Linux,
> it appears that RedHat is trying to replace (deprecate) ispell/aspell
> with a different tool (hunspell).
>
> It appears that GIT GUI current supports changing the dictionary used
> to support spell checks.   Is there currently a way to change the
> spell check program to be used(can't find in documentation or version
> of code that I'm currently installing), or would someone consider this
> as a future program change?

git-gui uses the aspell command as a spellchecker.  A patch to add
hunspell support sounds like it would be a nice addition.  If you'd
like to work on it, then "lib/spellcheck.tcl" in

  git://repo.or.cz/git-gui

might be a good place to start.

Hope that helps,
Jonathan
