From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Thu, 28 Mar 2013 18:33:11 +0530
Message-ID: <CALkWK0nCWUknZGuwGd7ewTqt4YvC1KqeC-wLsQ8asHmCQAUCEw@mail.gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com> <20130322144454.GA3083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCUr-0002iy-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab3C1NDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:03:33 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54745 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab3C1NDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:03:32 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so11302280ief.7
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DtyPviyR2uwBLeqHXJaWTVCmUzZ8AeVAqODpCaDt6Ag=;
        b=SN0FRE8Ql/vbi3rNc+y7r7Yawbadsaptx+wIHzHpijKvcXP5QP166elzM/Mz96Kwj7
         ndpzGJOPivd9S2ilzGVww4UmQA2LkENT7W/o7xrCyLEaOSwev0zGa5U4eCcXbnn47VlQ
         hey+qhPcKfsOm0MZI8EIVDJWpP56K4rMEfAsV47eYoUC1+T0gkkmeT9t0FDgZSEXU6Cr
         gT4S1cnR7sXmng6drsrELqAvExpHCf/jLAJ/PQSWLGXx0J2R42xNmcBs+gSyeSpggE3y
         PBPeVwx7le+IgObzTLulQ7A3h1damblDZ6+0CW4kKJp5Qu9lZrLKQjw5H+v3mCbHCb0m
         AsYQ==
X-Received: by 10.50.108.235 with SMTP id hn11mr6850552igb.107.1364475812469;
 Thu, 28 Mar 2013 06:03:32 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 28 Mar 2013 06:03:11 -0700 (PDT)
In-Reply-To: <20130322144454.GA3083@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219385>

Jeff King wrote:
> Subject: [PATCH] t5516: drop implicit arguments from helper functions

Thanks a lot for this!  I just had to s/ $repo_name/ "$repo_name"/ to
fix the quoting.

Will post a re-roll soon.
