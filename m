From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: git status bug problem.
Date: Mon, 23 Jun 2008 06:47:48 -0700 (PDT)
Message-ID: <m3r6aol0u8.fsf@localhost.localdomain>
References: <970bc7c80806230619i6c060c4eld329729ec7eef1da@mail.gmail.com>
	<970bc7c80806230622x326c5cd3mbce57949255a067b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ben Bennett" <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 15:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAmQE-0007YL-Uv
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYFWNrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 09:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbYFWNru
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 09:47:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:54901 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbYFWNru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 09:47:50 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1805555wri.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=5eyBrnV8zbZowlKaKX8YtEKKYWYOzIvvZeaNKeyI3Ec=;
        b=qVZrWu+9bg92Y8D4hcJDOPC/PuBavosldIjj/3HhWDVmJNfhkTA8cj4/mcGIbdl3Th
         FnJsSOH+IHt7cbIckyRw3uRkzyYUUGoEdct9OTPwOobXAFWBc21h/2I7SlDjslmlhpxx
         nFd7fQdbOdatrV8JlFFkNLMH7A4cmHguMtSVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=WND69w5VRD1X75DjDAlcz00b9+EvRaRQr+RwM+OGV0QHP5m8xnkFUlBLobYTocSTBj
         28Ie8jSgnJbs4kDoSVlzo6mY/m2gUdQc2xgvyw1Vqp0Lw5YbmUZq6Gb4SzM3ZmUtlnB2
         D3aCVP2Ly9qVLLGltvjkVZK6/Np4wTTmktVaA=
Received: by 10.90.29.13 with SMTP id c13mr514521agc.34.1214228868998;
        Mon, 23 Jun 2008 06:47:48 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.21])
        by mx.google.com with ESMTPS id m30sm4525138elf.12.2008.06.23.06.47.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 06:47:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5NDliuM032065;
	Mon, 23 Jun 2008 15:47:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5NDligL032062;
	Mon, 23 Jun 2008 15:47:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <970bc7c80806230622x326c5cd3mbce57949255a067b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85864>

"Ben Bennett" <benbennett@gmail.com> writes:

> I can't seem to get git status to return that a file has changed. I
> think my environment is hosed up, but I don't know for sure. My
> machine is ubuntu 8.04  with kernel  2.6.24-17-generic #1 SMPx86_64
> GNU/Linux . I set up a test repo and it added one file to it ,
> modified the file and saved . Doing git status returns nothing, git
> gui finds no modified files. Doing git add * finds the modified file
> and stages it. I can get someone a strace for the git status it is
> only about a 1 page.

You should have got something like the following:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   bar
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   bar
#

BTW. you have made initial commit, did you?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
