From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 20:58:52 +0200
Message-ID: <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 20:59:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlVuU-0005Nf-Dz
	for gcvg-git@gmane.org; Wed, 31 May 2006 20:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWEaS6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 14:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWEaS6y
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 14:58:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:43279 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751785AbWEaS6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 14:58:54 -0400
Received: by wr-out-0506.google.com with SMTP id 36so94673wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 11:58:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UB9RvgerVC9RYO1mfMA0oWmUT2YfeKSH5U8iPg1vYnxkBMKf0sQrCgq/xpTNtw87ZYJKIC8w5rsFqPYOEsSNBfshI8YcpeyyKZksP/ODc1wUlf/XM3YrzTDsF03JUXi/v+QwHmAcLsZNqlyOOOCgw34qNXbe8nBUb70zVgzeG54=
Received: by 10.65.95.12 with SMTP id x12mr630906qbl;
        Wed, 31 May 2006 11:58:52 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 11:58:52 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21073>

On 5/31/06, Junio C Hamano <junkio@cox.net> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
> > I'm confused by the following:
> > paolo@Italia:~/git$ ./GIT-VERSION-GEN
> > GIT_VERSION = 1.3.3.g2186
> >
> > paolo@Italia:~/git$ git --version
> > git version 1.3.GIT
> >
> > Why git --version is not reporting the "full" version number?
>
> There is a bit of chicken and egg problem involved.  The build
> procedure wants to have an already installed git to figure out
> the "full" version number.  If you are bootstrapping, make clean
> and rebuild after you install git once would give you a git
> binary that knows what version it is.

Either I didn't understand your answer or something is wrong with my
git installation:

paolo@Italia:~$ cd git/
paolo@Italia:~/git$ git --version
git version 1.3.GIT
paolo@Italia:~/git$ make >/dev/null
paolo@Italia:~/git$ sudo make install >/dev/null
Password:
GIT_VERSION = 1.3.GIT
paolo@Italia:~/git$ git --version
git version 1.3.GIT
paolo@Italia:~/git$


-- 
Paolo
http://paolociarrocchi.googlepages.com
