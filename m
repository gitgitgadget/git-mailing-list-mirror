From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Wed, 4 Apr 2012 13:11:48 -0500
Message-ID: <20120404181148.GB16993@burratino>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
 <20120403144505.GE15589@burratino>
 <4F7B650C.9060800@sohovfx.com>
 <20120403210815.GB19858@burratino>
 <20120403211219.GC19858@burratino>
 <4F7B69FE.9010600@sohovfx.com>
 <20120403212650.GD19858@burratino>
 <4F7B839D.2020808@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFUge-0007a4-Og
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 20:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab2DDSL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 14:11:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64575 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab2DDSL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 14:11:56 -0400
Received: by yhmm54 with SMTP id m54so339057yhm.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6oPMj1u59FsdHAJRndpIReAcLpZOqSdU3dXrkaraarU=;
        b=mwKZYiDdHXAwGfrks/OI+SxhxWW3F9DgP+ZrLm/1tD/9QeaA30I72cnz7/NwSM1yS6
         466FFKBgmFZqVCJKVUaL/iLklIquFhTpGsrLuBluBklswhKG4OaTMKMwfkAnCuK+r8gU
         mnxHiomFgC6C/cXfh9JKkuLhoElkwuQ5gEl7cVRswkEKzbHAi71w8ult/1gNVgjfDwhW
         3qEpEp9nedmml906isaSyARPSH2ym+HZDpk89XCMSCGlKGN9w0r4S0yiUuY+yon3WAZh
         /KFHEBREbDkhw2PziMVxIe4lwtqBi1c8tttBOHu8uYXDAG1D7XhvQiZdWUNWAqdd7Oxi
         pHsA==
Received: by 10.50.196.161 with SMTP id in1mr2546069igc.25.1333563115644;
        Wed, 04 Apr 2012 11:11:55 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mk10sm3620471igc.4.2012.04.04.11.11.53
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 11:11:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7B839D.2020808@sohovfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194717>

Andrew Wong wrote:

> CHERRY_PICK_HELP was introduced as a hack

Do you mean we should get rid of CHERRY_PICK_HELP?

Note that you don't have to convince me of anything --- I was just
trying to help by providing my reactions and some background.  If the
Right Thing to Do as revealed by list consensus or Junio's decree ;-)
involves keeping CHERRY_PICK_HELP difficult to use and fragile, I
won't mind much as long as rebase -i works, since I don't have any
private scripts that use CHERRY_PICK_HELP personally.

Sorry for the lack of clarity.
Jonathan
