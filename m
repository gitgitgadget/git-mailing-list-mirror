From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Finding all branches(remote and local) include given commit?
Date: Sat, 12 May 2012 14:07:14 +0200
Message-ID: <1336824434.3002.17.camel@centaur.lab.cmartin.tk>
References: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sat May 12 14:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STB6W-0005DP-Iz
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2ELMHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 08:07:14 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:44904 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab2ELMHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 08:07:13 -0400
Received: from [192.168.1.3] (brln-4d0c2fce.pool.mediaWays.net [77.12.47.206])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id B996546051;
	Sat, 12 May 2012 14:07:02 +0200 (CEST)
In-Reply-To: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197727>

On Sat, 2012-05-12 at 20:42 +0900, Yi, EungJun wrote:
> Is there any way to find remote and local branches include given commit?
> 
> e.g.
> 
> $ git branch --all --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
> * master
>   remotes/origin/next
> 
> As you know, it does not work and "git branch --contains" finds only
> local branches.

Works For Me. What version are you trying it with? Are you sure that
remote-tracking branches do contain that commit?

>From a quick look through the log and release notes, it was never
mentioned as a fix. The log contains 3f7701a4 from 2007 which fixes 'git
describe --all --contains' which, though unlikely, might be related.
This commit was however part of release 1.5.4, which makes it unlikely
you'd be using something older.

   cmn
