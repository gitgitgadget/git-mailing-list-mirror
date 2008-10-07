From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit bug] git user settings not retrieved when launched for
 Windows explorer
Date: Tue, 07 Oct 2008 14:08:09 +0200
Message-ID: <48EB5129.2010407@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org> <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 14:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBNq-00051y-BY
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 14:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYJGMIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 08:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753031AbYJGMIe
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 08:08:34 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:57252 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbYJGMId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 08:08:33 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 6C8641725D;
	Tue,  7 Oct 2008 14:08:32 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D029A19725;
	Tue,  7 Oct 2008 14:08:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97700>

On 07/10/2008 13:57, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 1:36 PM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>>> Sound like a problem of startup directory: on the command line you
>>> start from the right directory...when you double click on which repo
>>> qgit is open ?
>>>
>>>        
>> None of course. But when I open a repository manually I would expect that
>> this is properly filled in.
>>
>>      
>
> In git.cpp, Git::userInfo() function get info about user by means of
> 'git config' calls, my guess (I cannot it test now) is that 'git
> config' does not work if we are not in a git directory.
>    

OK, I'll have a look, thanks.

>
>    
>> And if I launch qgit with the context menu (right clicking a directory in
>> the Explorer), qgit never managed to open the repository.
>>
>>      
>
> This is a bug that I never managed to get rid of :-(
>
> It is strange because it works if you try in a subdirectory, as
> example try right clicking on 'src' directory of qgit project.
>    

I tried and it doesn't work this way either; the statusbar tells me that 
this is 'Not a git archive' :-(

Abdel.
