From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 19:08:00 +0200
Message-ID: <CA+EOSBm4cSu8cxPc-3Eqm0J7deeht6FMMUGBKP6vx8VDcVrGPQ@mail.gmail.com>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
	<CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com>
	<CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 14 19:08:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZNE-000225-PE
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab2INRID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:08:03 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35715 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab2INRIB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:08:01 -0400
Received: by ieje11 with SMTP id e11so7201000iej.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gkfgJK6TEW2izJ1izEW9zef86UQ95gFAt+unF3YHAhQ=;
        b=Jbt62l7mxdH783z32L83LO7xhuQ7L1mUVYF54C07zgyLFVWqbYCerWlpdfenuJQ5Bu
         1k+g6CHURY2zQeKf7r8ixwZgRJcCebliyFa3npW6Hj0BkejVFc3MBL9Ofi2vg1XUULfY
         4iRi5ABQF+mi9Wuyh9KemBLuQpXxpStKEi8NcyOYAekHCiaaTPaZ0qY5fZ8BbhYh+BTh
         cRrCO7uWCwE/MFm0X4Y1IhWkuhC1Q9gHYLY1Lmcev8VyDVVHQgUPZf9P1mqDgpZkYSDn
         g/kyDNQDIhEXjrTXOfV/z8EqJANfxLn9C36aZ8ssWE4ogewY9RmFOe3HnB28l125WZqD
         rp7Q==
Received: by 10.50.154.168 with SMTP id vp8mr3843835igb.3.1347642480595; Fri,
 14 Sep 2012 10:08:00 -0700 (PDT)
Received: by 10.64.82.194 with HTTP; Fri, 14 Sep 2012 10:08:00 -0700 (PDT)
In-Reply-To: <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205504>

2012/9/14 Erik Faye-Lund <kusmabite@gmail.com>:
> On Fri, Sep 14, 2012 at 6:54 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Fri, Sep 14, 2012 at 6:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index 78c4286..7d1b34b 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>>>  # This test checks if command xyzzy does the right thing...
>>>  # '
>>>  # . ./test-lib.sh
>>> +
Nice. But this setting should be check that we have a terminal first isn't ?
Some test like this before

test "X$$TERM" != Xdumb \
&&  test -t 1 2>/dev/null  \
&& ....

or the inverse logic. This is what automake  and popt autogen.sh does.

Best Regards
