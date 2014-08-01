From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show containing branches in log?
Date: Fri, 1 Aug 2014 13:01:17 -0500
Message-ID: <CAHd499BppLXcGz3t-F1rdtKGMTvi+SVvW3TUt0DyGTLvKxpiwA@mail.gmail.com>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
	<CAA787rm=Pjy-GGzxCcy=NQNLUOCrTt4hYWS9iND8EAxxs67SuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 20:01:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDH90-0008NA-UA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 20:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbaHASB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 14:01:27 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:32787 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbaHASB0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 14:01:26 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so7141441vcb.6
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=lRKRqvdCYX579uGtEmQF0ih0CCuG+vgw5+RDaqcQtI0=;
        b=UGVPd0skziHFQW1aIkS6sob0POMs+q+hbvJA2CIIRe9cqKp8R1SvNEyC6s1/lEdH7I
         MrKRqO9f0nVWJhxDNt7Tm2v5KmDB0LpY/LXaAiT1lPyYZB87ABGgoe/zvOgeM2w754B7
         3DvEWWn6k4zuWDXDPS+neNIYdQBKswmLoR4fL1bOfqoif8eF2G8L+Ih1iVGBbVnEHSeb
         5aGVtZJIQLnA79YqeCcW5Ez+zo1iUubNHhkyDIiSUKFF0NRrKts2r7S+CCeBUemDGteT
         PpnxHVrts1uvD1u8wCsgoX03/BrNvJ00BvsqN3iI9YyA3KCiTqU8YsitGAIT474vPhXr
         Irrg==
X-Received: by 10.52.138.175 with SMTP id qr15mr3494345vdb.94.1406916077327;
 Fri, 01 Aug 2014 11:01:17 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Fri, 1 Aug 2014 11:01:17 -0700 (PDT)
In-Reply-To: <CAA787rm=Pjy-GGzxCcy=NQNLUOCrTt4hYWS9iND8EAxxs67SuQ@mail.gmail.com>
X-Google-Sender-Auth: Iglih9Go4FSL2GaBGtEAUvxdX3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254646>

On Thu, Jul 3, 2014 at 2:41 PM, =C3=98yvind A. Holm <sunny@sunbase.org>=
 wrote:
> I have created a script for just this functionality which I use very
> often, and have created a gist with the files at
> <https://gist.github.com/sunny256/2eb583f21e0ffcfe994f>, I think it
> should solve your problem. It contains these files:
>
>   git-wn
>
> "wn" means "What's New" and will create a visual graph of all commits
> which has a specified ref as ancestor. It also needs the following
> script, just put it into your $PATH somewhere:
>
>   git-lc
>
> "lc" means "List branches Containing this commit" and generates a lis=
t
> of all branches containing a specified ref.
>
> The files originates from <https://github.com/sunny256/utils>, but
> I've modified them in the gist to make your life easier. :)

Sorry for the late response. I forgot to thank you for this! This is
very detailed and helpful... I will try this soon and see how it
works.

Great job.
