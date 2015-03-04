From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] grep: correct help string for --exclude-standard
Date: Wed, 4 Mar 2015 18:13:32 +0700
Message-ID: <CACsJy8AW4=tsFLDcJb=is5UUdVyyFPD+AHi1v-xX=qCXLL_N2g@mail.gmail.com>
References: <1425045718-30696-1-git-send-email-pclouds@gmail.com> <20150304101606.GB15788@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT7Fi-0001jN-IS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbbCDLOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:14:06 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38076 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580AbbCDLOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 06:14:04 -0500
Received: by igbhl2 with SMTP id hl2so35636780igb.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q5RYwqwE5CVi3x9eIoSoH0vKcomsYTelL//reWnd5GY=;
        b=sBoCNX2aRAcVguWEyr/4CPm0vWf1bvlvAp77w/EivPmE5q1wZTVCBXHi2KTewDDGMR
         oOlLdY8mryujVFHs67ISRGtaApMfiUkaDkdkSjTWK0KeXhdW0QvgyAe7ufJp5UGLU7yW
         65QHTYuWFjuHhtz8qmNbOUT8lHxinnISwmkjeGhfP0VAPBIv7VgDdyfI3emH7kcrJdG9
         Rka4MxDgaSrhSGya5SfVbUtuyNDmQn3h0YZSJ7BDIStlunrvJL3iRQfZx3iZEOZSnlYT
         ql419WrO1RdlMN5I9kg1L1fjZES/TTaFxb8BaiJ2T9TKMo2yprFBtAYePD5bsnN3dMb1
         yOnA==
X-Received: by 10.107.35.140 with SMTP id j134mr10099672ioj.11.1425467642909;
 Wed, 04 Mar 2015 03:14:02 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 4 Mar 2015 03:13:32 -0800 (PST)
In-Reply-To: <20150304101606.GB15788@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264752>

On Wed, Mar 4, 2015 at 5:16 PM, Jeff King <peff@peff.net> wrote:
> Hmm. If the default is "--exclude-standard", then what expect people to
> use is "--no-exclude-standard". Would it make more sense to list that in
> the "-h" output?

I thought about it and actually edited git-grep man page to clarify
the default, only to find out this.  When --untracked is used,
--exclude-standard is the default. When --no-index is used,
--no-exclude-standard is the default. Can't have it both ways. This is
already mentioned with the subtle phrase "only useful with...".

> It might be nice if parseopt had a PARSE_OPT_NEGHELP option or something
> to show the "--no-" form.

Regardless, yes it would be nice to have something like this. I think
there are places that can make use of this.
-- 
Duy
