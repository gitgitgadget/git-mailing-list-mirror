From: Gioele Barabucci <gioele@svario.it>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 20:21:45 +0200
Message-ID: <51A252B9.7040008@svario.it>
References: <51A11DD0.4040802@svario.it> <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com> <51A24C75.3090100@svario.it> <87a9nhhb9c.fsf@hase.home> <51A24FF4.4010102@svario.it> <20130526181430.GL27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 26 20:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgfZp-0001d7-4U
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 20:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab3EZSVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 14:21:49 -0400
Received: from camelia.svario.it ([164.138.26.129]:56369 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab3EZSVs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 14:21:48 -0400
Received: from [192.168.2.4] (dynamic-adsl-84-223-204-159.clienti.tiscali.it [84.223.204.159])
	by mail.svario.it (Postfix) with ESMTPSA id 5DE24214D6;
	Sun, 26 May 2013 18:21:46 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130526181430.GL27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225561>

Il 26/05/2013 20:14, John Keeping ha scritto:
> On Sun, May 26, 2013 at 08:09:56PM +0200, Gioele Barabucci wrote:
>> Il 26/05/2013 20:00, Andreas Schwab ha scritto:
>>>> Simple, I keep all my projects on the same server, so I would like to
>>>> refer to that server + path using 'remote-repo'.
>>>>
>>>> "git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"
>
> In what way do you think that `git remote add` handles the path?
>
> All `git remote add` does is add a new "remote.<name>.url" entry to the
> configuration file with the value as given on the command line.  The
> insteadOf mapping will only be applied when you try to fetch from/push
> to the remote.

Regardless of the implementation of the commands, if I do

     mkdir projectA
     cd projectA
     git init .
     git remote add origin remote-repo/projectA.git
     git pull origin master

I get a working repository. If I do

     git clone remote-repo/projectA.git

all I will get is an error.

I do not see any reason (UX-wise) why the two sequences of commands 
shouldn't work the same when used on the same URL.

Regards,

-- 
Gioele Barabucci <gioele@svario.it>
