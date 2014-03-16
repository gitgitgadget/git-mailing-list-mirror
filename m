From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Sun, 16 Mar 2014 19:15:06 -0400
Message-ID: <CALkWK0npxgi2gWQbuYZLn_N0GxgTdPTR8c-yhgCxEV=mM2Zngw@mail.gmail.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com> <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPKHX-0000Rr-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 00:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbaCPXPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 19:15:48 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63877 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbaCPXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 19:15:47 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so4589582iec.24
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VvhPKAexcwlgQU14fsa6NPGNtzkQPhZ5uR5vKwMXDis=;
        b=Aa05BRM9tDH8zAY2JV2euEu4RQQPdggpA4aZ5UWnFt6BBYCrG5EuRNIBdoOBYrCel9
         OXS86taWIMSVwnLMaS+J3kOPj4wZ22g5akMbQZFrOwizP38iMsHKUMPmJjyhdpYmVjkQ
         d0xxOvS0LINYYa/ly26QQtqm74v3JZsmxgEULp2X/1yTJp5ZYrPXrw0uB5k9O4wnnzud
         MEzL1JAIKYPwiCbgrPMXv3M7XM3dRgGyX0tSGUsYSKC/U8AiCWpoj4C3Li/Y+hDfj9F1
         YkYOGQfB6wH4crcY5ZiOglkqQAWELCFCdDBhvuNFwqxLCpg8XD7WXZiDo8vfIrRx+W3H
         lulw==
X-Received: by 10.50.79.193 with SMTP id l1mr9955889igx.36.1395011747320; Sun,
 16 Mar 2014 16:15:47 -0700 (PDT)
Received: by 10.64.10.42 with HTTP; Sun, 16 Mar 2014 16:15:06 -0700 (PDT)
In-Reply-To: <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244217>

Philip Oakley wrote:
>> * po/everyday-doc (2014-01-27) 1 commit
>> - Make 'git help everyday' work
>>
>> This may make the said command to emit something, but the source is
>> not meant to be formatted into a manual pages to begin with, and
>> also its contents are a bit stale.  It may be a good first step in
>> the right direction, but needs more work to at least get the
>> mark-up right before public consumption.
>
> I'm not sure what elements you feel need adjustment. At the moment the
> markup formats quite reasonably to my eyes, both as an HTML page and as a
> man page.

I sent you a small patch fixing some minor markup issues.

> That said, the (lack of) introduction could do with a paragraph to introduce
> the "guide". I have something in draft..
>
> I had a thought that it may be worth a slight rearrangement to add a section
> covering the setting up of one's remotes, depending whether it was forked,
> corporate, or independent, but the lack of resolution on the next
> {publish/push} topic makes such a re-write awkward at this stage. (Ram cc'd)

Before attempting to introduce remote.pushdefault and triangular
workflows, I'd first fix the main issue: stale content. I'm not sure
who uses git show-branch or mailx anymore, for instance.
