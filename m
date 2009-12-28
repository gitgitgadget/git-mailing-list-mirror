From: <mysql.jorge@decimal.pt>
Subject: Re: Newbie to git
Date: Mon, 28 Dec 2009 10:34:57 +0000
Message-ID: <7a0ae9cb57a1bc55653872ab254ea922@192.168.1.222>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt> <3a9710ae6b01fabf3b462da607af2534@192.168.1.222> <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com> <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222> <m27hs8t5b7.fsf@whitebox.home> <ec <7v8wcnx2lq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 11:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPCw5-0001cA-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 11:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbZL1Kem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 05:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZL1Kek
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 05:34:40 -0500
Received: from mailrly08.isp.novis.pt ([195.23.133.218]:41107 "EHLO
	mailrly08.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZL1Keg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 05:34:36 -0500
Received: (qmail 12156 invoked from network); 28 Dec 2009 10:34:34 -0000
Received: from unknown (HELO mailfrt08.isp.novis.pt) ([195.23.133.200])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly08.isp.novis.pt with compressed SMTP; 28 Dec 2009 10:34:34 -0000
Received: (qmail 1417 invoked from network); 28 Dec 2009 10:34:34 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt08.isp.novis.pt with SMTP; 28 Dec 2009 10:34:34 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id D86531A4290;
	Mon, 28 Dec 2009 10:34:57 +0000 (WET)
In-Reply-To: <7v8wcnx2lq.fsf@alter.siamese.dyndns.org>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135734>

> If you are addressing Andreas, why does your mail have:
> 
>     To: <git@vger.kernel.org>
>     Cc: <git@vger.kernel.org>
> 
> and no other addressee???

My error, sorry :)

> You created "myproject1" somewhere you started "mkdir" in (perhaps in
> $HOME?) [*1*] and that project tracks a single file "a.txt"; you are
> correct if that was what you wanted to do.
> 
> The new repository "myproject1" doesn't have any relation to the bare
> repository at /home/apache/gitprojects/mydir.git/ you created earlier.
> The next steps I recommend new people are:
> 
>  (1) push into the public repository, by doing:
> 
>      cd myproject1
>      git push /home/apache/gitprojects/mydir.git/ master
> 
>  (2) make sure push went correctly by trying to clone from there:
> 
>      cd ..
>      mv myproject1 myproject1.old
>      git clone /home/apache/gitprojects/mydir.git/ myproject1
> 
>  (3) check if the clone is what you expect
> 
>      diff myproject1.old/a.txt myproject1/a.txt
> 
>  (4) once satisfied, remove the old one
> 
>      rm -fr myproject1.old
> 
> And keep working in the myproject1 repository from there on.

Thank you, i understood, i believe i really did. did that test and it's
OK.
But let me reask in another way:

I want to setup the git server, to accept new branch's created in a remote
place that will be push'ed to it, please correct me, 'cause i'm doing
something wrong and i don't know what yet.

- setup git server to run with:
/usr/lib/git-core/git-daemon --reuseaddr --syslog --export-all
--enable=receive-pack --verbose --base-path=/home/apache/gitprojects

- created directory /home/apache/gitprojects
- git init --bare /home/apache/gitprojects

- what will be my link on the remote? "git://192.168.1.206" just?
- From now on, how can I have access to push projects that exist on other
machine?

Sorry for the questions... they are newbie!
Jorge,
