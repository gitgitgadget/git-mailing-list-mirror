From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 12:42:20 -0500
Message-ID: <CAMP44s3xpLtH5g5iZMi-A4P7MhE6xmb156f0ENFd851SHcpepg@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
	<20130609191518.GB12122@paksenarrion.iveqy.com>
	<7vhah4d3sk.fsf@alter.siamese.dyndns.org>
	<20130611170815.GA20009@paksenarrion.iveqy.com>
	<CAMP44s0VksnZmi21u6T79AvMebWA3gXmWbQ6pp=FAHL=D4q6+Q@mail.gmail.com>
	<20130611172416.GB20009@paksenarrion.iveqy.com>
	<CAMP44s3OG2MSO=zwAvzTnTLYOJmhsmbjrVJOxP-0ZSaxgMuUXA@mail.gmail.com>
	<20130611174111.GA22235@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSaQ-0004Np-NV
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab3FKRmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:42:23 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40836 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab3FKRmW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:42:22 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so6930312lab.10
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=opgos2mjY+p6rkuKgI9pRA8Yim1sV4fLlz+7JIs0Jzk=;
        b=qo0SiCLuiYL94BgALujn0FdmAVYqYimrDoxFG7cxMr5RbN5Qmy6yRFtzIeyWvnHRcL
         sq3TsUqVwXO7weIEA142ZhOlrtqwxaIcw11AVYTmQ73z3oHtMiEltErsDOZLe3txAblR
         04BTc75CGoWrET6u8x3h6d4RsROVAUKwkTfuuxmHO/FsvVUT/XbX9IaC9Krtv2hHCFnp
         O/iohNEUFjAsFT256dNDbbSTLDzb4gTyfJuqcO67l5t227jjXx0n1Qi+317pqcFrlaqa
         CKogJkwsWBT7aVAzJW6rNT+p+KhM7lx7NhyevB7fSl4Uac3J9JhZzVLGSXvj2auDeCq3
         rZyw==
X-Received: by 10.152.22.73 with SMTP id b9mr7940951laf.36.1370972540999; Tue,
 11 Jun 2013 10:42:20 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 10:42:20 -0700 (PDT)
In-Reply-To: <20130611174111.GA22235@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227477>

On Tue, Jun 11, 2013 at 12:41 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Tue, Jun 11, 2013 at 12:26:42PM -0500, Felipe Contreras wrote:
>> On Tue, Jun 11, 2013 at 12:24 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> > On Tue, Jun 11, 2013 at 12:09:32PM -0500, Felipe Contreras wrote:
>> >> It's not removed. It's simply moved.
>> >
>> > Sorry about that, I wasn't paying enough attention. But why are you
>> > moving it?
>> >
>> > All other arguments to git am is set in git-rebase.sh, why just set
>> > -q just before the invokation in git-rebase--am.sh?
>>
>> Because the next patch checks if there's any arguments meant for 'git
>> am' to switch to am rebase mode. We shouldn't switch to that mode if
>> the only argument to 'git am' is going to be -q.
>
> Okay, that make sense. How about rephrase the commit message and add
> this explanation. It's really not a cleanup but a preparation for the
> next patch.
>
> If I was a maintainer and only got this patch I would reject it. Every
> patch in a patch serie should be justified to be applied as a single
> patch, yes?

Yes, but it doesn't matter, because the maintainer has made it clear
he is not going to even read this patch series.

-- 
Felipe Contreras
