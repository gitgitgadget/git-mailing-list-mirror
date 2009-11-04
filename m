From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Common setting for interoperability repo across windows and unix?
Date: Thu, 5 Nov 2009 00:10:28 +0100
Message-ID: <40aa078e0911041510p645c37c3i238fbf0eb568aba0@mail.gmail.com>
References: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
	 <32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com>
	 <S0ax5AE0Xf8KFwjv@thewolery.demon.co.uk>
	 <32541b130911041459y7a2201a3r18601522187891f2@mail.gmail.com>
	 <20091104230122.GK10505@spearce.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"Anthony W. Youngman" <wol@thewolery.demon.co.uk>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ozr-0002Hx-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbZKDXKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 18:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbZKDXKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:10:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34145 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932775AbZKDXKY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 18:10:24 -0500
Received: by bwz27 with SMTP id 27so9470909bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lS5f6+Je0vMnuFJIG0X+hbAx3RiKe7bmy8PUYnROe04=;
        b=M1P4epJgcihgd5sk7pvzK9h48+v5i6wH6Mz0FQZZhx47l7h+zzOOvnXcbb5BswkAj9
         5jEaoEpjjvDYO/8OIMZNWNzH9HiL5OXjA8h+fTCtphfSsBstZ5JsQK1mdx64ypLW9Nmq
         sjdqnNUgXTNVOE7A0VX7mAh0B5HBv0EvFD06c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=d4Eve9z4kb0Ze0DE8+X5NZtUjFSqOiZf5BrCZbAIX3Sa9yDymrEzwd0kDk3GQ5mFhI
         r9ZI/b9HFu0cNQypUkR6Cpe9M8dLYHqb7nvC+0satDPf8cRMsl+kZh73UWyGr39n14Lx
         r3i2yxn01lWwIUYzjh4r3Sejp/F2aBCPsQd80=
Received: by 10.204.35.12 with SMTP id n12mr2136802bkd.147.1257376228691; Wed, 
	04 Nov 2009 15:10:28 -0800 (PST)
In-Reply-To: <20091104230122.GK10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132168>

On Thu, Nov 5, 2009 at 12:01 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>> >
>> > git-daemon doesn't (currently) work on msysgit. Currently I run gi=
t-daemon
>> > on my linpus netbook and pull/push from windows.
>>
>> I didn't know that. =A0Windows sockets are mercifully very nearly
>> compatible with Linux ones, so hopefully this wouldn't be too hard t=
o
>> fix for someone that needs it. =A0(Not me; I prefer cygwin over msys=
 in
>> all cases.)
>
> git-daemon relies on fork, do work, then later exec. =A0Windows lacks
> this concept. =A0Making it hard to port.

Before anyone starts hacking: I've got a working git-daemon on
Windows, based on some old patches from Mike Pape, plus some extending
of the start_async-api. It's still not ready for submission, but I
think I've got the last important technical details nailed down now,
all that is needed is a fair share of clean-up. Hopefully I'll have it
ready for submission during the week-end some time.

--=20
Erik "kusma" Faye-Lund
