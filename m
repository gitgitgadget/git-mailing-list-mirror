From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Fri, 13 Dec 2013 08:05:07 +0700
Message-ID: <CACsJy8AMu9tiPBXXi3VKZ=nWub0nNt+6UTgGYRpudGxi7xzUnw@mail.gmail.com>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 02:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrHCI-0006Ha-2K
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 02:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab3LMBFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 20:05:38 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48591 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab3LMBFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 20:05:38 -0500
Received: by mail-qa0-f46.google.com with SMTP id f11so308799qae.19
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 17:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vcVCInPVawKYICwon2L1AG1jVe80aOjVOsjrAMxmP2I=;
        b=SQNy1ylXyyB9ofhaGSW6E4Xk17T/c74wcSlD07Wl5cM8LcslYWbqkyGq3KkXSKp///
         Ix2UmDT9JfPHknwWZ8mRj4v2mfQhwgT7XG0Li5WJ7QfhiSLnVYhB9JND5jqtIP6hYyqt
         nlaNN7w7b3aw2DA7oDGpLZ+R8UaOpR2LVG8Icna7cYy23T7k9X7oXKS/ALsLjxB1s/KZ
         tuPBEyjdiarZwbAUJbpKkZLUvo3n9mLCPElHRE1F1mETgJMUmD3j2Ph/2EbNcO9YRKUE
         mq2D3zXEQIs3hOhlC/zrKCgnodh+yUAz96OWyhge3xQN3EqslQ+APwdCIdL4NczhkzEk
         hONg==
X-Received: by 10.224.51.74 with SMTP id c10mr18354891qag.7.1386896737305;
 Thu, 12 Dec 2013 17:05:37 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 12 Dec 2013 17:05:07 -0800 (PST)
In-Reply-To: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239254>

On Fri, Dec 13, 2013 at 7:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/negative-pathspec (2013-12-06) 3 commits
>   (merged to 'next' on 2013-12-12 at 9f340c8)
>  + pathspec.c: support adding prefix magic to a pathspec with mnemonic magic
>  + Support pathspec magic :(exclude) and its short form :!
>  + glossary-content.txt: rephrase magic signature part
>
>  Introduce "negative pathspec" magic, to allow "git log . ':!dir'" to
>  tell us "I am interested in everything but 'dir' directory".

A bit off topic, but that command does not work as-is. We need '--' to
separate pathspec.

$ ./git log . :\!t
fatal: :!t: no such path in the working tree.
Use 'git <command> -- <path>...' to specify paths that do not exist locally.

Something to be improved later..
-- 
Duy
