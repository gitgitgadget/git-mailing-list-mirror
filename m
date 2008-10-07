From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 07 Oct 2008 19:38:57 +0200
Message-ID: <48EB9EB1.7080302@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org>	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>	 <48EB5FAF.4080303@lyx.org>	 <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com> <e5bfff550810070955o5ea20e90jf52faf31a0ada013@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnGXo-0003Pi-Hs
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYJGRjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYJGRjI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:39:08 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:35822 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbYJGRjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 13:39:07 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id DE02D32A803;
	Tue,  7 Oct 2008 19:39:04 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 0E0E032A908;
	Tue,  7 Oct 2008 19:39:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070955o5ea20e90jf52faf31a0ada013@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97735>

On 07/10/2008 18:55, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 6:50 PM, Marco Costalba<mcostalba@gmail.com>  wrote:
>> An empty user and email it does not mean failure. Again, I would think
>> that is git config that returns no data (without failing) if it is run
>> from outside git directory.
>>
>
> Yes ! it is like this, I have finally had the possibility to test.
>
> git config does not returns user and mail if run outside git dir
> because user and mail are local set.

So how do you explain this:

C:\>git config --global user.name
Abdelrazak Younes

C:\>git config user.name
Abdelrazak Younes

I get the same result in any directory, git repo or not.
FYI, I never set the name locally, just once and globally.

Abdel.
