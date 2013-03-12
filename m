From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 20:58:21 -0400
Message-ID: <513E7DAD.4030201@gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com> <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de> <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com> <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de> <CADgNja=oyAVVNTAY-OG5
 U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com> <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Mar 12 02:03:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFDct-0007S6-7k
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 02:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab3CLBDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 21:03:08 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:37674 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab3CLBDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 21:03:07 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so4311124iak.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kBDp7u20dZVUa3dPfK1SAEPX9sFN7HcGCHCCXioExcs=;
        b=O6AjjhYSFCUllFOe5o0n5nin5hef5exHPFdv3NtdnhXhkpLigWWvwmzpEtyj/wOuZp
         o8I4DloxbsGyxfcCIp/kcUcAmk2KuxqxJ+Q2hgvYIphm4z6Jgqmmn3G50zaWAcqLc2Dh
         2VJEXTsvi1WBh0NSWwFtSr+BFRicfKv2v7OgC7A3u941bx6kSPllFrNMpyirqTTaEmnX
         SFoM4UaCykhejrXQnqc8dojHoQaUnsnD6h+pxy5IUTelLpYuxKafwWzQvPk0VcAFwn2H
         d66xYnpLLtMF90JXu5YPFTGFWm3TFwX1TQCcEdh6nPwDK8IHcsp3G9J3Ry/YkyGMw22Y
         mv3w==
X-Received: by 10.50.135.8 with SMTP id po8mr9473649igb.41.1363050186550;
        Mon, 11 Mar 2013 18:03:06 -0700 (PDT)
Received: from [192.168.1.4] ([69.165.234.69])
        by mx.google.com with ESMTPS id xd4sm17654318igb.3.2013.03.11.18.03.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 18:03:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121202 Thunderbird/10.0.11
In-Reply-To: <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217930>

On 03/11/13 20:29, Max Horn wrote:
> sudo launchctl unload /System/Library/LaunchDaemons/com.apple.revisiond.plist
>
> -> this exits revisiond, and prevents launchd from respawning it. After that, the problem is gone, on several attempts. And once I reactivate revisions, the problem reoccurs.
>
> So it seems pretty clear what the cause of this is. Now I still need to figure out why it affects that particular repository and not others. But at this point I guess it is safe to say that Apple's auto-crap-magic revisiond is the root of the problem, and git is purely a victim. So I'll stop spamming this list with this issue for now, and see if I can figure out a fix that is less invasive than turning off revisiond completely (which some application rely on, so disabling it may break them badly).
>
> Andrew, thank you very much for your persistent guidance and help. I definitely owe you a beverage-of-your-choice ;-).
Awesome! I was starting to worry that we'd never figure out what the
issue is. Good thing you know your way around OS X and its debugging
tools. :)

Maybe drop an email if you figure out what's causing revisiond to be so
persistent about those specific files. Might help any who run into
similar issues in the future.

Cheers!
