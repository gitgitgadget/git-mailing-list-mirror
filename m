X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit: stg mail
Date: Tue, 12 Dec 2006 12:32:15 +0000
Message-ID: <tnxejr5wb00.fsf@arm.com>
References: <7ac1e90c0612120412i1297ce05uecbeea1107b8c704@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 12:32:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7ac1e90c0612120412i1297ce05uecbeea1107b8c704@mail.gmail.com> (Bahadir
 Balban's message of "Tue, 12 Dec 2006 12:12:36 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 12 Dec 2006 12:32:38.0546 (UTC) FILETIME=[9C044720:01C71DE9]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34089>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6o5-0000gZ-Cj for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751256AbWLLMcW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWLLMcW
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:32:22 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59553 "EHLO
 cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1751256AbWLLMcW (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12
 Dec 2006 07:32:22 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id kBCCWHYo017292;
 Tue, 12 Dec 2006 12:32:17 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Tue, 12 Dec 2006
 12:32:38 +0000
To: "Bahadir Balban" <bahadir.balban@gmail.com>
Sender: git-owner@vger.kernel.org

"Bahadir Balban" <bahadir.balban@gmail.com> wrote:
> I couldn't succeed in getting stg mail produce an mbox file with a
> Signed-off-by line (using stgit 0.11).
>
> stg mail -m --to=user@mail.com patchname > patchname.diff
>
> works OK. If I add the template with Signed-off-by I get:
>
> stg mail -m --to=user@mail.com -t ~/patch.tmpl patchname > patchname.diff
> stg mail: No "From" address

Your template is wrong since it doesn't have a "From:" line. You would
have to use the templates/patchmail.tmpl as a starting point.

BTW, I prefer to add the "signed-off-by" line in the patch description
rather than automatically (blindly) append it to every e-mailed patch.

-- 
