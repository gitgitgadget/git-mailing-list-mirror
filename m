From: Gioele Barabucci <gioele@svario.it>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 20:09:56 +0200
Message-ID: <51A24FF4.4010102@svario.it>
References: <51A11DD0.4040802@svario.it> <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com> <51A24C75.3090100@svario.it> <87a9nhhb9c.fsf@hase.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun May 26 20:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgfOR-0000rH-L2
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 20:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab3EZSKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 14:10:00 -0400
Received: from camelia.svario.it ([164.138.26.129]:56355 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab3EZSKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 14:10:00 -0400
Received: from [192.168.2.4] (dynamic-adsl-84-223-204-159.clienti.tiscali.it [84.223.204.159])
	by mail.svario.it (Postfix) with ESMTPSA id 002542722C;
	Sun, 26 May 2013 18:09:57 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <87a9nhhb9c.fsf@hase.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225559>

Il 26/05/2013 20:00, Andreas Schwab ha scritto:
>> Simple, I keep all my projects on the same server, so I would like to
>> refer to that server + path using 'remote-repo'.
>>
>> "git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"
>
> You can use "remote-repo:" instead.

Do you mean I could use 
"git+ssh://git.example.org//users/gioele/projects" insteadOf 
"remote-repo:"? Yes, but now I have dozens of repositories already set 
up in various workstations and I do not want to go and change all of them.

What really bugs me is the fact that `git clone` and `git remote add` 
parse the same path in different ways. Git already has many 
inconsistencies. This one can be easily ironed out.

Regards,

-- 
Gioele Barabucci <gioele@svario.it>
