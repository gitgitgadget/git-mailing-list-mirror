From: Scott Chacon <schacon@gmail.com>
Subject: Re: A Basic Git Question About File Tracking
Date: Sun, 9 Oct 2011 09:57:07 -0700
Message-ID: <CAP2yMaLKxtN-i6XikBTd9XeJ9_5HnAMxj=VnPMU=WsMNb6MsYw@mail.gmail.com>
References: <j6dlhf$dp3$1@dough.gmane.org>
	<20111004011035.GA13836@elie>
	<4E8A5DF0.6040003@gmail.com>
	<20111004012244.GB13836@elie>
	<4E90E60C.7060105@gmail.com>
	<m3ipnz0xri.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 18:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCwgc-0005uO-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 18:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab1JIQ5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 12:57:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42026 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab1JIQ5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 12:57:07 -0400
Received: by gyg10 with SMTP id 10so4751205gyg.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vJiGszkHptt/dFiBdYC5dqe4jH1+1uT51O4WwPwYgok=;
        b=Ev3A4KrqmIJK4N5i8QkSirz5q7PlRJQHwYNI6NomwsKKq1gO8EXZEHChCAV9kI7Jmz
         rZbEgQbWdAtCXxcprYCMIJQqiThqx/JgrxmuLmN1V2ZgvUFZGYrJ05cyqLRTJZ8rxFmX
         XLbGc5SX9DaaED22IfS6wVp/I1sT2pL+KD050=
Received: by 10.150.60.1 with SMTP id i1mr3768656yba.99.1318179427122; Sun, 09
 Oct 2011 09:57:07 -0700 (PDT)
Received: by 10.150.212.13 with HTTP; Sun, 9 Oct 2011 09:57:07 -0700 (PDT)
In-Reply-To: <m3ipnz0xri.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183206>

Jon,

2011/10/8 Jakub Narebski <jnareb@gmail.com>:
>> This spoils my understanding of what the index
>> is. I had been thinking that after you add files
>> to the index, and then commit, the index is then
>> empty. In other words, whatever's in the index
>> gets committed, and then the index is cleaned.
>>
>> On the other hand, if the definition of a tracked
>> file is a file that's in the index, then this definitely
>> clears up my understanding of tracked files.
>>
>> If every file that's 'git add'ed stays in the
>> index, how does git know which files to commit?

It may help to read a blog post I put on the Pro Git blog called
"Reset Demystified" that talks about a simplified model of the HEAD,
index and working directory.

http://progit.org/2011/07/11/reset.html

Let me know if that helps.  And you're right, the book should say "not
in the index" rather than "not be in the last commit", that would be
more technically correct. I think at that point in the book I have not
gone into any details about the index yet, so it would be confusing
without more detail.

thanks,
Scott
