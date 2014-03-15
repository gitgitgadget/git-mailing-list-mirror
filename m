From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Fri, 14 Mar 2014 17:09:45 -0700
Message-ID: <CAJo=hJuGBgkseQ_mvbxFnYbkFDDWEuassf2+ttj_F53AMzU_Nw@mail.gmail.com>
References: <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org> <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net> <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net> <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net> <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
 <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com> <CACsJy8DtuCCYmmsEFB_m-YPHOOQ4FuchvnYQeuv75-vcSMej_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 01:10:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOcB5-0001b0-20
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 01:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbaCOAKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 20:10:08 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:32952 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaCOAKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 20:10:07 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so2777537wgh.10
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5+6x0BmnX3pk5chuEgECI4gAZ51In5aorhv5y/XejS8=;
        b=N7ZwjG/iNhOdkSLL8NefN0RHjbaHBPUNl1GyodVvhD95tnqkvgwahBn6EzJhIiPtD6
         PoqW0fjAPLkjaOIVXas5NjIZkT46UU4smJnQmXBsDzfH1NzIGkTthMm/FVXPcjoriZRW
         hOrmGW4WqCb8hLRgRIiX5dq9V44/O2Rvk1uzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5+6x0BmnX3pk5chuEgECI4gAZ51In5aorhv5y/XejS8=;
        b=lcQJLNPyPRTWEMbhSkjiRePyB3KB6gasPi0DlR/mv2WOL8FPzbU2SWA3iHyNEnxs90
         dw51KU30+/tmG4eG/Keglk4SQ2m8SHr6NRS1A8TEisI2KGvD2Uaby1PCYKQjBpEvWxN0
         HefByA3+y+RrpLrhDI8U76iBYj9LeL4lrc3EQ7lfo6jILDOQ7LO7lSdr9UmWIZLEB6ef
         jo7TsxYxvFTXBw0NRkYUAFS1FQv2f/fgFlya/64vQwFG+5Yi6vp24papT7X3TUciiIXl
         bUZjhDhTJF6pjoWpSQwmkHZZ7hvpqY9l9vUORTUZbLtyAdA+DdtGJdtipw73NcHV09m+
         etnw==
X-Gm-Message-State: ALoCoQmxPIzoUtAxIvOlkHk31L+hr919T0azRgVbuBMx0OR7xLJZCT06qnKCGUDdHQbWWcrMQXeE
X-Received: by 10.180.87.164 with SMTP id az4mr586911wib.2.1394842206244; Fri,
 14 Mar 2014 17:10:06 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Fri, 14 Mar 2014 17:09:45 -0700 (PDT)
In-Reply-To: <CACsJy8DtuCCYmmsEFB_m-YPHOOQ4FuchvnYQeuv75-vcSMej_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244128>

On Fri, Mar 14, 2014 at 4:30 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Mar 14, 2014 at 11:45 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>
>> You missed the SSH case. It doesn't have this slot to hide the data into.
>
> Right now we run this for ssh case: "ssh <host> git-upload-pack
> <repo-path>". New client can do this instead
>
> ssh <host> git-upload-pack <repo-path> <client capability flags>

Older servers will fail on this command, and the client must reconnect
over SSH, which may mean supplying their password/passphrase again.
But its remembered that the uploadPack2 didn't work so this can be
blacklisted and not retried for a while.
