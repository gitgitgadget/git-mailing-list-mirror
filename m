From: Gioele Barabucci <gioele@svario.it>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 19:55:01 +0200
Message-ID: <51A24C75.3090100@svario.it>
References: <51A11DD0.4040802@svario.it> <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 19:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgfAE-00069e-Tb
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 19:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab3EZRzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 13:55:07 -0400
Received: from camelia.svario.it ([164.138.26.129]:56339 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab3EZRzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 13:55:06 -0400
Received: from [192.168.2.4] (dynamic-adsl-84-223-204-159.clienti.tiscali.it [84.223.204.159])
	by mail.svario.it (Postfix) with ESMTPSA id 56957214D6;
	Sun, 26 May 2013 17:55:03 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225556>

Il 26/05/2013 17:13, Elia Pinto ha scritto:
 >>       $ git clone remote-repo/ProjectA.git
 >>       fatal repository 'remote-repo/ProjectA.git' does not exist
 >
> Why someone should be do something like this ? What is the use case ?

Simple, I keep all my projects on the same server, so I would like to 
refer to that server + path using 'remote-repo'.

"git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"

I also helps me when I move all the projects from one path to another in 
the remote server: I only need to change the path once in `~/.gitconfig`.

Please note that `git remote add` correctly understands 
'remote-repo/ProjectA.git'. I was expecting that `clone` and `remote` 
both used the same code to parse paths.

Regards,

-- 
Gioele Barabucci <gioele@svario.it>
