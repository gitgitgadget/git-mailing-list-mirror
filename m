From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: MinGW build environment for Git
Date: Wed, 1 Aug 2007 02:08:22 -0700
Message-ID: <a1bbc6950708010208v15071005w3bcc471bef172fcc@mail.gmail.com>
References: <a1bbc6950707291614w392bf3a9t5d0d9e50bfcb0f36@mail.gmail.com>
	 <46B016FC.4050005@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 11:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGABv-0003Pc-AZ
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 11:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759023AbXHAJIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 05:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758856AbXHAJIY
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 05:08:24 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:35958 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757899AbXHAJIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 05:08:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so114665rvb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 02:08:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X81nsL6+AMX/FYLaTROw4XdyV9T7MNJv2Z7iO0DWAuaO8F+LemY6/qgCWPqXuDBwYpdRLlH71ERnu3wLW0Aj8zETYHnyElq6TFisbY7FHUlF/frWYyDLnhPpfy5gXo+lUZ2NJ7ZwC/GX5DPEWZ6PIhfdLZ41netuPI1vs1zYhBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gq+WCvapIam9PhRaavrOhmoXLKy+StBLKZJVtjxx34oYv68MO6wRVGX9I54x09J6KqHu26zfQMtz5e9oEz1YAi4UZrHh89GNqTPOTi+Jn5GrV8oMvri27z/VSeTBY0oIpC5kDooRHvVwhaqgVQDDNkNW5Lhm+HZCdEKEk2ssMG8=
Received: by 10.140.186.18 with SMTP id j18mr196745rvf.1185959302102;
        Wed, 01 Aug 2007 02:08:22 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 1 Aug 2007 02:08:22 -0700 (PDT)
In-Reply-To: <46B016FC.4050005@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54420>

On 7/31/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Dmitry Kakurin said the following on 30.07.2007 01:14:
> > I want to be able to build MinGW port of Git on Windows. I've tried
> > to follow steps in README.MinGW to setup this environment myself
> > (install MinGW, MSys, ZLib etc.) but after wasting a lot of time
> > with no result I give up. So, could somebody please just pkzip
> > their environment (everything required) and share the zip file with
> > me (privately or publicly)? I also think that an even better idea
> > is to create a new Git repository with MinGW build environment.
> > This will make contributing to MinGW port of Git MUCH easier.
>
> Aaron has done this, and you can find the link on his blog, here:
>     http://www.ekips.org/cgi-bin/aaron.cgi/2007/02/27

I've downloaded and installed it. But I could not make it work :-(.
First I had this problem:
$ make
GIT_VERSION = 1.5.3.GIT
    * new build flags or prefix
    CC convert-objects.o
gcc.exe: installation problem, cannot exec `cc1': No such file or directory
make: *** [convert-objects.o] Error 1

Then I've copied cc1.exe and some others from
C:\mingw4git\libexec\gcc\mingw32 into /bin.

$ make
    CC convert-objects.o
In file included from cache.h:4,
                 from convert-objects.c:1:
git-compat-util.h:51:22: sys/wait.h: No such file or directory

Searching entire (downloaded) tree for wait.h gives nothing.

'make configure' does not work:
$ make configure
    GEN configure
configure.ac+:4: error: Autoconf version 2.59 or higher is required
configure.ac+:4: the top level
autom4te: /bin/m4 failed with exit status: 1
make: *** [configure] Error 1

What do I do now?

-Dmitry
