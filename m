From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Tue, 06 Dec 2011 22:47:34 +0100
Message-ID: <op.v5275kev0aolir@keputer>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Chris Patti" <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2rX-0007pQ-Hj
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab1LFVrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:47:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45556 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab1LFVri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:47:38 -0500
Received: by eaak14 with SMTP id k14so5610852eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 13:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=cTKZsOnPEvdrUpjv/FBKaRNrRRZQw5j4fJVobNeoitk=;
        b=xNMB83bgHkaT9j9ILmhc2zcDsPSHpMc/h7p8b1KF0ygpqX4OnlsBA57qXb7AZLtG31
         4RvqQyyGGhhnsiqH5rbcwbHc5lvUdFRyB64RCc2NJJDtK9G1i/zbx8s+Axf5z8Idp8Ku
         l1/fdkATsiqAJo0vSByuJ+NzJVW5M5+7s8TU0=
Received: by 10.213.29.68 with SMTP id p4mr2483206ebc.41.1323208057133;
        Tue, 06 Dec 2011 13:47:37 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 65sm51347749eeg.8.2011.12.06.13.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 13:47:36 -0800 (PST)
In-Reply-To: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186393>

On Tue, 06 Dec 2011 22:43:50 +0100, Chris Patti <cpatti@gmail.com> wrote:

> I have a Homebrew installed version if Git 1.7.8 running on OSX Lion.
>
> I'm seeing a very odd issue where these diffs I didn't create keep
> recurring in a particular repository.

Could you be a little more specific about the nature of the diffs? Is it  
reproducible on another system? It sounds like newlines or whitespace. Does

$ git diff -w

produce the same result?



>
> I've tried:
>
> * Nuking the repo and re-cloning, cloning into a totally different
> containing directory
> * git reset --hard, git checkout -- of the offending file supposedly
> containing the diffs
>
> Is there some sort of uber persistent local cache that's bound to the
> remote repository?
>
> Thanks in advance,
> -Chris
>
