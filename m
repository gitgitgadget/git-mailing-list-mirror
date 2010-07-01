From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Beg. Level: Send Radiant CMS w/extensions to Heroku
Date: Thu, 01 Jul 2010 08:57:13 -0700
Message-ID: <4C2CBAD9.60701@gmail.com>
References: <29042313.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Geirsman <dsamay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 17:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUMB8-0005Aw-Tm
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036Ab0GAP7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 11:59:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38856 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189Ab0GAP7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:59:40 -0400
Received: by pwi5 with SMTP id 5so216838pwi.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PCDJcZqeDVcVtQAqjvXtVPq7xFsy9nky+4w7YTi63wA=;
        b=XKA4lVHp5WAXyAqrzHEsRGCs2mW5O6miYb6T52g9YiRDtq8POoDx5gCmNKWkrW4GbV
         p4931Rixf0WLSDZ8B03h99+1PybZbUDqsOAaCU5Jde5Ww7g0VLX3vPoMw8/f5565hw7j
         oCM3o7sV9HOTMwRQ5gmmamYEiVd7dolJDKTzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=f2Nw8n7dvk6T8MoFXtuDr8UHFDd36GhD5V4Xcjt+MRhBOY7InBvAJng8EBBV4U2Xqk
         bikgdtghUrOtcD16qe2tyt7+MJQ5DXEd/aJcsgUjDxUk+URQI0or0uEEeI3Af4WvhAbO
         FhY+G0ZBPKWbqp6x2StwibP2PWh5kcHwchNJE=
Received: by 10.114.19.9 with SMTP id 9mr12288487was.52.1277999971784;
        Thu, 01 Jul 2010 08:59:31 -0700 (PDT)
Received: from [10.4.6.94] (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id r11sm82046795wah.15.2010.07.01.08.59.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:59:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.9) Gecko/20100317 SUSE/3.0.4-1.1.1 Thunderbird/3.0.4
In-Reply-To: <29042313.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150052>

On 30/06/10 23:15, Geirsman wrote:
> Hey,
>
> I made the page I wanted locally with Radiant CMS and several extensions.
> Then when I went to send it to Heroku I ran into a variety of errors, first
> SSH, then I think I sent over the gems but not the extensions. And in
> attempting to fix things I think I only made them worse.
>
> Right now at http://freezing-night-21.heroku.com I believe I need to send
> over my extensions because the repo size is 17.6megs and the slug size is
> 7.6megs. Also the way I read the error message I get. 
>
> I'm lost so I start at the end, 
>
> $ git push heroku
>   
>> Everything up-to-date
>>     
> $ git commit -a
> U	vendor/extensions/forms
> U	vendor/extensions/forms_mail
> U	vendor/extensions/mailer
> U	vendor/extensions/multi_site
> U	vendor/extensions/paperclipped
> U	vendor/extensions/paperclipped_uploader
> U	vendor/extensions/ray
> U	vendor/extensions/rbac_base
> U	vendor/extensions/rbac_page_edit
> U	vendor/extensions/settings
> U	vendor/plugins/attachment_fu
> fatal: 'commit' is not possible because you have unmerged files.
>
> I'm lost, I tried a variety of commands but nothing seems to work on these
> extensions. I had several RB files on this list before so I hit git add
> <file> and now they don't show up. Can't really do that extension dirs
> though.
>
> Anyways, I don't care if I start from scratch and do it properly or if I'm
> just one step away from having the page that I want up and running. I'd just
> like it up. It's a very simple page and it's taken many more hours to deploy
> than to create because the documentation tends to be mmm...technical. Any
> help would be greatly appreciated, I am trying to make a site for community
> good!
>   
This is just a complete guess but you probably have previous merge
conflict that needs resolving.

The output of 'git status' should tell you something about files being
'unmerged' or having conflicts (sorry I can't remember the exact
wording). If you do have any conflicts open the files in a text editor
and search for the conflict markers '>>>>>>>' fix-up the files and
double check that everything looks OK. After that you need to tell git
that the conflicts have been handled with 'git add <filename>' you
should then be able to commit.
