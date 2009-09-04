From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: Commit to wrong branch. How to fix?
Date: Fri, 4 Sep 2009 19:03:59 +0100
Message-ID: <26ae428a0909041103p4ecba8efvff6223f902e14f1a@mail.gmail.com>
References: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
	 <4AA13DF4.4050604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:04:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjd8r-00061Q-1B
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbZIDSEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 14:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757185AbZIDSD7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:03:59 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34256 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153AbZIDSD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:03:58 -0400
Received: by ewy2 with SMTP id 2so654763ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YfMtVNmVWuQ1JIEnTUgjtLsvXBjleIgXtmtZ8u6TV0o=;
        b=DezCzQZ/iLYCFtis9HGT/YyuiCR+x2SKeg19DUWFPZ7tvj9/TrveB2wFeHfqxasbbF
         KUQM5Y56djBWTkx2zBpkfRMHLzcwgTnVD9NYyS5dYUW1QLTvod2Xy+K1jjhha2IfN/08
         ouWXvur7B6tKU277btLhCh7ryNDTcE697pVxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oRoZrcC3j4a/HPCSR+WEPmuV84ACTKULktwTB4AbqzemsHhZ05sJqOAHUTQu2wqhJH
         iyuej5ypWfAeLVw52i7d1b/hwGtsXTpc7BvA9k+eGUTIhmvjFygMyBqjeubhcYWvaRVK
         5kgtwsb1DuR/Tw2umVZf9mSJNHMoXa1zYXUs4=
Received: by 10.216.4.79 with SMTP id 57mr955318wei.47.1252087439710; Fri, 04 
	Sep 2009 11:03:59 -0700 (PDT)
In-Reply-To: <4AA13DF4.4050604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127755>

Sorry... meant to add. When I do a 'git log' on the current (wrong
branch) the commit I made is still at the top of the list. I must
admit I don't understand what 'reflog' is (more reading) - not heard
of that before. I did ONE commit and ONE reset and then decided not to
touch it again :-)

Howard

2009/9/4 Michael J Gruber <git@drmicha.warpmail.net>:
> Howard Miller venit, vidit, dixit 04.09.2009 17:54:
>> I commited to the wrong branch and I can't figure out what to do. To
>> make matters worse I then did 'git reset HEAD^' which has made things
>> much worse. It didn't remove the commit and now I can't change
>> branches. I'm utterly confused. Any help much appreciated!
>>
>> Moral - use git status liberally and read it carefully before doing
>> anything. A 'git undo" command would be great is someone is feeling
>> generous :-)
>
> Whatever happens, don't panic ;)
>
> Let's say "geesh" is the branch on which you committed by mistake, and
> which you have reset.
>
> git reflog geesh
>
> which show you what has happened to that branch lately. In particular,
> it will list the "lost" commit. (Most probably it is the same as geesh@{1}.)
>
> git tag sigh sha1ofthatcommit
>
> will assign the tag "sigh", so that it won't get lost by doing "git gc"
> or such. Now you can lean back!
>
> Next step is committing "sigh" to the right branch. Depends on how you
> arrived at that commit. Did you commit the complete tree you wanted, or
> did you apply a change to geesh which you rather had wanted applied to
> some other branch?
>
> Michael
>
