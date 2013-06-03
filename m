From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 1/7] add simple tests of consistency across rebase types
Date: Mon, 3 Jun 2013 11:12:31 -0700
Message-ID: <CANiSa6g_QgvQgaTmVdTxbhdf=sxYmNjhYszxxXeh66rGrR1A_Q@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-2-git-send-email-martinvonz@gmail.com>
	<CANiSa6hH3APigj_vozsbBQriNhqnPT=2Qcb0T76qs9hPhbhacg@mail.gmail.com>
	<7v8v2rf4sb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:12:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZFI-0004DM-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759543Ab3FCSMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:12:35 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55999 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131Ab3FCSMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:12:33 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so3474789wgh.15
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YqBtOWJFVuCl/JmCkGz6CwsbWDclJHxh1g0n/NB517Q=;
        b=Jq38myxFX+d6ntntA9/codwxgQUXYU4/Ys2MzZi7IMTnP4L0boQLfZZQwG4BUDpcM4
         OfrHITT9R6L/9E9F8rlZhiQ5LBDYSUmOW8LdPBqZu8kyts0KJlUA0bz3iaO9eH/HeTBP
         XH9KqORtDgKfYVZmNVIVntgCSChKS+OM4PS6uW8DuDHmZXSZbHq7RNKdv0AmjYQ+oHaC
         HP6f1YAM5hiewyhAblXCwOsUEFzKpADgB8GYb1CpzhK1qHzfyTJcqA/zhfHr26AEYBdR
         HvGib6R61jJGj2eNLb/UhxJFEj1PQb15gIPBoQo2p2tnfZ05SW0apJQoXbZNmlnwL1mn
         EULg==
X-Received: by 10.180.108.3 with SMTP id hg3mr13864944wib.17.1370283151836;
 Mon, 03 Jun 2013 11:12:31 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Mon, 3 Jun 2013 11:12:31 -0700 (PDT)
In-Reply-To: <7v8v2rf4sb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226258>

On Mon, Jun 3, 2013 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> On Tue, May 28, 2013 at 11:39 PM, Martin von Zweigbergk
>> <martinvonz@gmail.com> wrote:
>>>  create mode 100755 t/t3420-rebase-topology-linear.sh
>>
>> Just FYI, there's another test case with the same number
>> (t3420-rebase-autostash) in pu. I don't know how you normally handle
>> such cases.
>
> Thanks for a heads-up.  Usually, the series that appears later on
> the list yields and finds a unique number.

In this case, that's my series. Want a resend or do you want to do it
yourself? I'm fine either way, whatever is easiest for you.
