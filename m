Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B3C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhL2M0C convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 29 Dec 2021 07:26:02 -0500
Received: from mx3.uni-regensburg.de ([194.94.157.148]:36214 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbhL2M0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 07:26:01 -0500
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 930046000051
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 13:25:59 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 7AF55600004D
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 13:25:59 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 29 Dec 2021 13:26:00 +0100
Message-Id: <61CC53D5020000A10004692E@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Wed, 29 Dec 2021 13:25:57 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Antw: Q: warning: unable to rmdir 'submodule': Directory not
 empty
References: <61CC5390020000A10004692A@gwsmtp.uni-regensburg.de>
In-Reply-To: <61CC5390020000A10004692A@gwsmtp.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I should have mentioned: git 2.26.2 on SLES12 SP5

>>> Ulrich Windl schrieb am 29.12.2021 um 13:24 in Nachricht <61CC5390.C34 : 161 :
60728>:
> Hi!
> 
> I wonder whether you'd think this is a bug:
> When a branch uses a submodule (named "submodule" here), and when you 
> checkout another branch that does not (yet) have that submodule, I get an 
> error message saying:
> warning: unable to rmdir 'submodule': Directory not empty
> 
> Well obviously the directory is not empty. The point is: Is the user 
> expected to remove submodule directories manually before switching branches?
> 
> When I tried "git checkout master --recurse-submodules" instead, the 
> submodule directory was "mostly deleted", only leaving two object files that 
> weren't ".gitignore"d.
> (But the error message was the same)
> 
> Wouldn't a message like "... submodule directory contains untracked files; 
> won't delete those..." be better?
> 
> Regards,
> Ulrich
> 
> 




