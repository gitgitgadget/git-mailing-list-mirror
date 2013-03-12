From: John Szakmeister <john@szakmeister.net>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 20:41:03 -0400
Message-ID: <CAEBDL5V2ZWPQUDJU-tDJe8hsOJVf9+4Bx4WxEB6fhm+ZRCq9kg@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
	<CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
	<B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
	<CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
	<3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
	<513B8037.7060107@gmail.com>
	<C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
	<CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
	<E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
	<CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com>
	<ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de>
	<CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
	<A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Mar 12 01:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFDHf-0006Mk-4N
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 01:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab3CLAlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 20:41:06 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39079 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab3CLAlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 20:41:05 -0400
Received: by mail-wg0-f45.google.com with SMTP id dq12so5673660wgb.12
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oDSyBzlGOAgYQg6Y+srpg0d4U/973e8y8pBvfWzeqfk=;
        b=S/+J4o9nWAbfLwF0N/f3FEZ9q9fP486zHM4CiGO5BKZGLZ2ftgoa7lJc1J9Si90hNA
         xPa+vhSMvYjTJ0elmzYRU8VEavvwiZc2cSXm+2STWv4RQ/z9eomvmCbsTnYpyfvLDrOP
         8PkOF3vIGAtdBXVSkMY/jRg3IQNiByohf9XcBfQMfRgZ8rHBQDzJjBbr51uYqEi8NyPO
         +Di2Vpltx3JaG5K3XG+JJ0hbe7tQXs4RN1ls3rHal0VTijSvkznoAU/Ktc0HNhpZF9LB
         dfODgAODc+V9roMU2/Dms1FoInNPs1PITK/osTghrS177EnCbOpq80DOWPd8SWp95ljq
         uLxg==
X-Received: by 10.194.5.4 with SMTP id o4mr22838096wjo.40.1363048863846; Mon,
 11 Mar 2013 17:41:03 -0700 (PDT)
Received: by 10.180.14.137 with HTTP; Mon, 11 Mar 2013 17:41:03 -0700 (PDT)
In-Reply-To: <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
X-Google-Sender-Auth: 3fVJfi8byOQ20R1TlqYAHlKDot0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217927>

On Mon, Mar 11, 2013 at 8:29 PM, Max Horn <max@quendi.de> wrote:
[snip]
>
> sudo launchctl unload /System/Library/LaunchDaemons/com.apple.revisiond.plist
>
> -> this exits revisiond, and prevents launchd from respawning it. After that, the problem is gone, on several attempts. And once I reactivate revisions, the problem reoccurs.
>
> So it seems pretty clear what the cause of this is. Now I still need to figure out why it affects that particular repository and not others. But at this point I guess it is safe to say that Apple's auto-crap-magic revisiond is the root of the problem, and git is purely a victim. So I'll stop spamming this list with this issue for now, and see if I can figure out a fix that is less invasive than turning off revisiond completely (which some application rely on, so disabling it may break them badly).

I just wanted to say thank you for spamming the list with this.  I've
not upgraded to a new Mac OS X yet, but now I know I need to watch out
for this issue.  I'm glad you were able to get to the bottom of it,
and I'd love to hear if you find a reasonable solution.

-John
