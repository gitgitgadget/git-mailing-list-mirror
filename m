From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC/PATCHv2 2/2] git-p4: initial demonstration of possible RCS
 keyword fixup
Date: Sun, 12 Feb 2012 20:07:00 +0000
Message-ID: <4F381BE4.2070807@diamand.org>
References: <1328829442-12550-1-git-send-email-luke@diamand.org> <1328829442-12550-3-git-send-email-luke@diamand.org> <20120211234248.GA16691@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 21:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwfhh-0006lG-0g
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476Ab2BLUGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 15:06:50 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62771 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab2BLUGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 15:06:49 -0500
Received: by wgbdt10 with SMTP id dt10so4270983wgb.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 12:06:48 -0800 (PST)
Received: by 10.216.136.196 with SMTP id w46mr4567790wei.24.1329077207982;
        Sun, 12 Feb 2012 12:06:47 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id dr5sm39838077wib.0.2012.02.12.12.06.46
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 12:06:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20120211234248.GA16691@padd.com>
X-Gm-Message-State: ALoCoQkl+92iTAwEw+oD2/T4ga0JdTRbNDVbsBRbXhzPqxoX68p2ATB+OB/Qg1bZufN9rhhGjMoB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190590>

On 11/02/12 23:42, Pete Wyckoff wrote:
>
> I'll send along a bunch of test cases I wrote to play around
> with this.  Your case had too many moving parts for me to
> understand.  If there's something in there that isn't covered,
> maybe you can factor it out into something small?  Feel free
> to merge any of my code in with a future resubmission.

Thanks - I'm glad you like it! I'll rework it with your code and resubmit.


>
> Some comments in this code below:
>
>
> This is a novel approach too.  Instead of just guessing that
> keywords are causing the conflict, inspect the diff for context
> or edited lines containing keywords.
>
> Or we could just always scrub every file before even trying to
> apply patches.

I guess scrubbing every file could get quite slow. We have people 
checking in hundreds of megabytes of C test vectors....

>
> In a few spots I see you've taken the ":" out of the regex.  This
> will match strings like $Idiot$ that shouldn't be keyword
> expanded.

Good point - I'll put the ':' back.

>
> Impressed.

Thanks!

Updated patch series to follow.


Luke
