From: Chris Angelico <rosuav@gmail.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 15:07:08 +1100
Message-ID: <CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
	<CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
	<20140320233816.GC7774@sigill.intra.peff.net>
	<CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
	<20140321034334.GA29683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQqjk-0007Mt-H8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 05:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbaCUEHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 00:07:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49632 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaCUEHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 00:07:09 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so1876618pad.17
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 21:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7c5CSs2n3Mh+93tlHzpSbACC3HHTvBaNulRELkAhUcw=;
        b=nfOZjVYUEFlAHjFxEMvs2IUhRJUy1Cpyu/hLXZWuJKjs98TX4WOX538OvrElwAy18v
         9OVQzs9ufhPeusNodX8BgsCB66ij8+S1tQxfRawQ3jQs8lSVzBdL5A3GsxsP+cyUoF9b
         1e8ghmPbs8jwOz7riGURVHIv7o0ww/bCPj99OKj0aRiVa5+4wnQHAc6jdrU4O4zdut3P
         qxNzSFNUpUCFjkYW059Nv+Gc2yu5DwaQNUavgGbUKeePuWkHJcdHG8BAxZdWkgZUFWjG
         KqQ6R6of819ilwQxZxBhTyD7IuVsLM5A+fO8SZ4aCbJ4tHlS1heWOYf0Q1P6x3xeeubK
         OIPw==
X-Received: by 10.66.164.229 with SMTP id yt5mr52106033pab.67.1395374828848;
 Thu, 20 Mar 2014 21:07:08 -0700 (PDT)
Received: by 10.68.33.7 with HTTP; Thu, 20 Mar 2014 21:07:08 -0700 (PDT)
In-Reply-To: <20140321034334.GA29683@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244636>

On Fri, Mar 21, 2014 at 2:43 PM, Jeff King <peff@peff.net> wrote:
> Thanks, the new text looks good to me. Please follow SubmittingPatches
> (notably, you need to sign-off your work, and please send patches inline
> rather than as attachments).

Ah, didn't see that file.

>From 6e1fc126ece37c6201d0c16b76c6c87781f7b02b Mon Sep 17 00:00:00 2001
From: Chris Angelico <rosuav@gmail.com>
Date: Fri, 21 Mar 2014 10:45:08 +1100
Subject: [PATCH] Explain that third-party tools may create 'git config'
 variables

Signed-off-by: Chris Angelico <rosuav@gmail.com>
---
 Documentation/config.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73c8973..23f0466 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -131,8 +131,9 @@ Variables

 Note that this list is non-comprehensive and not necessarily complete.
 For command-specific variables, you will find a more detailed description
-in the appropriate manual page. You will find a description of non-core
-porcelain configuration variables in the respective porcelain documentation.
+in the appropriate manual page. Other git-related tools may define their own
+variables, which will be defined on their respective manual pages; ideally,
+these will be named in some way to indicate the project or creator.

 advice.*::
  These variables control various optional help messages designed to
-- 
1.7.10.4


Made that patch off master, which is currently basically the same as
maint anyway.

ChrisA
