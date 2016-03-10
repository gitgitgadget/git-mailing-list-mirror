From: Marcus Kida <marcus.kida@gmail.com>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently checked out - Part 2
Date: Fri, 11 Mar 2016 05:30:00 +1100
Message-ID: <9EFA8642-FA02-4ADB-B37B-530E611C9C1F@gmail.com>
References: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com> <alpine.DEB.2.20.1603101313220.4690@virtualbox>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:30:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae5Le-0001f9-WF
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 19:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbcCJSaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 13:30:07 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33105 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbcCJSaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 13:30:05 -0500
Received: by mail-pf0-f182.google.com with SMTP id 124so75182551pfg.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/SfOBuMEKO9SZRI0fi1LbgBt4XuAH1m2iB4hJGW1RlM=;
        b=rlULPRIdHzJarE/PjWesI/vaO4KWUUUYMTtZOtBibZ0xMAkrDSbY7XpzU3FKeC2EKO
         RDZdsduvhCGQEbI748+xtp5Lo28NJM4x7mwvclvz7GnCMDZ2YdoKAtxUPLthQuLCAGN/
         u3spz8uFZosiy82eWnnbDnV5bmetPotzFZwk5shiiL5cAlhV1xMuGeXH0EFwirp8s27B
         SLR0m7fmb2Mc03a1xGYOHb0iytp2hzpLOO1TFDuece7imiPxqwbnVu9i3D8lBZfH4H3P
         unaY8Vi6VuMShpSZOXvqDBwM9c5IdZEe2NsiDl+3DKCpI8L4zavdC1zWY3z5Z8EQK8AU
         p3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/SfOBuMEKO9SZRI0fi1LbgBt4XuAH1m2iB4hJGW1RlM=;
        b=fPoHfI7LlrKE79O/1vge7owOa9R9/S4vl3/dBiHdzpx7sns2wua/JQQMhkgz3H4dYH
         KgfY6NJvYLPFYi6C9srWlOBXKzSxI/Wa1pLyb6dpJxx1Tb2c5SX8TNeIPpWAHk6bPbw5
         GTl5rlTdBZJvJrwUUBuQ4kOqJYMyq/zrsoKq5JOtJt34avx2JL/jwBPgJGeSAc2Ao1gP
         vyQWpkrD/9LoEYlxciF6ts4J1ZYjdMzDrCMighUJZe4zz59fiSRIUMJBmC1KhXLXjwfD
         0zisNGZFM4f/0hkP+SMBMOOjpWxRKO+yQX6ceu1Q9a0UlRdIKmjpyR8Rn/GqRnxFdxLW
         8RKA==
X-Gm-Message-State: AD7BkJL/IZ5bvgiMUPG41xK2le6NT/mTMZkWD/j9rP3TQQkk3FtBL1gRK+vAulZyBe0Tng==
X-Received: by 10.98.68.71 with SMTP id r68mr7047559pfa.119.1457634604870;
        Thu, 10 Mar 2016 10:30:04 -0800 (PST)
Received: from [192.168.0.7] ([49.191.133.138])
        by smtp.gmail.com with ESMTPSA id o69sm3786171pfi.14.2016.03.10.10.30.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 10:30:03 -0800 (PST)
X-Mailer: iPhone Mail (13D15)
In-Reply-To: <alpine.DEB.2.20.1603101313220.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288632>

Hi Johannes,

thank you for the feedback.
I will fix this, test it and send a patch.

Cheers,
Marcus

> On 10 Mar 2016, at 11:15 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Marcus,
> 
>> On Thu, 10 Mar 2016, Marcus Kida wrote:
>> 
>> Proposed solution:
>> 
>> Use `strcasecmp`, `stricmp`, `strcmpi` here: https://github.com/git/git/blob/f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e/builtin/branch.c#L218
>> 
>> Not sure if/which one of this will work on POSIX as well as MS too though.
> 
> This is not quite a solution (it is not a patch). And you *definitely*
> want to make the use of strcasecmp() contingent on ignore_case. You are
> not alone on this world, after all, and other people have case-sensitive
> filesystems. It's totally doable, of course.
> 
> So, do you feel up to the task?
> 
> Ciao,
> Johannes
