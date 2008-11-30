From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Re: gitweb doesn't work with bare repositories
Date: Sun, 30 Nov 2008 17:52:46 +0300
Message-ID: <4932A8BE.9080302@gmail.com>
References: <4931D23A.10402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 15:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6nhU-00060n-WB
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 15:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYK3Oxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYK3Oxw
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 09:53:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:39559 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYK3Oxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 09:53:51 -0500
Received: by ey-out-2122.google.com with SMTP id 6so877602eyi.37
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=izbacZy5IKFDWcx05w5/43pQeF4fKjmG9AwSe+F5ZM8=;
        b=QmvifWe5sWeOrzsH28Kex0MCuNFkYkdff0JBgtXn8gt6Gxex8sYuqUms8mZx4rmoa0
         qCbyiJVibW0SCN7Ssnlrk3YFo3j3XgNIYXiiAnqEGtDmDqUUbG5s9I3yj1yAw92h53GL
         i+T3ViWn+A4QH7WU6d9txvHdX6q55trfB0Z1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=BMnjB0jZFrAi9kOTRDyU5TXCaXd3hRmgEVdMsWa4zP2y+Gf6+BFy9ivXG95BdaWARW
         VMOhsi5E2N8Hqy3rwnqTsOjkY+Jctz+wWOr5dqmy6QvJbEdohT7DCSxnRKv6+Ekuehk/
         dvLHSzJsE4KB9Aj4PepNIIa8FtKmaukb9UfLM=
Received: by 10.210.10.8 with SMTP id 8mr11436845ebj.172.1228056829895;
        Sun, 30 Nov 2008 06:53:49 -0800 (PST)
Received: from ?10.180.88.13? ([89.113.219.166])
        by mx.google.com with ESMTPS id k9sm15808106nfh.23.2008.11.30.06.53.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 06:53:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080922)
In-Reply-To: <4931D23A.10402@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101975>

Thanks to everybody for answers. I'm not subscribed and saw them in the
list archive.
All things you have noticed are typos, sure I typed commands correctly.
The problem was caused by "$feature{'pathinfo'}{'default'} = [1];" in
the config. So the problem is solved now.
Good luck :)

Evgeniy Ivanov wrote:
> Hi,
> I have installed gitweb and can't make it work with bare repos.
> I have such config:
> $my_uri = "http://mysite.org:8000";
> $projectroot = "/srv/www/gamekeeper/htdocs/projects";
> 
> In projects I have created bare repo:
> mkdir some
> cd some.git
> git --bare init
> cd /some_git_repo
> git push /srv/www/gamekeeper/htdocs/projects master
> 
> Everything fine, but when I click the link on some.git I don't have a
> page (just "Error 404").
> 
> But if I clone /some_git_repo with some in the projects, I have a link
> "some/.git" and it works fine.
> 
> Permissions are ok, virtual host is ok since I get main page and have
> access to cloned repo.
> 
> What can be wrong?
> 
> 



-- 
Cheers, Evgeniy.
Key fingerprint: F316 B5A1 F6D2 054F CD18 B74A 9540 0ABB 1FE5 67A3
