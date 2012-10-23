From: Scott Chacon <schacon@gmail.com>
Subject: Re: Links broken in ref docs.
Date: Mon, 22 Oct 2012 22:11:15 -0700
Message-ID: <CAP2yMaKzLHiqpUtfcNtSFo8aqnbvS9RvCzC-DZvQMBgXvte5jw@mail.gmail.com>
References: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
 <CAH5451nFf_SY4K2DS52vhP6VeXSmeikUrc0zy8HK3xmGgs+UGg@mail.gmail.com> <CAJr+XPETQ2Jifns3_dfoB-sLLru2=Jkofb5RrBxLE4Fa9Aqp7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git <git@vger.kernel.org>
To: Mike Norman <mknorman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQWmU-00019R-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 07:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab2JWFLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 01:11:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55420 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2JWFLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 01:11:37 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2803993wgb.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 22:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+Jfx/iTAd/ubZKITNozAePFBUytquhtFe9JvIkgsDd4=;
        b=j6Y3Jk0EkLyGyik5HCLbda6gDu7HcsyOnxNb66jMJHDX2cA56A3A8BBPDFOh9K1+Zr
         k7qu9tqgoA0VfbUa+bhmYUT5I/JkAjb4CfWi5loH50di/rwSIZ+2wZxf8eJvtui8NIgn
         2oKDoudCT+G4RU4YwfagFzjxvjG79FZKy33EgAUhng6E/9AyiN+LnB3n01uTUZVcw//t
         gKLV8Qj9/2nhrqYMNgrODyuL5U0If6nU4S3vqH4SMUIIusJh2R1c/vV5iBf5aLgqTV+h
         rzoxeCvosx4BtiOTalynkNdDW6+XVMxXXuQ7RIgEN75/jQozn/t7Kxv9iUXt1U4shkib
         mByA==
Received: by 10.180.99.194 with SMTP id es2mr26066859wib.15.1350969095833;
 Mon, 22 Oct 2012 22:11:35 -0700 (PDT)
Received: by 10.223.5.14 with HTTP; Mon, 22 Oct 2012 22:11:15 -0700 (PDT)
In-Reply-To: <CAJr+XPETQ2Jifns3_dfoB-sLLru2=Jkofb5RrBxLE4Fa9Aqp7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208212>

So, this is due to the major AWS outage today.  git-scm.com is hosted
on Heroku and thus on AWS.  Heroku is continuing to bring up their
database systems in the wake of the massive AWS outage.  Once that is
back online, git-scm.com will also be back online.

As for the git-fetch issue, we'll look into it once Heroku is back online.

Scott

On Mon, Oct 22, 2012 at 7:34 PM, Mike Norman <mknorman@gmail.com> wrote:
> This seems worse. The entire site is now down with an application
> error. Reporting this out of surprise and just in case the dev on the
> job has the site cached somehow and can't see the error. Image
> (hopefully) attached and the message is as appears below, in case the
> attachment gets stripped. (Tags for convenience and not part of
> error.)
>
> <errortext>
> Application Error
>
> An error occurred in the application and your page could not be
> served. Please try again in a few moments.
>
> If you are the application owner, check your logs for details.
> </errortext>
>
> Hope this helps,
> Mike Norman
> On Sun, Oct 21, 2012 at 9:45 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>> On 21 October 2012 18:31, Mike Norman <mknorman@gmail.com> wrote:
>>> Many links on scm-git.org/docs simply reload the page.
>>>
>>> For example, all of Sharing and Updating section simply reload the
>>> docs page. And tons others. Must be a broken link or routing problem.
>>> Repros on FF 14.0.1 and Chrome. Good luck!
>>>
>>
>> Including Scott Chacon as he manages this site (to my knowledge).
>>
>> Looking at the request, I am getting a 302:
>>
>> Request URL:http://git-scm.com/docs/git-fetch
>> Request Method:GET
>> Status Code:302 Moved Temporarily
>>
>> Maybe those pages are not done yet? That doesn't seem right as this is
>> simply the reference manual, but perhaps there is something else going
>> on here.
>>
>> On another (related) note, the wayback machine has some very
>> interesting entries for the scm-git.org domain [1] and it seems the
>> /doc directory is not indexed at all. Is this on purpose?
>>
>> Regards,
>>
>> Andrew Ardill
>>
>> [1] http://wayback.archive.org/web/*/http://git-scm.com/*
