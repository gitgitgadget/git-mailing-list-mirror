From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Wed, 13 Nov 2013 10:32:55 +0700
Message-ID: <CACsJy8CMrA9SkeHypQnTqOtigjb_NM3A3gyLPeD_KR_P5EBtdQ@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
 <CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com>
 <CAJc7Lbqaas0Czdvcfn8+iceoyxaVSHOaV9jCJsy4mWH+AbV41Q@mail.gmail.com>
 <CACsJy8AHjAgSFzZ2R2Nup=GcuQJdaedbGXhRpcCT6HuaaLUtaQ@mail.gmail.com> <CAGyf7-GO1x5xCN-W_K+mvYU2-HdF1Gxu15wwZW7uiGWfdZfybw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 04:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgRCs-0007J8-UO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 04:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab3KMDd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 22:33:27 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:59805 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867Ab3KMDd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 22:33:26 -0500
Received: by mail-qc0-f176.google.com with SMTP id s19so5752858qcw.21
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 19:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=enBTeVPDGEAaMjINUrbZ0UY6tRyocwNAH0oQwm162S8=;
        b=yDE3RuBbMDefML0Hc5ktuJw71FulH6t1kvLp9jKp4bno0nU0bUjcufGg3Uc29xAlYW
         EkrVJ1YeawnVb6y84yTz6GHFQaC9Y2xoZh6gAdyRiMoMly5Tm1sAAzuI6lbMM2UbP1az
         LZvOMXxyM9Dx/uWcInaLXscH78az+lrFyZt4qXd06xYXID2yACkySalNL8mUbYZEFWPJ
         lWL3Bnve7dXfdkV1tN6cWAQVbsIFTsiHVt43RqFYxW2GKJUnfJLuzCakDwNDD/wOBKHm
         sv2it5+Vsij+rBo4N0kzwE/qLien+IG2jSFaKID38ezjNO+dbQVv0anptxjiMxni1Bqn
         RZTA==
X-Received: by 10.229.244.69 with SMTP id lp5mr62091777qcb.14.1384313605643;
 Tue, 12 Nov 2013 19:33:25 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 12 Nov 2013 19:32:55 -0800 (PST)
In-Reply-To: <CAGyf7-GO1x5xCN-W_K+mvYU2-HdF1Gxu15wwZW7uiGWfdZfybw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237772>

On Wed, Nov 13, 2013 at 10:04 AM, Bryan Turner <bturner@atlassian.com> wrote:
>> but it's only available in v1.5.0-rc0 or rc1. Could you try that
>> version?
>
> I believe you mean 1.8.5-rc0 or 1.8.5-rc1, is that correct?

Yes. Looks like my fingers are not controlled by my mind anymore.
-- 
Duy
