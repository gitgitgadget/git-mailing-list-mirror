From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git objects
Date: Thu, 24 Dec 2015 15:34:33 -0800
Message-ID: <CAJo=hJt9c6gr9AuapR7yUSYchF8=67AYQp-06XrTudbfa2ipkA@mail.gmail.com>
References: <CACnwZYfMKG18ZTR3bCLY5FRsBYmSsC9Co2e=iLRYxsM=w=Dqog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 00:35:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCFQ3-0007Y9-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 25 Dec 2015 00:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbbLXXey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 18:34:54 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35742 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbLXXey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 18:34:54 -0500
Received: by mail-vk0-f52.google.com with SMTP id k1so25267347vkb.2
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 15:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L3rPjMI9Yn36+b5H6UQ7wQHl+lElaZitteyDDaGZoN0=;
        b=Keh9CRUVdhKltoGuEYsOucSw9+URwn5nYHRhguyq33yofh9FAuqLe++0KbHphjCtPZ
         KrAT+NK0g6GzwovpzZpMjbSwtU8wAu/yV9WFYBNLY2rnHt+Iz/1swBMCXPb4qHemrg5r
         y68Lmuj9QrP741iuWPJ12N3yWEpfiZHG5j0fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=L3rPjMI9Yn36+b5H6UQ7wQHl+lElaZitteyDDaGZoN0=;
        b=mBgHTrls+4U6F385fPGoHztX69uc2ElihUJL/bnOL86e3XT9E+bbUN0AU5xfKVEtc2
         tZUtHGt1LWY4DuzXCZCK/L0XsPKy32sPZa2A89y3hN/t/6Qk4WaCdK7aw6rCDnHkZ0L+
         uQLh5tBcKxo7TVq3Cf7n6I8M4SI6NmHraCAwrj3HCqMU1lMvg0dy1gX7npWc7F3l5pJB
         Quk6uPqLtihzNQm9017D3U4/94w/Ch0se9E6VdFwkGUU/3M6KVHvzvhCQlnd88bISA2j
         /ZXBTxVPic4nIaOS8WjTn4hMinADjzE37yXxtjcC+MOlBMXMA/Xi6f8GjT/zy5SjRcA6
         VpXQ==
X-Gm-Message-State: ALoCoQm1g0xfC1wK0h8O0MFTzGkDTDgczpALSqm2sPZ9sPLmKLOvpZ7qtBBVRh7BNdV58QDVDt6H9A0I3gbkmJiBrzqTo4bdvA==
X-Received: by 10.31.150.23 with SMTP id y23mr25139366vkd.87.1451000093091;
 Thu, 24 Dec 2015 15:34:53 -0800 (PST)
Received: by 10.103.97.65 with HTTP; Thu, 24 Dec 2015 15:34:33 -0800 (PST)
In-Reply-To: <CACnwZYfMKG18ZTR3bCLY5FRsBYmSsC9Co2e=iLRYxsM=w=Dqog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282987>

On Thu, Dec 24, 2015 at 2:17 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>
> When ever I make a commit (assume I'm changing a single file) and do a
> 'git push origin master', git says 'Counting objects: 6, done.'
>
> Does git makes 6 objects everytime? What are those objects?

1 commit object;
1 blob object for the new file revision;
1 tree object for the top level directory;
3 tree objects for intermediate paths
= 6

So your single file is some path like "src/main/lib/foo.c".
