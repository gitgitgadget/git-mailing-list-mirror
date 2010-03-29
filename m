From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Mon, 29 Mar 2010 08:34:48 +0530
Message-ID: <f3271551003282004h39ae8d95ma2bf6517e7d77d7b@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> 
	<4BAFFFAB.4080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 05:05:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw5Hz-0000A9-5f
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 05:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab0C2DFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 23:05:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63434 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab0C2DFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 23:05:10 -0400
Received: by gyg13 with SMTP id 13so1209448gyg.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=4dnIqYFYEd9vz6D6ftX6hF6mcxSSEhlztyoripMObjQ=;
        b=ddzKHxP30XuRupqLmPuQlb/G8/OvwH5SZnhdUn7BMC5eavuZN3OLZA0wu+V6JWa3RM
         LF8Fr1OkpZavzL7vyqDAfTXyxizwX3XFzUdQhX+fccMfSNPUjsFjq+yjz4XqGl2zDf9x
         MlhtcEZVfuau0lg45SmV40i4K85SqPRa3gKfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qc7KqVmGrXY4dHgv0bWeRYyodK5JTbw76kUD88xnIEv1VASF9BgVj8OU5ZpQRl8TGr
         5ELn9+ppQz6iFPIcsnM25ONDA7izxJlPvxaTPDdj4N97G7lwqtJTi8IfLQTeZ1ScAqq3
         kCim8JACOh9CILJ4Q+tM58kvL75byKPwWzd4Q=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 20:04:48 -0700 (PDT)
In-Reply-To: <4BAFFFAB.4080808@gmail.com>
Received: by 10.90.23.37 with SMTP id 37mr336628agw.75.1269831908198; Sun, 28 
	Mar 2010 20:05:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143428>

Hi,

> Oops, "needs" is repeated twice here...

Oops. Sorry about the silly mistake.
Junio: Could you please make this correction and apply the patch? I'm
writing another patch documenting invocation which depends on this
patch.

--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 Remote helper programs are normally not used directly by end users,
 but are invoked by git when it needs to interact with remote
 repositories. They implement a subset of the capabilities documented
-here, and conform to the "remote helper protocol". When git needs
+here, and conform to the "remote helper protocol". When git
 needs to interact with a repository served by a remote helper, it
 spawns the helper as an independent process and interacts with it over
 the specified protocol. Essentially, git sends commands to the helper
@@ -38,6 +38,51 @@ Git comes with a "curl" family of remote helpers,
specifically
 'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
 and 'push'.

> http://lists.zerezo.com/git/msg712892.html
>
> Should we add this information on this man page?

Definitely. Thanks for pointing this out- I've already started
preparing a patch for this.

-- Ram
