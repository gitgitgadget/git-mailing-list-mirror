X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Mon, 11 Dec 2006 00:02:05 +0100
Message-ID: <200612110002.05847.jnareb@gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <200612101801.58247.jnareb@gmail.com> <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 23:00:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LtdgRlFcVDxtbEALVPQpguyOroL/nV1lKLhpEVDtZtP3fK3PMHUW072MOr1TokP3jwYWAXtOx5rhnIYP57Z2rOUVjaWU/iycx/oAru62AnlYOTS+xnDPgvWOuZ6RoMksCrBQoj6Ce5GFtLHnxsynRN5ZLXb4C2AHoI3AKVDP69s=
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33953>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXeJ-0005BI-Su for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762367AbWLJW7r (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762375AbWLJW7r
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:59:47 -0500
Received: from hu-out-0506.google.com ([72.14.214.239]:37968 "EHLO
 hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762391AbWLJW7q (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:59:46 -0500
Received: by hu-out-0506.google.com with SMTP id 36so751695hui for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:59:45 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr8932019ugh.1165791584558; Sun, 10
 Dec 2006 14:59:44 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id s1sm4875837uge.2006.12.10.14.59.43; Sun, 10 Dec
 2006 14:59:43 -0800 (PST)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:
> On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:

>> The git commands StGit uses to perform operations automatically record
>> changes in branches in reflog. What StGit does not provide is the "reason".
>> You do use git-update-ref?
> 
> Yes, only for updating HEAD. The refs in refs/patches/<branch>/ are
> written directly. I initialy wanted to add patch history support using
> reflogs and added "git-update-ref -m ..." for the patch commits but I
> found slow the pushing operation a bit. Do you only want to track the
> reflogs for HEAD?

Yes, I want for StGit to provide reasons when updating HEAD. I know that
StGit manages it's own versioning of patches not using reflog -- fine.
What matters for me is reflog for HEAD after "stg commit; stg clean".

-- 
Jakub Narebski
