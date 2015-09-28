From: Alex Radulescu <mydesweb@gmail.com>
Subject: Re: git commit -a -m is not working
Date: Tue, 29 Sep 2015 02:34:46 +0300
Message-ID: <CAMWrOy72tRz3VQ2WGwe6bUD6UyTxLp71TsVeGThRVJgrtQCM+A@mail.gmail.com>
References: <CAMWrOy7YoAofbzfW+dy=v1TRgWGe5OuZ8U2x+Q-XCKc1y_agRA@mail.gmail.com>
	<20150926185416.GA233088@vauxhall.crustytoothpaste.net>
	<20150928171132.GA11993@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 01:34:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghwb-00031J-0K
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbbI1Xet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:34:49 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35525 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbbI1Xes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:34:48 -0400
Received: by laer8 with SMTP id r8so48787228lae.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZVK9IMtT1X9o9jv67slt1hRB4WgzqoVJfAgfD5jhVOA=;
        b=Ngya0yIFBRWTJor3CxBtv6M/zwSpApcxM1q3n1PV7IsC3CyCe2yUaPbcHFNbwNVUCi
         NeNovvyNMq8xr7PwACucR4SCIDcvOFOOnxM8CFKYTfZDTfFi+vWRqbGBO+aT4JVghF0Q
         jeuWRRVDlYYApqP5i4aOQ2Kr0hrqvTktVHist/HZNLR37JyjeNO+nxX3dEVCD41HzxSd
         3ydJFluAJqNbp/R8olEfFzc91H38F1i0HTufC1K4i6S2E25H9ku8hzWjmazMgr3qS/bx
         1gjLTi4JSjDgEW/tCyZmV23qHfCoZTc7wMmhmHW2XsBadasNHx8yluPJA389AmnpMgzI
         mqgw==
X-Received: by 10.152.37.162 with SMTP id z2mr6244920laj.117.1443483286718;
 Mon, 28 Sep 2015 16:34:46 -0700 (PDT)
Received: by 10.114.217.100 with HTTP; Mon, 28 Sep 2015 16:34:46 -0700 (PDT)
In-Reply-To: <20150928171132.GA11993@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278812>

Hi,

Thank you for your quick and precise support.

Can you share with me some best practices in deploying a web project?
I wave one remote repository, many local repositories (each/developer)
and a shared hosting server. What should I do to push quickly all
changes to my shared server?

Alex

2015-09-28 20:11 GMT+03:00 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> brian m. carlson wrote:
>> On Sat, Sep 26, 2015 at 09:51:12PM +0300, Alex Radulescu wrote:
>
>>> Alex:testGit Alex$ git commit -a -m 'made a change'
>>>
>>> On branch v1.0
>>>
>>> Untracked files:
>>>
>>> new_branch.txt
>>>
>>> nothing added to commit but untracked files present
>>
>> git commit -a does not add untracked files.  Such files might be build
>> by-products or such and you haven't told Git to track them, so it
>> doesn't.
>
> You can run "git add -N <files>" to tell Git to start caring about
> some new files (e.g., "git add -N ." to track them all).
>
> Alternatively, you can run "git add <files>" to tell Git that the
> current content of those files is ready for commit (e.g., "git add ."
> before "git status" and "git commit" to commit everything).
>
> More details are at http://jk.gs/gittutorial.html#_making_changes
> (also available by running "git help tutorial").
>
> Thanks and hope that helps,
> Jonathan
