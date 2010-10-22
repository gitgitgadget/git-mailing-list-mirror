From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] Clarify tg-log note
Date: Fri, 22 Oct 2010 10:57:46 +0200
Message-ID: <AANLkTi=npfSXVxN7d7-D44s09s=Jgh8P6wZCB03O1kb1@mail.gmail.com>
References: <0ecc03501a8282e7c19011ca1cbc138dec502390.1287734568.git.bert.wesarg@googlemail.com>
	<20101022084358.GE19834@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org,
	pasky@suse.cz, martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:58:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DRn-0003c0-PX
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab0JVI5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 04:57:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54028 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab0JVI5t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 04:57:49 -0400
Received: by wyf28 with SMTP id 28so565810wyf.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bpkYcxq6EEFeXtGEIdgxg2JorAJW625rcTxpnBDTq5k=;
        b=aHs/CgORW7YoQTsVG9PuVBZuzJNmo0QqmE7Lc1zAmDsWP/bwTbEnuT2/XEZCrUKi6f
         IEqrFauQ7kDGE9ygcvlKQWiECCpkdzU5TUF9Z6iDuQtGztG1SRtKKq+9ozbiFl94o37m
         jK6kFhYtHyPmbkJwv4mdnYNR4KM/Uk1O8kwNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l9M0/k631JBojebu4xwgQfbPjVhRRXE2EpZ7ND4il0FmfuYqmxYwsRq4Tp6bbrX/M6
         VQk4W0C/M3uWn3B6nnWMWUcXiSK6vx+lgcxtxYx0CljnF36ucQQ19MfCARNSVgMWWd9A
         PmxizXI5pjTGPYD+b7feotwPTSqM0pnTO9S0s=
Received: by 10.227.136.146 with SMTP id r18mr2460019wbt.53.1287737866636;
 Fri, 22 Oct 2010 01:57:46 -0700 (PDT)
Received: by 10.227.136.76 with HTTP; Fri, 22 Oct 2010 01:57:46 -0700 (PDT)
In-Reply-To: <20101022084358.GE19834@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159667>

2010/10/22 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Oct 22, 2010 at 10:03:36AM +0200, Bert Wesarg wrote:
>> ---
>> =C2=A0README | =C2=A0 13 +++++++++----
>> =C2=A01 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/README b/README
>> index 5ca0424..348f515 100644
>> --- a/README
>> +++ b/README
>> @@ -520,10 +520,15 @@ tg log
>> =C2=A0~~~~~~
>> =C2=A0 =C2=A0 =C2=A0 Prints the git log of the named topgit branch.
>>
>> - =C2=A0 =C2=A0 Note: if you have shared the TopGit branch, this com=
mand
>> - =C2=A0 =C2=A0 only lists the commits that were made in the current
>> - =C2=A0 =C2=A0 repository, so you will not see work done by your
>> - =C2=A0 =C2=A0 collaborators.
>> + =C2=A0 =C2=A0 Note: that you don't see changes made by the remote
>> + =C2=A0 =C2=A0 when the topic diverged at both sides. Any 'fast-for=
ward'
>> + =C2=A0 =C2=A0 updates from remote topics will shown up. This could=
 also
>> + =C2=A0 =C2=A0 mean, that you 'lose' all your history, because the =
remote
>> + =C2=A0 =C2=A0 made the merge and you do only a 'fast-forward'. Tha=
n you
>> + =C2=A0 =C2=A0 will see only his history from now on. So its best t=
o prevent
>> + =C2=A0 =C2=A0 diverging development if you like to 'preserve' the =
full
>> + =C2=A0 =C2=A0 history. Please note, that 'lose' and 'preserve' onl=
y relates
>> + =C2=A0 =C2=A0 to when showing the log.
> Hmm, I see your intention, but I wonder if it wouldn't be enough to s=
ay:
>
> Note: if you have merged changes from a different repository, this
> command might not list all interesting commits.

Yeah, sounds perfect ;-)

Bert

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Uwe Kleine-K=C3=B6nig =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
