From: Mathew Benson <mathew.benson@gmail.com>
Subject: Re: Help using git I'm review process
Date: Sun, 24 Jul 2011 07:42:55 -0500
Message-ID: <A5291838-E8F4-47DA-A3E7-E6CBFE7664C9@gmail.com>
References: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com> <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com>
Mime-Version: 1.0 (iPad Mail 8J2)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 14:43:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qky20-00043T-O9
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 14:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab1GXMm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 08:42:59 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63653 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab1GXMm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 08:42:57 -0400
Received: by qwk3 with SMTP id 3so1704236qwk.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=N61l8SeJKNU70kBsw1C36+wSx6C7EwkPxFejxJqZxDE=;
        b=op3wPRZJX4K9Kz8QWwthPuNCJ6lQPqrautyKbZjlL8oojixd+7J3of7RqTnSjMi/BQ
         eggd0s2hakOJ04LZ5i5wM4u13RNLC3+gu1Mp9MMFeyGJmVX5fIx9myTufpUk2beu5hLd
         6BrsTebHHkog8TpjQ4An5qZRkAFMIkHvHjrkw=
Received: by 10.224.216.138 with SMTP id hi10mr2622408qab.251.1311511376784;
        Sun, 24 Jul 2011 05:42:56 -0700 (PDT)
Received: from [192.168.1.102] (user-0cdvj2d.cable.mindspring.com [24.223.204.77])
        by mx.google.com with ESMTPS id u12sm2868506qct.27.2011.07.24.05.42.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 05:42:55 -0700 (PDT)
In-Reply-To: <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com>
X-Mailer: iPad Mail (8J2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177741>

I found that in my research but my IT "department" recommended a tool they're already using.  I'll push Gerrit again.  Is there an online demo?

Sent from my iPad

On Jul 24, 2011, at 7:16 AM, Thomas Adam <thomas@xteddy.org> wrote:

> On 24 July 2011 13:12, Mathew Benson <mathew.benson@gmail.com> wrote:
>> I'm planning to use git for a work project, which requires tight control of the peer review process.  In previous jobs, the peer review was a tedious manual process of creating PDF files, writing comments in spreadsheets, and copying comments to the CM system.  I want to use technology to my best advantage.
>> 
>> Once a developer has completed all his changes in his development branch, what's the best way to get those files to the reviewers, without requiring the author to stop work?  First, I think I should create a tag in the developer branch.  Each developer has a local repository, and my review tool writes files directly in the work area.  Can they just fetch, checkout a tag (don't know how to do that), commit changes, and push it back to the central repository?  Is there a better workflow?--
> 
> This is what Gerrit is useful for.
> 
> -- Thomas Adam
