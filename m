From: David Aguilar <davvid@gmail.com>
Subject: Re: change remote to track new branch
Date: Tue, 6 Aug 2013 19:40:32 -0700
Message-ID: <CAJDDKr5d=ifToosL2w5mJMyhiWwYK_eeuxEQTrDssVBe4P6JLA@mail.gmail.com>
References: <20130803024032.GA28666@analysisandsolutions.com>
	<m2d2pvp7nw.fsf@linux-m68k.org>
	<20130803162821.GA945@analysisandsolutions.com>
	<87iozmhgl1.fsf@igel.home>
	<20130803165215.GC945@analysisandsolutions.com>
	<20130807003053.GA7145@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 04:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6tgG-0006hN-8l
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 04:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab3HGCke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 22:40:34 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36785 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833Ab3HGCkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 22:40:33 -0400
Received: by mail-pd0-f175.google.com with SMTP id 5so894213pdd.6
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kr4bJlbV5gc7ji3aEBrNnZIGJBsHadgJWss/TM7bDg8=;
        b=o5pceWz4Dmuc766lgKG3/UUiStIHIgnXKH2IotRRCNghox0C17FZsgTOsK4oQuKwSI
         +ZXpZAXMKdIKEdAPAlWDLm57702NBA/x5edjbCYogFhN74szknDFkZ6VUzqj6jscDIZ2
         Es8ussNylt6d1C5K/dS3YVf6l+FYRGqeCRdmHc50K/HvhqUqBLUlaNfLqKYnDC1GVf76
         MQAsVR/v1UjcDQ5HBEe0VIgw36ki3NUE8cCNyRA7nteQZL+3i28uGg1au/G+uTjiqXmN
         Iw4BfNglu8uegFtC2Hh5IIZEGP8ly+BU0G7+FpYPLlQmxbU/UIbLeWbjE/XjeYDB/71Z
         9eHQ==
X-Received: by 10.68.36.38 with SMTP id n6mr1258820pbj.15.1375843232728; Tue,
 06 Aug 2013 19:40:32 -0700 (PDT)
Received: by 10.70.95.230 with HTTP; Tue, 6 Aug 2013 19:40:32 -0700 (PDT)
In-Reply-To: <20130807003053.GA7145@analysisandsolutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231803>

On Tue, Aug 6, 2013 at 5:30 PM, Daniel Convissor
<danielc@analysisandsolutions.com> wrote:
> Hi Folks:
>
> On Sat, Aug 03, 2013 at 12:52:15PM -0400, Daniel Convissor wrote:
>>
>> Yeah.  I had contemplated using the following commands:
>>
>>     git config remote.wp.fetch \
>>         "+refs/heads/3.6-branch:refs/remotes/wp/3.6-branch"
>>     git config branch.wp.merge "refs/heads/3.6-branch"
>>
>> So is "git remote set-branches" and "git branch --set-upstream-to" just
>> another syntax for making those same changes to git config?  Or do the
>> new commands do some additional work on the repository (to better keep
>> track of things, or whatever)?
>
> Sorry to be a pest, but I'm curious what the answer is, please.

There's really nothing more to it.

There is one other setting -- "branch.wp.remote" should be set to "wp".

If you edit your .git/config by hand you'll see what's really going
on.  It's quite simple under the hood.
-- 
David
