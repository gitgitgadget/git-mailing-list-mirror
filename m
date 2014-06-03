From: Mara Kim <mara.kim@vanderbilt.edu>
Subject: Re: Paper cut bug: Why isn't "git clone xxxx" recursive by default?
Date: Tue, 3 Jun 2014 17:24:41 -0500
Message-ID: <CAJdEhSbo_-s7T9Mu=sM+-60s8t28NDogoA36xJoZowwU3hErOg@mail.gmail.com>
References: <CAJdEhSa20ODuN4LkdvaWi0cSztgbJ+p50AYbtZs2oYWLitnjbA@mail.gmail.com>
	<xmqqvbshwz2e.fsf@gitster.dls.corp.google.com>
	<xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:39:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrxN6-000300-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933781AbaFCWjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:39:52 -0400
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:20841
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751717AbaFCWjv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2014 18:39:51 -0400
Received: from mail28-ch1-R.bigfish.com (10.43.68.233) by
 CH1EHSOBE015.bigfish.com (10.43.70.65) with Microsoft SMTP Server id
 14.1.225.22; Tue, 3 Jun 2014 22:24:47 +0000
Received: from mail28-ch1 (localhost [127.0.0.1])	by mail28-ch1-R.bigfish.com
 (Postfix) with ESMTP id CC94A200586	for <git@vger.kernel.org>; Tue,  3 Jun
 2014 22:24:47 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:129.59.94.73;KIP:(null);UIP:(null);IPV:NLI;H:hub.vanderbilt.edu;RD:error;EFVD:FOP
X-SpamScore: 5
X-BigFish: VPS5(zz98dI9371I1432Izz1f42h2148h1d77h1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah21bch2297h1fc6h208chzz1de098h8275bh1de097hz2dh2a8h839h93fhf0ah107ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15a8h162dh1631h1741h1758h17eeh1946h19b5h19ceh1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dfeh1dffh1e1dh1fe8h1ff5h2216h22d0h2336h2438h2461h24d7h2516h2545h255eh25f6h2605h2667h268bh26d3h27e2h282bh1b1cn15a9i1b1bi181ch)
Received: from mail28-ch1 (localhost.localdomain [127.0.0.1]) by mail28-ch1
 (MessageSwitch) id 1401834285990171_29938; Tue,  3 Jun 2014 22:24:45 +0000
 (UTC)
Received: from CH1EHSMHS009.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail28-ch1.bigfish.com (Postfix) with ESMTP id E8F94440066
	for <git@vger.kernel.org>; Tue,  3 Jun 2014 22:24:45 +0000 (UTC)
Received: from hub.vanderbilt.edu (129.59.94.73) by CH1EHSMHS009.bigfish.com
 (10.43.70.9) with Microsoft SMTP Server (TLS) id 14.16.227.3; Tue, 3 Jun 2014
 22:24:44 +0000
Received: from mail-vc0-f178.google.com (209.85.220.178) by
 smtpauth.vanderbilt.edu (10.1.154.73) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 3 Jun 2014 17:24:41 -0500
Received: by mail-vc0-f178.google.com with SMTP id hy4so3892911vcb.37
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 15:24:41 -0700 (PDT)
X-Received: by 10.52.117.41 with SMTP id kb9mr408044vdb.97.1401834281447; Tue,
 03 Jun 2014 15:24:41 -0700 (PDT)
Received: by 10.221.41.10 with HTTP; Tue, 3 Jun 2014 15:24:41 -0700 (PDT)
In-Reply-To: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [209.85.220.178]
X-OriginatorOrg: vanderbilt.edu
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250706>

That is good to hear.  I would be pretty happy about that. ^.^

Obviously any major changes will need to be done carefully.  I was
thinking of the way that you guys introduced new defaults for Git 2.0,
phasing them in slowly through the 1.x cycle.  Maybe I can get my
hopes up for Git 3.0 --- 9 years from now :P

On Tue, Jun 3, 2014 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Mara Kim <mara.kim@vanderbilt.edu> writes:
>>
>>> Apologies if this question has been asked already, but what is the
>>> reasoning behind making git clone not recursive (--recursive) by
>>> default?
>>
>> The primary reason why submodules are separate repositories is not
>> to require people to have everything.  Some people want recursive,
>> some others don't, and the world is not always "majority wins" (not
>> that I am saying that majority will want recursive).
>>
>> Inertia, aka backward compatibility and not surprising existing
>> users, plays some role when deciding the default.
>>
>> Also, going --recursive when the user did not want is a lot more
>> expensive mistake to fix than not being --recursive when the user
>> wanted to.
>
> Having said all that, I do not mean to say that I am opposed to
> introduce some mechanism to let the users express their preference
> between recursive and non-recursive better, so that "git clone"
> without an explicit --recursive (or --no-recursive) can work to
> their taste.  A configuration in $HOME/.gitconfig might be a place
> to start, even though that has the downside of assuming that the
> given user would want to use the same settings for all his projects,
> which may not be the case in practice.
>



-- 
Mara Kim

Ph.D. Candidate
Computational Biology
Vanderbilt University
Nashville, TN
