From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 17:58:43 +0700
Message-ID: <CACsJy8AvuaS44r+qUV59n5XFOXWYiWK_Q36=jSbRGFcVCorkKg@mail.gmail.com>
References: <51065540.1090007@renemoser.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rene Moser <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzmR8-0000Ss-0z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 11:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab3A1K7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 05:59:18 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:38438 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3A1K7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 05:59:15 -0500
Received: by mail-ea0-f173.google.com with SMTP id i1so1074271eaa.18
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 02:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=oUnBozvvfyzZj3o4ktQonGir5XNfD5cMYIOPddR1LIk=;
        b=0f7al6f+ay7Y9Q7uAkIB8izUU/Hv8IIFbUWb0ram1lx3yhXBe/LAdBWDE1nsXIovN3
         XGE8ugQfWVttjiOkzlF7feDuxynBokSwL25xhZ5lXsxhse9E0zYxCj86+TaabXe5nc4H
         BjBe3QgTBJV+KMym7+DDaqcaAdShnjtaW5iAC0qZL1vtTcvV9qIbiLXT84kmCCCLbBbs
         K00yR2++v9IZLAGrZ6nUwoJvwC+5+RyAn+HHZ1juDr2RtW0yFC47HDjcHFIou+Mh1fAa
         I/KKOkCldtRKmRfi4IOLFz0q7q5DufDV3WMkySU1k7fbhb83jbFp7qaA0gNxawJ4e0/i
         ZEiw==
X-Received: by 10.14.218.71 with SMTP id j47mr46632704eep.28.1359370753977;
 Mon, 28 Jan 2013 02:59:13 -0800 (PST)
Received: by 10.14.119.69 with HTTP; Mon, 28 Jan 2013 02:58:43 -0800 (PST)
In-Reply-To: <51065540.1090007@renemoser.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214830>

On Mon, Jan 28, 2013 at 5:38 PM, Rene Moser <mail@renemoser.net> wrote:
> Hi
>
> Found a little issue in git version 1.7.9.5 if a file named "-", caus=
ing
> "git commit" to read from stdin.
>
> (So you must hit ctrl-d or ctrl-c to finish the commit.)
>
> Everything looks ok to me after the commit. Other users reported to b=
e
> fixed in 1.8.1.1 but haven't it tested myself.

Yes, it's fixed in 4682d85 (diff-index.c: "git diff" has no need to
read blob from the standard input - 2012-06-27) since v1.7.11.3.


> This does not work:
>
> mkdir tmp && cd tmp;
> echo foo >./-;
> git init; git add .;
> git commit -m "is this a bug?"
>
> Kind regards
>
> Ren=C3=A9
>
>
>
>
>
>



--=20
Duy
