From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-cc-cmd helper to contrib
Date: Sun, 11 Nov 2012 19:10:11 +0100
Message-ID: <CAMP44s1--1i+ZtG7eKe0ZpRizcBfq+wJv_VOVZfU+A+gpjLyhQ@mail.gmail.com>
References: <1352653804-2203-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ksDBbWfxbT=PbKiWaC87vghTADPqcy+ujgJ9iZOVZv0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbzL-0001Ii-BX
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab2KKSKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:10:12 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62772 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab2KKSKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:10:11 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5580200oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oxTA8bMG5sX+FOL/crxsMUbD5Yq/MqARf749BBrtTeM=;
        b=Nz/7QU0WT2ul5NDGMw3KXneBHwuPoG1fT6Y+BTIyJscT6m4Z1PfVbUIpN7VEjc6HGj
         HI1Tfq6YYgRmHA7kTPdCNiYRJ1JOQSheZOMKkCNnL6Gif8DEebi+zaoZSGlODs2pWP9g
         8bW/HbQk0gIjjA13NDKmSDFAGBTzss5tovc1XNgjctsta2BG8/oWU796+EsoDgQw4f7l
         3aGNzWYE0whrCpDZ72Yjc89hkjf6CwyrE1dFhYK9sjaIQjC4zea7lo1RmYtGTMEpSTx8
         RzhWUsUMhK7hwu9E2hQxdZGT3T/lAZTyKFM9trk1VArlgXwrbowvXb4iXE6qjcrRL2MI
         +RBQ==
Received: by 10.182.194.70 with SMTP id hu6mr13593735obc.4.1352657411155; Sun,
 11 Nov 2012 10:10:11 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 10:10:11 -0800 (PST)
In-Reply-To: <CALkWK0ksDBbWfxbT=PbKiWaC87vghTADPqcy+ujgJ9iZOVZv0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209432>

Hi,

On Sun, Nov 11, 2012 at 6:18 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> The code finds the changes in each commit in the list, runs 'git blame'
>> to see which other commits are relevant to those lines, and then adds
>> the author and signer to the list.
>>
>> Finally, it calculates what percentage of the total relevant commits
>> each person was involved in, and if it passes the threshold, it goes in.
>
> This is very cool.
>
>> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
>> new file mode 100755
>> index 0000000..17b14d4
>> --- /dev/null
>> +++ b/contrib/cc-cmd/git-cc-cmd
>> @@ -0,0 +1,186 @@
>> +#!/usr/bin/env ruby
>
> Just out of curiosity, why didn't you write it in Python?  (I noticed
> that you wrote remote-hg and remote-bzr in Python, and assumed that it
> was your preferred language)

No, in fact I hate python :) I only used it because both bazaar and
mercurial are written in python.

Ruby is my favorite language, after C.

I'm fairly certain that the equivalent code in python would be much
more complicated.

>> +$alias_file = "~/.mutt/aliases"
>
> Please read sendemail.aliasfiletype instead of assuming mutt.

Right. Will do.

Cheers.

-- 
Felipe Contreras
