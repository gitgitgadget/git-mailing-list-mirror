From: demerphq <demerphq@gmail.com>
Subject: Re: Confusing git log --- First time bug submission please advise on
 best practices
Date: Fri, 7 Feb 2014 19:37:40 +0800
Message-ID: <CANgJU+UcONQYAQ7K-_W7H_12JhfG+iuqYAU81xYMc5kLPXwn_Q@mail.gmail.com>
References: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
	<CAAH6HY8unuytrKpEA-eisojUkG=X4D+o+vQDO5bC5YCSmusoHw@mail.gmail.com>
	<874n4cjk83.fsf@fencepost.gnu.org>
	<CAJaBJzKy0b8MBuB_X_4n8E2=q=CyrpxOyFFrgv_2CQ19pkNmwQ@mail.gmail.com>
	<20140207102619.GA27616@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>, David Kastrup <dak@gnu.org>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Francis Stephens <francisstephens@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 12:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBjki-00029p-2g
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 12:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbaBGLhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 06:37:43 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:49863 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaBGLhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 06:37:41 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so4944025qaq.39
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 03:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9hbOakX4wLV8l/Gi8/FthGxPcEhdPP5NAxT7Qlb+g2Q=;
        b=MiJWICCvtvLc2LG3fMiGa4OfvueKYQfceLHxu9z08rdWn3LMkO87xn/ra1u/Ai2bC0
         c/Fmv6g8HMEcXrTcATI/jFeWrRoy0DI4medVpD2x3TlVM3M8pTXquIuA+OvgjcuXFPOJ
         jbO7WKrCCCN26Tu79IvBvnBhmEnolC8S1ERz4hYCZeYS9Gp3K9b8nbzGB81sifBbYr3M
         DWQWog2TPIYFCL2d3Z+5XXgzT9i8zVO/plMLV6U259TUjxuw1ynL7RDQQkhZfKZ1a2Jy
         au/1OPDgLIIY0ED44bCZwBw8tJb7aW1coVzZY5KHba6jlfL4mU6Y4/7MQRFCKAHe/KAC
         OBLQ==
X-Received: by 10.224.114.141 with SMTP id e13mr20798294qaq.65.1391773060552;
 Fri, 07 Feb 2014 03:37:40 -0800 (PST)
Received: by 10.140.96.117 with HTTP; Fri, 7 Feb 2014 03:37:40 -0800 (PST)
In-Reply-To: <20140207102619.GA27616@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241766>

On 7 February 2014 18:26, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 07, 2014 at 09:43:46AM +0000, Francis Stephens wrote:
>> Thanks for your clear response. I can see where I went wrong now.
>
> Maybe something like this would help avoid confusion a bit in the
> future? This toy patch puts a horizontal line as a break between two
> commits if they are not related, so we can clearly see linear commit
> segments.

FWIW, this would have saved a lot of head scratching at work over the years.

I'd love to see this in place.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
