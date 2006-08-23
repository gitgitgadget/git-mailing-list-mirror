From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit: deleting a branch doesn't seem to work
Date: Wed, 23 Aug 2006 10:15:00 +0100
Message-ID: <b0943d9e0608230215y17f398fcjad2c8edf6aabf1a@mail.gmail.com>
References: <e7bda7770608211027m298ca361pdd78e164b9a524a5@mail.gmail.com>
	 <tnxd5attbhq.fsf@arm.com>
	 <e7bda7770608221012u269ca577ye83a3a548c4faf08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 11:15:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFopQ-0003Hy-R7
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 11:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWHWJPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 05:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWHWJPE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 05:15:04 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:32608 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751468AbWHWJPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 05:15:02 -0400
Received: by py-out-1112.google.com with SMTP id x66so108927pye
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 02:15:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G/OyYrjO24VkWiIDQ+bIvyDjpQIX5Jtkyuq/7+j5cus+zDG0RB7nEDQM/ZHq/jd2zCtEnHT2lZUhwP+Az8atfrlbNqHK4JFlauq42n1UcGcZ39MC+fcMmjdufHjRHiyAJe6QWfUQo7a1eGnztelWTwaW2KIlCH/+Bd+6ACkOYIA=
Received: by 10.35.117.5 with SMTP id u5mr163182pym;
        Wed, 23 Aug 2006 02:15:01 -0700 (PDT)
Received: by 10.35.37.16 with HTTP; Wed, 23 Aug 2006 02:15:00 -0700 (PDT)
To: "Torgil Svensson" <torgil.svensson@gmail.com>
In-Reply-To: <e7bda7770608221012u269ca577ye83a3a548c4faf08@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25903>

On 22/08/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:
> Otherwise I had no problem in my first stgit experience. I first took
> a chance that "stgit import" recognized patches saved by
> "format-patch", but this was easily solved with "stg refresh -e" once
> I found it (thanks #git).

You could also use git-apply which understands the output of
format-patch and change the commits into StGIT patches with "stg
uncommit" (use the latest stgit snapshot as it has some bug-fixes and
can automatically generate the patch name from the commit subject
line).

The tutorial is pretty old and doesn't cover all the commands and options.

-- 
Catalin
