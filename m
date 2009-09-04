From: Benjamin Buch <benni.buch@gmx.de>
Subject: Re: Deleted folder keeps showing up?
Date: Fri, 4 Sep 2009 10:18:03 +0200
Message-ID: <8E56979B-5D85-4844-A492-8149EE9E9B2F@gmx.de>
References: <34230C98-81B8-4DC8-846F-8B6FA2A022DA@gmx.de> <4AA0C4A2.5040405@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 10:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjTzs-00081w-ER
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 10:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbZIDISG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 04:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbZIDISF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 04:18:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:38242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753631AbZIDISE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 04:18:04 -0400
Received: (qmail invoked by alias); 04 Sep 2009 08:18:04 -0000
Received: from xdsl-78-34-177-106.netcologne.de (EHLO [192.168.1.100]) [78.34.177.106]
  by mail.gmx.net (mp013) with SMTP; 04 Sep 2009 10:18:04 +0200
X-Authenticated: #10686235
X-Provags-ID: V01U2FsdGVkX1+5+3xWS1O5t5MiiMce7dN647epb8zVQUFBZMSlLt
	2frVSsePLt58IP
In-Reply-To: <4AA0C4A2.5040405@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.930.3)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127693>

Hi Michael,

thank you for your answer.

Strangely, I can't reproduce the error  today.
As I did quite a lot branching and merging yesterday (learning git),
I can't remember the steps that led to the error.

And it doesn't have to be an error though -
perhaps it was just my clouded perception due to the lots of branches.

But I will keep an eye on this and see if it happens again.

Sorry for bothering,

- benjamin


Am 04.09.2009 um 09:41 schrieb Michael J Gruber:

> Benjamin Buch venit, vidit, dixit 03.09.2009 18:59:
>> I made a branch and deleted a folder there with git rm -rf  
>> foldername.
>> So now i have to branches, A with the folder and B without the  
>> folder.
>>
>> I'm on B, the folder is not there.
>> Then I check out A, the folder shows up like it should.
>> When I check out B again, the folder is still there.
>>
>> A git rm -rf folder gives me:
>>
>> 	fatal: pathspec 'folder/' did not match any files
>>
>> , so git is not tracking the folder.
>>
>> I can rm -rf the filder without git and start the whole game from the
>> beginning,
>> but there has to be a better way?
>>
>> Strange enough this happens just to two folders I removed,
>> with others there is no problem.
>
> What does "git status" say when you've checked out B? Could some
> contents of folder/ possibly be being ignored (.git/info/excludes  
> etc.)?
>
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
