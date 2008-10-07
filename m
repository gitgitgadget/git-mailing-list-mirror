From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 07 Oct 2008 19:12:52 +0200
Message-ID: <48EB9894.4090905@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org>	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>	 <48EB5FAF.4080303@lyx.org> <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnG8W-0000Y8-7L
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYJGRNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYJGRNF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:13:05 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:33819 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbYJGRNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 13:13:04 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 1DF4B32AB7E;
	Tue,  7 Oct 2008 19:13:02 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp8-g19.free.fr (Postfix) with ESMTP id CCB0132AAFB;
	Tue,  7 Oct 2008 19:12:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97730>

On 07/10/2008 18:50, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 3:10 PM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>> OK, with this patch, I see that the local config request is apparently
>> successful even though the 'user' and 'email' strings stay empty.
>>      
>
> An empty user and email it does not mean failure.

Yes, I know that but what is troublesome is that the user and email are 
not empty when git config is called outside of qgit.
What is even more troublesome is that the two calls to 'git config 
--global user.xxx' fail (but don't fail when called manually at the 
command line).

Abdel.
