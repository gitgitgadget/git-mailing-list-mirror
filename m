From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Mon, 2 Jul 2012 15:52:31 -0400
Message-ID: <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
	<20120615182534.GB14843@sigill.intra.peff.net>
	<7vvcis9ylx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Graham Ballantyne <grahamb@sfu.ca>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 21:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slmfm-0003H5-A4
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab2GBTwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 15:52:33 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49895 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab2GBTwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 15:52:32 -0400
Received: by eeit10 with SMTP id t10so2221126eei.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yWIKSR023bTwspDyVADCyE2vT1uQ7l9b1GtMvVa0qDQ=;
        b=k+cXAJgsegFsj4K0MIzTmDB/zMN8MvHWgKbaihVhybtKo7RSx8o+MFywz9NLkSY+Gi
         4RsyhRKGVKf5uJZirUloKx3mW9lSbWZol0Urg/oVEodJP0+mV68O9MD6LpB61bMOtRoA
         9wF8Ve0eKXc7qlorYIqQUsYXfuNdF0ZYcCIMRpYCIcK5o9Rtpcq9RY8aA4PInNBqw8fv
         I1aVhLYw8LSm/5Ec312eBepeZ/QPcgz3yTZembgZE1UU+H1rCVHmxfuF/2cVgVvB9Et3
         VL/Dp/WqR+fr+iDThGimwSP9Amecoc7PsJjZ/W78MThc9H3Wb66FSIAOcvdMKxdOMVwl
         aOjw==
Received: by 10.14.95.67 with SMTP id o43mr3634868eef.13.1341258751076; Mon,
 02 Jul 2012 12:52:31 -0700 (PDT)
Received: by 10.14.37.77 with HTTP; Mon, 2 Jul 2012 12:52:31 -0700 (PDT)
In-Reply-To: <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200857>

On Fri, Jun 15, 2012 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Jun 15, 2012 at 09:51:00AM -0700, Graham Ballantyne wrote:
>>
>>> I just downloaded the 1.7.10.4 tag from github. After compiling and
>>> installing, git --version returns "git version 1.7.10.3". I think that
>>> tag might be pointing to the wrong commit?
>>
>> Looks like 121f71f (Git 1.7.10.4, 2012-06-03) forgot to update DEF_VAR
>> in GIT-VERSION-GEN. Operator error from the maintainer?
>
> Thanks for noticing.
>
>> It builds with the right version from the git repository (which runs
>> git-describe and sees we are on the v1.7.10.4 tag), but exporting the
>> tag's contents and building fails. I suspect that the git-1.7.10.4
>> tarball on kernel.org would also have the same problem.
>
> It builds correctly if you download the tarball from the official
> location in the [ANNOUNCE] message.  This is because the build
> procedure for the official tarball does a bit more than just running
> "git archive-tar", which is what gitweb download interface does
> (namely, it adds the correct "version" file).

Junio,
I just noticed that the download buttons (for tarballs) on gitscm.com
all point to the github tag list ( https://github.com/git/git/tags )
instead of the location pointed to by your [ANNOUNCE] message (
http://code.google.com/p/git-core/downloads/list )

If you do something special as part of releasing these tarballs, is
this something that should be corrected? I can look at the source and
do a pull request for gitscm.com a little later, if needed.

-- 
-Dan Johnson
