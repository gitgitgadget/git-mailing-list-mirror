From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Best practices/conventions for tags and references in commit message
Date: Thu, 5 Jun 2014 18:47:04 +0200
Message-ID: <CAP8UFD3MQ_BEyZFL2oE=KCGnZrCW5-NzXnVaaAg_6HMBAN-8hA@mail.gmail.com>
References: <201405271326.36031.thomas@koch.ro>
	<CALKQrgfYfXyXs0K+tq6xXNaQ-J1VdwJ7iodyE3s8X8wHN8WuvA@mail.gmail.com>
	<201406051610.41373.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsaow-0003uZ-TK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 18:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaFEQrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 12:47:07 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:36150 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaFEQrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 12:47:05 -0400
Received: by mail-vc0-f173.google.com with SMTP id ik5so1471876vcb.4
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h5VX28Z0pG0Dxw1vip4PoLJ9DhBEzKIhKAYEPoD8jXc=;
        b=Il1KnXnXfGybWTuWItZo+MO9uk7JdyXvlByzG5osUlOaZjH+7hJ6jhnAkOrxbViuWn
         EQBJlEPFY9daJkt3QeovmEioewKEZ6GfubHXwaxAO8OLxHL75ni8BsgXsZrzQdFnfB+N
         gXjNQqx1Tmv5c5fVCIhOQuFIg/FP4wb/qYAW69hfjZySsPKoyqwD9/LYNsDYzJpOxz3A
         cU1Vhae/vWhdSwycsxyZn3NMVLbFogSlDSOx03KGfKQ1FMDdLR4h7fcvzbb4JeKHowDS
         x5UP/WH12+eY1RMipzBMH8+vHF7JvibGPj1M6bpMy2gAVKrPMuJGy8+nqadr/YBVsPrV
         2M7g==
X-Received: by 10.221.51.77 with SMTP id vh13mr10538828vcb.41.1401986824922;
 Thu, 05 Jun 2014 09:47:04 -0700 (PDT)
Received: by 10.58.134.107 with HTTP; Thu, 5 Jun 2014 09:47:04 -0700 (PDT)
In-Reply-To: <201406051610.41373.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250850>

On Thu, Jun 5, 2014 at 4:10 PM, Thomas Koch <thomas@koch.ro> wrote:
> On Tuesday, May 27, 2014 03:49:24 PM Johan Herland wrote:
>> Search the mailing list archives for git-interpret-trailers. It's coming.
> Nice!
>
> I started a table to collect how different projects or tools use trailers:
> https://git.wiki.kernel.org/index.php/CommitMessageConventions#Trailers

Great!

It would be even better if you could add links to one or more actual
commits that contain the specified trailer.

For example for openstack, it would be nice to have real examples of
DocImpact, SecurityImpact and UpgradeImpact.

> It would be nice to see more examples and in the long run to have some best
> practices recommended by gits documentation and supported across different bug
> trackers, changelog generators, statistic generators, repository viewers,
> etc..

Yeah, what is also interesting is that some people/projects/tools use
things that are in some ways trailer like. For example GitHub parses
commit messages for things like "fix #1234" and there are also people
adding refs at the end of commit messages like:

[1] http://www.example.com/example_ref.html

Thanks,
Christian.
