From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] Add git-list-files, a user friendly version of
 ls-files and more
Date: Tue, 2 Dec 2014 19:06:48 +0700
Message-ID: <CACsJy8BhDvVkG_NCqkoLCiERM1+nOfWT2p09JPvvU1_XGchhuw@mail.gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
 <1417337767-4505-10-git-send-email-pclouds@gmail.com> <CAPig+cQCFkGUqLjvGPLON8D3577ADyBJ2hmQ9girbO5Q1Tn6Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:07:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmEm-0001RK-J0
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbaLBMHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 07:07:20 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:53238 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbaLBMHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 07:07:19 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so11380849iec.29
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gIYIUZwUVs1I7FkOFdZJpnEolKd5k96cHjqs7MiD/jw=;
        b=ZFiwW5Ii6fb3NyYVbLcr77tVtCimIz04GFWV3XL81gF+1PV9YD4xmNG7+UNdMvEcpY
         mlj5k99D15vAx7QaiJMpQVemitgmuhZW8aLVgVLywNxlGqXqwfcKrc35+gWhI7M+mXvq
         X2kY23IHNljF+gyikbZYVqLPYqxDb1/sboiENv2BjHhz9tk/um8dlAVsknlAhDKHFMcy
         RhZ5sjiZ6/V7/1DR6To1oJjKoj0//eeFg2BBGH5xL8BI0jTuPif3js857bXLGu4U/wEC
         XUdJ4pm9GonzWrYmqJZczVf8ci78qzA+JvDgYChQh4ErpU/DSAhXCLM85s16Y7Oz1cfE
         rSKA==
X-Received: by 10.50.3.106 with SMTP id b10mr2632705igb.41.1417522038636; Tue,
 02 Dec 2014 04:07:18 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 04:06:48 -0800 (PST)
In-Reply-To: <CAPig+cQCFkGUqLjvGPLON8D3577ADyBJ2hmQ9girbO5Q1Tn6Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260557>

On Tue, Dec 2, 2014 at 9:50 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sunday, November 30, 2014, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>
>> This is more user friendly version of ls-files:
>>
>> * it's automatically colored and columnized
>> * it refreshes the index like all porcelain commands
>> * it defaults to non-recursive behavior like ls
>> * :(glob) is on by default so '*.c' means a.c but not a/b.c, use
>>   '**/*.c' for that.
>> * auto pager
>>
>> The name 'ls' is not taken. It is left for the user to make an alias
>> with better default options.
>
> I understand that your original version was named git-ls and that you
> renamed it to git-list-files in order to leave 'ls' available so user=
s
> can create an 'ls' alias specifying their own default options. Would
> it make sense, however, to restore the name to git-ls and allow users
> to set default options via a config variable instead? Doing so would
> make the short-and-sweet git-ls command work for all users
> out-of-the-box, which might be well appreciated by Unix users.

Or I just make git-ls the first alias shipped by default.. I don't
really like using config var to define default options. Sounds like a
workaround to our alias. Jeff raised it elsewhere in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/260423/focus=3D2=
60538
--=20
Duy
