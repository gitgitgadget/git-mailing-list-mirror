From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 15:14:29 +0700
Message-ID: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: zhifeng hu <zf@ancientrocklab.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 09:15:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlwkb-0000y5-Um
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab3K1IPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 03:15:01 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:36694 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3K1IPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 03:15:00 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so455995qac.13
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 00:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RehKWRGEMvr1qaq6R9BfHtWymOro1hvnkr1gN46fivs=;
        b=Yn9z3eEVZNCwPSlQm1Z9U8gOoQCtVtH2OqboFCH8CKrk9d+3Av9y3QU8Ktk/Lvo6fU
         Sno639kR6o46TbPcvR4fxdWdTMdEBegyaVG4yqmIQJlHGlKI7StPN3fDX9W+SqckglTA
         ZR9Zb+s3CQ5YBG2yGDJQ5WV3Dhk3oYmwOj4hKIZCeLgpC43NY2Rv4sK2z/sE7/Ufrp8W
         7Br/tiOoThiYFVKic6t87tHCtXgwzZyruIrcPhf8eMJItNBUPLvcs5mNBWkOVZnGVco7
         rQMaYRg/UlLtEcLk4JEM8x003QBYFGD015qJ8yjXcmwZM2u9gZaXHmqT1+QUdgLTR5+9
         M8YQ==
X-Received: by 10.49.105.138 with SMTP id gm10mr44127324qeb.7.1385626499795;
 Thu, 28 Nov 2013 00:14:59 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 28 Nov 2013 00:14:29 -0800 (PST)
In-Reply-To: <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238476>

On Thu, Nov 28, 2013 at 2:41 PM, zhifeng hu <zf@ancientrocklab.com> wrote:
> Thanks for reply, But I am developer, I want to clone full repository, I need to view code since very early.

if it works with --depth =1, you can incrementally run "fetch
--depth=N" with N larger and larger.

But it may be easier to ask kernel.org admin, or any dev with a public
web server, to provide you a git bundle you can download via http.
Then you can fetch on top.
-- 
Duy
