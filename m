From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: In search of a version control system
Date: Sun, 21 Oct 2012 18:55:11 +0530
Message-ID: <CAMK1S_hz-N-5mJ3OOOXbsQ5V+EjpFBmM9WFHJ_p2cxLDhVf8Ow@mail.gmail.com>
References: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
	<CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
	<vpqa9vwstp3.fsf@grenoble-inp.fr>
	<CAJDDKr5PxM3a6TjfdVoCp1VzgCFBKQ6YGhpN-BO-D=CyVTQX3w@mail.gmail.com>
	<vpq4nm4rxsy.fsf@grenoble-inp.fr>
	<CAM9Z-nnQjhehJEpyhyTY=rsK_f=2gTOUMVTycn7-Lao8Gog0pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David Aguilar <davvid@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Maurice Francois <francoismaurice2001@yahoo.ca>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 15:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPvWx-0006u6-91
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 15:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563Ab2JUNZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 09:25:14 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:43059 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab2JUNZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 09:25:12 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1106672lag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DvSA3wTG9gBBeSltdQ49hkld7D0dQp/lDI6u076pfmE=;
        b=DLiMiB9iVM2jQNS8O2BN86lNse1OX5EYxBW7+zxOXVFshIvqq5MsGZrTsGnCaRAv3N
         z6IG+wBC8Ifk93ZWjqpV4yEv7E9Mi5kJZfe3ZD+DWkOrVBDvlqQJR0x4jX1N8oGje+Yo
         bRfN68Y+9GePOTJhj0PrH+xJQT5pH3qyd/+KOj5CKYLxUWWTHl7/neQ4A/Se/OYMgWWJ
         kY21R8Yo+7GeJCXUOcjX+l10h9LToBusn32OlR2PDv7+UuwkkI5X3Mqai15gUfGy8cJQ
         5uZF3v4V6ezs6bYdt5a8lNqFjlTg/BIXiVT2WiOYEVt5Ks8rl6Pgdi7Wf+zt+sOc2+mb
         YXHA==
Received: by 10.152.103.18 with SMTP id fs18mr5687186lab.32.1350825911289;
 Sun, 21 Oct 2012 06:25:11 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Sun, 21 Oct 2012 06:25:11 -0700 (PDT)
In-Reply-To: <CAM9Z-nnQjhehJEpyhyTY=rsK_f=2gTOUMVTycn7-Lao8Gog0pA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208125>

On Sun, Oct 21, 2012 at 5:50 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Tue, Oct 9, 2012 at 1:58 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> I would advise against the file locking, though. You ain't gonna need
>>> it ;-)
>>
>> What do you suggest to merge Word files?
>
> If the files are in the DOCX format you can just expand them as zip
> archives and diff what's inside of them. The text in particular is
> stored as XML.

You also need a merge driver that at least splits the "all in one
single very very long line" XML into different lines in some way.  I
don't think git can merge even text files if everything is on one line
in each file.  And even if you do this I don't think the result will
be a valid ODT etc file.

All in all, I prefer the locking that David mentioned [1].  And if
your users cannot be trained to check first (as that URL describes),
then you probably have to use a CVCS that supports some stronger form
of locking.

[1]: http://sitaramc.github.com/gitolite/locking.html
