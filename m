From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [git-users] worlds slowest git repo- what to do?
Date: Fri, 16 May 2014 17:13:11 +0700
Message-ID: <CACsJy8CmiW88tNavRphZa_uMU=jVUCQE6cw5+t2AYnf5dDmcsQ@mail.gmail.com>
References: <5374F7C6.5030205@gmail.com> <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-users@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: John Fisher <fishook2033@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 12:13:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlF99-0001JS-7p
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbaEPKNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 06:13:43 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:43531 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286AbaEPKNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 06:13:42 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so3887827qgd.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5ywFX942KsS+sPASNT97o4pZ2BKJ+Abe0mXo4Curr4U=;
        b=s3S1U7tOMaOh3A4rQTu1JOBcdnmDvPxNEiSbIeEOZk9os9YCU/DLXW4aIRCh6FqQod
         07YAUvHSKExHNwn1jbKy4zeXzLSXVFMqCbfAS1C32vpRi5GAk0wwQMQy3vG6MTU3t2yl
         IcMOurAe8nccmjPcioPf5AhydH20TRcWRzltjZqgkCJAAhA2Q7kD8GL1+sQ6RJQsdYxC
         4iW12acaaDX9EvydTluNy7aLROSx0/54pTrAtpzKw6gZeNaXKywhDiRJ6jcOrY5iYxW2
         9QO9PV8QuWHFwLleMJ6+8/NammkMlC+RJj+5TI7+N4mPJSrq5gR5oGRW0DRLFd9GCbUT
         lOOg==
X-Received: by 10.140.107.198 with SMTP id h64mr22489349qgf.30.1400235222001;
 Fri, 16 May 2014 03:13:42 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 16 May 2014 03:13:11 -0700 (PDT)
In-Reply-To: <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249290>

On Fri, May 16, 2014 at 2:06 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "John Fisher" <fishook2033@gmail.com>
>>
>> I assert based on one piece of evidence ( a post from a facebook dev) that
>> I now have the worlds biggest and slowest git
>> repository, and I am not a happy guy. I used to have the worlds biggest
>> CVS repository, but CVS can't handle multi-G
>> sized files. So I moved the repo to git, because we are using that for our
>> new projects.
>>
>> goal:
>> keep 150 G of files (mostly binary) from tiny sized to over 8G in a
>> version-control system.

I think your best bet so far is git-annex (or maybe bup) for dealing
with huge files. I plan on resurrecting Junio's split-blob series to
make core git handle huge files better, but there's no eta on that.
The problem here is about file size, not the number of files, or
history depth, right?

>> problem:
>> git is absurdly slow, think hours, on fast hardware.

Probably known issues. But some elaboration would be nice (e.g. what
operation is slow, how slow, some more detail characteristics of the
repo..) in case new problems pop up.
-- 
Duy
