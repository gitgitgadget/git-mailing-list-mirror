From: Mathew Benson <mathew.benson@gmail.com>
Subject: Re: Help using git I'm review process
Date: Sun, 24 Jul 2011 10:32:27 -0500
Message-ID: <01E430F0-0FDC-4FBD-9973-0E5B437FACEC@gmail.com>
References: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com> <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com> <4E2C2E15.8010602@web.de>
Mime-Version: 1.0 (iPhone Mail 8C148)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Adam <thomas@xteddy.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 24 17:36:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql0ii-0001Wh-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 17:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab1GXPcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 11:32:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63763 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1GXPcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 11:32:41 -0400
Received: by iyb12 with SMTP id 12so3627597iyb.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=kSrG5Ighurp8lyrzTQC/Lr+jXt5GQBchMsBBnOtxMOc=;
        b=Kp4LwTReuU9VM02uGEw0rhIgEd2qhGH8sWRDzLycKEgDDxOYqUohCRt7+xLYodKarX
         UTzvJrqrfL73gi2Vfyl69Cbe0vdPu16WFNiNKLVgJBw7Dnt6v2q3yoTwmGir4MeTjHKl
         Sk4YsbpaZBif606KBtIlF9jgQxdsOpOGn36cA=
Received: by 10.231.67.18 with SMTP id p18mr3788912ibi.48.1311521560863;
        Sun, 24 Jul 2011 08:32:40 -0700 (PDT)
Received: from [10.24.138.87] (mobile-166-137-139-033.mycingular.net [166.137.139.33])
        by mx.google.com with ESMTPS id 3sm2640394ibm.10.2011.07.24.08.32.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 08:32:40 -0700 (PDT)
In-Reply-To: <4E2C2E15.8010602@web.de>
X-Mailer: iPhone Mail (8C148)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177764>

Great.  That confirms what I thought.  Thanks.


On Jul 24, 2011, at 9:37 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:

> Am 24.07.2011 14:16, schrieb Thomas Adam:
>> On 24 July 2011 13:12, Mathew Benson <mathew.benson@gmail.com> wrote:
>>> I'm planning to use git for a work project, which requires tight control of the peer review process.  In previous jobs, the peer review was a tedious manual process of creating PDF files, writing comments in spreadsheets, and copying comments to the CM system.  I want to use technology to my best advantage.
>>> 
>>> Once a developer has completed all his changes in his development branch, what's the best way to get those files to the reviewers, without requiring the author to stop work?  First, I think I should create a tag in the developer branch.  Each developer has a local repository, and my review tool writes files directly in the work area.  Can they just fetch, checkout a tag (don't know how to do that), commit changes, and push it back to the central repository?  Is there a better workflow?--
>> 
>> This is what Gerrit is useful for.
> 
> Yes, Gerrit is a very sophisticated way to do that.
> 
> But you can also achieve a review process by just using git and email
> too: Have each developer do each topic of his work on a separate feature
> branch and send merge requests (e.g. per email) to the reviewer when he
> is done. If the reviewer approves the changes, he merges that branch
> (and deletes the remote topic branch, as that topic is now finished and
> part of the history). If not, he requests improvements from the developer
> who updates that branch and sends another review request when he is done.
> We use this approach successfully at my dayjob.
