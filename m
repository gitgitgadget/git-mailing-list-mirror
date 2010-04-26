From: Eugene Sajine <euguess@gmail.com>
Subject: Re: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 14:22:45 -0400
Message-ID: <p2y76c5b8581004261122g8e2950fci507cc9090a865843@mail.gmail.com>
References: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
	 <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
	 <z2m81b0412b1004261108n5453b5d2h179a944fa8db9b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:22:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6SxI-0000N7-Co
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab0DZSWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:22:48 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:46722 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0DZSWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:22:47 -0400
Received: by qyk9 with SMTP id 9so17783213qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ZE4UnlE2gYKQnzsd3LJedOLUINUy9XqJT991rTp6Gck=;
        b=eXzcsYfZvIUtQlRO6ya/U1/Le/4U5EDFfmxC5qTXbsHvmRLl8BFkPdSMD7IZ9Iw5SI
         /2CtZN2oC0d8YMbRgChccQER+Fz2JX6dIyS+UA9JJukAMU1Rh4kiKwR6iS9mnLsh/R6p
         LTcNOwkmvoJQZYnniaxnpoqvNcF3n4+9sqWd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PCEYJd1s0/swfPUcEx3ElEUQeA17CmfiaeTuM1jD5Yb2K0rMpYuprBYyjecDhzC4tP
         6JZJ3KxhOEPAiBom3ecSvSuE0Of0r8IsvyKJTcFLg57e6jvjDKnDeXHFJSdZntIzG74k
         A9MIPsn+N7zfzXCPf7nJP65AN9wiOb7rJRcMM=
Received: by 10.229.38.69 with SMTP id a5mr5408679qce.15.1272306165777; Mon, 
	26 Apr 2010 11:22:45 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Mon, 26 Apr 2010 11:22:45 -0700 (PDT)
In-Reply-To: <z2m81b0412b1004261108n5453b5d2h179a944fa8db9b49@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145843>

On Mon, Apr 26, 2010 at 2:08 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Mon, Apr 26, 2010 at 19:56, Eugene Sajine <euguess@gmail.com> wrote:
>> On Mon, Apr 26, 2010 at 1:54 PM, Eugene Sajine <euguess@gmail.com> wrote:
>>> Hi,
>>>
>>> I'm wondering if there is a way to get some repo information if the
>>> only thing i know is SHA-1 (no full path to the file)
>>
>> I mean of course the SHA-1 of the blob, i.e. the result of git
>> hash-object some_file
>
> Try 'git cat-file -t <sha>'. It prints what object type is under the hash.
> Than you can use either 'git cat-file <type> <sha>' (the most precise version,
> which shall fail if anything is wrong), 'git cat-file -p <sha>' or plain
> 'git show <sha>' (which always works, unless repo's broken).
>

Well thank you for that, but that gives me what i already know - the content.
I need to "reverse engineer" the history by having only the content
and its SHA-1 in order to indentify the last commitID and get all
relevant info (author, date etc. )

This is all about avoiding using keyword expansion (thanks CVS for bad habbits)

Thanks,
Eugene
