From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Tue, 26 Jul 2011 20:03:01 +0700
Message-ID: <CACsJy8C822Fvwav4Wpw4e-12ZY20XM1s2v4KymZkaDYLxkMHvw@mail.gmail.com>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net> <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net> <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
 <20110726060903.GA29486@sigill.intra.peff.net> <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 26 15:04:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlhJU-0002Ku-04
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 15:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab1GZNEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 09:04:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33605 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1GZNEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 09:04:37 -0400
Received: by ewy4 with SMTP id 4so394553ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G1FN4ZpHHpb5ufHzGp/hfBhL9hbHALbQ2arI4qkxp3w=;
        b=bBTVj8D4JAXilqaRiuYsxX9uxAQjocPcM94Osd95w3YS8yYgyHJpnx/ofRv73Ryw64
         VeGDxQRSAIjJS87K1N8BdFfCYd4osVmgvfqxizLYj8HE9fbkuFLG8PHgmyrZinZZpcdV
         0/wIrIGcyk00hmKT6UTZNK+IoyjxLF8Ki8qys=
Received: by 10.204.145.19 with SMTP id b19mr1146584bkv.192.1311685412181;
 Tue, 26 Jul 2011 06:03:32 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Tue, 26 Jul 2011 06:03:01 -0700 (PDT)
In-Reply-To: <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177865>

It would be even more cool if --hunks (or whatever the name will be)
could work without -p. I mean, if "git diff" supports it, then I can
fine tune my regex to meet a selection of hunks I want, and verify it
really is what I want. Then "git add --hunks=magic" and voila! (The
"git add --hunks" without -p surely can be workaround by adding "-p",
then accept all hunks).

And if diff machinery learns this, we would have "git log --hunks" too.

OK I'm asking too much..
-- 
Duy
