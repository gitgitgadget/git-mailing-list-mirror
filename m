From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 01:52:37 +0200
Message-ID: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 01:52:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg9LM-0007PE-36
	for gcvg-git@gmane.org; Wed, 17 May 2006 01:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWEPXwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 19:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWEPXwj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 19:52:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:51589 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932087AbWEPXwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 19:52:39 -0400
Received: by wr-out-0506.google.com with SMTP id 36so89667wra
        for <git@vger.kernel.org>; Tue, 16 May 2006 16:52:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G/LsUnnF9SnXC8UGb8HPHfEWedm0UpJrrdhYj3GkLI2BpLQfMvAoJFxfR5vgbrFhOcBMNKMH8384gptEBVu0+MSiO87g7iOWL36sPNuh4Ix+ahkVtSVLJKeqXjlkZgNJEik1uV8ZYYTai+TyGE2jrr1G2dxmS7z0pR50vfXKivU=
Received: by 10.64.91.7 with SMTP id o7mr520352qbb;
        Tue, 16 May 2006 16:52:37 -0700 (PDT)
Received: by 10.65.20.19 with HTTP; Tue, 16 May 2006 16:52:37 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20152>

Hi,

I've been trying to get git to work on the latest Solaris Express
release (with the help of NetBSD's pkgsrc).

It mostly miserabely fails because of common "shell commands" being
used with GNU options. (like xargs, diff, tr and prob. some more) On
my box (and thats AFAIK the default when you install gnu coreutils on
Solaris) the commands do have a g prefix.

So there are 2 possible solutions to get git working on Solaris.

1.  fix every single shellscript automatically during the build phase
2.  setup a dir which contains symlinks to the "right" binaries and
put that dir into PATH.

No matter what solution is chosen to be the best, I'm volunteering to
create a patch for it. :)

(although I personally prefer the second, because its easier...)

bye

Stefan
-- 
        http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
