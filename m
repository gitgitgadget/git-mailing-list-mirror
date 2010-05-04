From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
 stop git-svn
Date: Tue, 04 May 2010 08:40:49 +0200
Message-ID: <4BDFC171.5010103@drmicha.warpmail.net>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> <1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com> <4BCF8E07.9080507@vilain.net> <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com> <20100503211942.GA1380@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Olson <mwolson@gnu.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Tim Stoakes <tim@stoakes.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 04 08:41:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9BoT-0004b8-PG
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 08:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab0EDGk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 02:40:56 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54815 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753175Ab0EDGkz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 02:40:55 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BAD85F3933;
	Tue,  4 May 2010 02:40:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 04 May 2010 02:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3TCZpiNqFledozi/YEBOloX1MEU=; b=IPmCiURjLtFFJILxWFJDxm0084KRey4C0MqO/1Xb/WAUrE54zHInKbfXGLpfJ0hxhbqgUkj6T/uPPmTTMOpLbgLUqtBYFVPfHpChuDRWsszC/RBkwAS85GXgvZY2NK7tIgWDKksI2m99pNY0W3/QmUzYIjSt6C4qQWM3u/6Q1RI=
X-Sasl-enc: 5nOsoFInzm7OSTKfZkcRSepMVBmfxlY775qdK/9ghXPJ 1272955254
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8CD494D9F0A;
	Tue,  4 May 2010 02:40:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100503211942.GA1380@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146297>

Eric Wong venit, vidit, dixit 03.05.2010 23:19:
> Michael Olson <mwolson@gnu.org> wrote:
>> On Wed, Apr 21, 2010 at 4:45 PM, Sam Vilain <sam@vilain.net> wrote:
>>> Michael Olson wrote:
>>>> Interestingly, I see people reporting the same problem in the thread
>>>> "git svn clone of subversion's own code failing".  So it's not just
>>>> related to patch 1/2 of this series.  At least that thread has a
>>>> public-facing repo so the problem should be easier to reproduce for
>>>> a real fix.
>>>
>>> Oh, right ... I remember that issue now. I'm currently testing the
>>> below change to see if it breaks the test suite; any issues and I'll
>>> post an update.
>>>
>>> Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linear history
>>
>> This change works great on my private repos, so it should supersede my
>> version which only did an eval.
> 
> Have either of you had a chance to look into the test suite breakage
> from this patch?  Thanks.
> 

Uhm, which one: The one in your subject line or the one in the quoted
subject line?

Michael
