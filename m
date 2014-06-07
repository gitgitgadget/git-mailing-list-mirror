From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: sort entries numerically
Date: Sat, 7 Jun 2014 17:54:55 +0700
Message-ID: <CACsJy8BQfGnWoyaHLkC842MdMq2dpHRqpder6sXdZHCYxzy=Fg@mail.gmail.com>
References: <5392ABAE.6030208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 12:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtEIA-00059Q-E5
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 12:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbaFGKz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2014 06:55:28 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:40089 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaFGKz2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2014 06:55:28 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so6583106qgd.13
        for <git@vger.kernel.org>; Sat, 07 Jun 2014 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f6NJbR5DouwW4Ha032gZYfaAqCEFffT/BTM4wlQm2ZA=;
        b=upae1AEZRSSWTcgmGhcEOCLRKEBCRiLL51JE6aINW/l1aKJ/OT7cB9BClsoFLoc//S
         SE0y8WdrsJ2MAqNRhiAflM/GAHmUV/0G/WNFkTp3tif3LFfkTtsuBYlrTQSk/LhszacX
         HgoDmuZfl/+EdZdtk87PPHbIh++rzOVMgxfrhGkf9rZQgcABbNBkyQ6NkPaD4TqYjWO1
         t2lHp8EqWbKA9wu9pK+5vke4fhwxLCDvIdMh1Z8hTWXgY9z/kslIpzuL2wPdIjGR08aL
         XyL4hhcQyZ5y1Ei4a9fW2C5uV7859tqweQDValSpsM20wiBnI2D1KFdv5i3UAXcDKdJ7
         R7qA==
X-Received: by 10.140.91.161 with SMTP id z30mr15777217qgd.65.1402138527126;
 Sat, 07 Jun 2014 03:55:27 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 7 Jun 2014 03:54:55 -0700 (PDT)
In-Reply-To: <5392ABAE.6030208@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251042>

On Sat, Jun 7, 2014 at 1:05 PM, Toralf F=C3=B6rster <toralf.foerster@gm=
x.de> wrote:
> Hi,
>
> is there any chance to have "1.8" before "1.10" in an output like the=
 following :
>
> ...
> From https://code.wireshark.org/review/wireshark
>    52fe0aa..b69642d  master     -> origin/master
>    460db8a..540f061  master-1.10 -> origin/master-1.10
>    25bb29a..5741a40  master-1.12 -> origin/master-1.12
>    4ee4fc11..97898a2 master-1.8 -> origin/master-1.8

git-tag supports version sorting. Not sure if it should be default
sorting order in these listings (from fetch and push?). Maybe we could
have a config key for default sorting order.
--=20
Duy
