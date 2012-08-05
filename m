From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Sun, 5 Aug 2012 14:30:51 -0400
Message-ID: <CAM9Z-nnfwuR9UKtoQ1uACOMH3vhZKFxDkjEn5_azpGxd2GGjJQ@mail.gmail.com>
References: <1343587966493-7564017.post@n2.nabble.com>
	<CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com>
	<1343637600904-7564056.post@n2.nabble.com>
	<CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com>
	<1343680215071-7564137.post@n2.nabble.com>
	<CAJo=hJsES44mXWjKmFqe7z+T_FHZ6Pi19toURyVp-wvW8AqQiw@mail.gmail.com>
	<1343684368384-7564144.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Bo98 <BoEllisAnderson@aol.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy5bQ-0003Uw-9e
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 20:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab2HESax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 14:30:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab2HESaw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 14:30:52 -0400
Received: by bkwj10 with SMTP id j10so775037bkw.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r9IrcZtVRORYOxkksCmifNqP9mvSKsw9zwVOW6Ipk9Q=;
        b=Uu2mnSlHbcfGLY++pPheSiB+KCVZhLaCICk6NECqu515/5UQjZU2velHnAH9/f5Ebo
         R6IAuw7lGTZJFq1Sf99Liex29EJZk+EoWMU0ikd8/FdRsqg952c5FSRSsbmZTtlVjxlZ
         x45PhZFYJytaSsY8znf5LPiie0YQiC75lYKznfv1KeaPbzzADSdVUff8rrRDV12E0S6q
         BGbi2A2b58PcLQbkSmwd0V8CelQ1NXz4Y3RldIxPiCS6UpBxlfGNboGxES7FI9eKOc9d
         I8vvoITxjcPPEyjxwoaDvPmmFqvCOdkM4PIoAmqKtVKjLVUZF1PEWIdNe9FiMbhCeBLi
         VfgQ==
Received: by 10.205.139.6 with SMTP id iu6mr3186488bkc.20.1344191451294; Sun,
 05 Aug 2012 11:30:51 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Sun, 5 Aug 2012 11:30:51 -0700 (PDT)
In-Reply-To: <1343684368384-7564144.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202911>

On Mon, Jul 30, 2012 at 5:39 PM, Bo98 <BoEllisAnderson@aol.com> wrote:
>
> Shawn Pearce wrote
>> Maybe you forgot to enable ExecCGI?
>>
> Whoops, completely forgot about that, but, assuming I did it right, it still
> doesn't seem to work.
>
> Here's what I did:
>
>   <Directory "/usr/libexec/git-core/">
>     Options +ExecCGI
>     Allow From All
>   </Directory>

Are all directory permissions set right? Is SELINUX enabled, and if so
are all of the contexts set correctly? Does your Apache configuration
recognize things NOT spelled *.cgi as CGI scripts / programs?

Besides, once you start asking Apache to do things outside of the base
Document Root all sorts of interesting possibilities for failure
become available.

I am pretty sure that this isn't a Git problem, it is a CGI hosting /
configuration problem. An Apache-centric list may be able to help you
better and is likely a better place to ask.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
