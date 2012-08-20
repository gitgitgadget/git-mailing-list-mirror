From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: BUG Report. Why GIT commit need 30GB of memory for a commit?
Date: Mon, 20 Aug 2012 07:48:47 +0200
Message-ID: <5031CFBF.903@dewire.com>
References: <CAJ69RUQ++RpfgDmPh2k6n1e61xX9OZ_tvG5K7Q4CXvh7i2cj6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jose Nobile <jose.nobile@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 07:49:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3KrD-0001dE-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 07:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab2HTFsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 01:48:51 -0400
Received: from mail.dewire.com ([83.140.172.130]:29266 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785Ab2HTFsu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 01:48:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0FE938FC73;
	Mon, 20 Aug 2012 07:48:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2u3L0NrTgl3E; Mon, 20 Aug 2012 07:48:47 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h30n1fls32o828.telia.com [213.65.101.30])
	by dewire.com (Postfix) with ESMTP id BDEC48FC71;
	Mon, 20 Aug 2012 07:48:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120731 Thunderbird/15.0
In-Reply-To: <CAJ69RUQ++RpfgDmPh2k6n1e61xX9OZ_tvG5K7Q4CXvh7i2cj6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203756>

Jose Nobile skrev 2012-08-20 07.12:
> I have a big repository, around 80GB
> git --version
> #git version 1.7.12
> git init .
> #Initialized empty Git repository in /reponame/.git/
> git add -A .
>
> git commmit -m "Backup 2012-08-19 03:43:44"
> #fatal: Out of memory, malloc failed (tried to allocate 32220431361 bytes)
> #[master (root-commit) 8053f0d] Backup 2012-08-19 03:43:44
>
>   Why GIT need 30GB of memory for a commit?

It may be trying to compute a commit summary. Add -q to avoid the work.

-- robin
