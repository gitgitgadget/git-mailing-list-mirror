From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 2 new messages
Date: Fri, 7 Sep 2012 19:05:12 +0200
Message-ID: <CAN0XMOL9cxy8noicF-P-cjLkw76Zf3Uyu4C2RqbcTYrug5+w8Q@mail.gmail.com>
References: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
	<CANYiYbFBoK7D+9oZ2YGsrHYafOETLRUWUmHzfnAyA7RRhqgEkA@mail.gmail.com>
	<CAN0XMOL+2RV3wxp0nCAJzBBVF2vRNsK6H=MFYEqvKTw+nkcuXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>, trast@student.ethz.ch,
	jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA1ze-0004eR-Po
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab2IGRFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 13:05:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44029 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2IGRFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 13:05:13 -0400
Received: by weyx8 with SMTP id x8so1905535wey.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6HCKxkI4ALDqvrTNfncvaje8CqB6jyraHvHPperXO/c=;
        b=kWCRiah07eUU0E6Iy1f69GXo877hbTawyLvlaoGK4FWLifygSERh2PfR3lsu+LzaM8
         02r+yYBpJUE9BNo9Mo0LKNmaY8xbHpUvnSkxqb7UHDx9ug67HzXwGddAPuPZQAqTKzlP
         GOcky5ZUHLIQjNACXOGDcuhxIcofnyuDLVCKtyaR4KV0ig5rkdZm3E5LX/SWFeSawWin
         UIpVOt90Kac11jp94bBbfIJ9jNrfRSfirbMVmxl1pOz1cd7+DE66gNvCKwfjIlAOi5Qp
         pHaUfPwCFVYuE9YCzSUpAST73BNJKcCLqN5zBLeEs7Yq5c4DrB6zjcsILPnQt62RZ77e
         Ru0Q==
Received: by 10.180.85.167 with SMTP id i7mr13565424wiz.8.1347037512313; Fri,
 07 Sep 2012 10:05:12 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 7 Sep 2012 10:05:12 -0700 (PDT)
In-Reply-To: <CAN0XMOL+2RV3wxp0nCAJzBBVF2vRNsK6H=MFYEqvKTw+nkcuXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204976>

On Fri, Sep 7, 2012 at 6:36 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> On Fri, Sep 7, 2012 at 12:31 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
>> I just notice that the 1st line of the orignal message below has
>> only 56  characters, much shorter than other lines. It is because
>> this is a warning message, and would add a prefix: "warning: ".
>>
>> #: builtin/push.c:151
>> msgid ""
>> "push.default is unset; its implicit value is changing in\n"
>> "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
>> "and maintain the current behavior after the default changes, use:\n"
>> "\n"
>> "  git config --global push.default matching\n"
>>
>> For this reason, translations as follows are not well-formed.
>> So I rewind git-po, and your commits may need a bit amend.
>>
>
> I admit that I don't really understand what you mean. I can't
> see a big difference in line lengths. It's not more than others

I got it. This "warning: " is added automatically.
Sorry
