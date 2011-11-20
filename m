From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: Stack overflow at write_one()
Date: Sat, 19 Nov 2011 22:02:04 -0200
Message-ID: <4EC8437C.6000808@cesarb.net>
References: <4EC81131.2010704@cesarb.net> <7vty5zizwn.fsf@alter.siamese.dyndns.org> <4EC823A0.3010603@cesarb.net> <CAJo=hJv2aGEFcMjTPxJsyLerqUn3w3hc3hWnc1ScaDrSGihzyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 20 01:02:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRurO-000546-93
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 01:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab1KTACJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 19:02:09 -0500
Received: from smtp-03.mandic.com.br ([200.225.81.143]:45444 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195Ab1KTACI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 19:02:08 -0500
Received: (qmail 27203 invoked from network); 20 Nov 2011 00:02:05 -0000
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-03.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <spearce@spearce.org>; 20 Nov 2011 00:02:05 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
In-Reply-To: <CAJo=hJv2aGEFcMjTPxJsyLerqUn3w3hc3hWnc1ScaDrSGihzyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185713>

Em 19-11-2011 21:30, Shawn Pearce escreveu:
> On Sat, Nov 19, 2011 at 13:46, Cesar Eduardo Barros<cesarb@cesarb.net>  wrote:
>> Em 19-11-2011 19:08, Junio C Hamano escreveu:
>>>
>>> Already found the real cause (jGit bug) and workaround posted, I think.
>>
>> I presume the cause then is what was fixed by
>> http://egit.eclipse.org/w/?p=jgit.git;a=commit;h=2fbf296fda205446eac11a13abd4fcdb182f28d9
>> ?
>
> Yes. The AOSP servers were all updated with the above JGit patch, so
> the servers are no longer sending duplicate objects. But yes, for a
> period of time there were duplicates in the kernel repositories,
> particularly kernal/omap.

So, would an alternative workaround in my situation be to delete 
kernel/omap.git and let repo sync recreate it? It seems repo does not 
have extra metadata anywhere else, so just removing the directory should 
be enough for it to clone again from scratch, hopefully getting a 
corrected pack from the server.

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
