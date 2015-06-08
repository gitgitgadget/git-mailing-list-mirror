From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Suggestion: group files in GIT
Date: Mon, 8 Jun 2015 21:48:59 +0200
Message-ID: <CAP8UFD24qiRzfPSkCppV-yPkoTVuwkJ+FDUGsv0Zrf66yOedOg@mail.gmail.com>
References: <CABEDGg8-B1QzkDas1dCcC7QivfOJuaGydki3OpON2T2WFVttFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z232i-0002oS-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbbFHTtD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 15:49:03 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34730 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbFHTtB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 15:49:01 -0400
Received: by wibut5 with SMTP id ut5so97037512wib.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KKYK7kjPqpHTi/UcOAF3jIBrIpYUroQiQGz4xh/I8ps=;
        b=uYr7wh+H3wIqReFnK8fgL+hsnEpheTd1abQ0K+jg/uIfdF4iIX5bZiZ3gz/473Q7L5
         FX8YyHokx0yMUnpVF+6nuIjDdRxggeMGvKibAicn3g5uUPtbeoj9ZBabl4hU1lDeaOGw
         LAjT4puuBRjTUKtvis0ZP5qT0+S12+cephiD0njDDqqeNbaOd+ogMyxnyaA0mAllhp0X
         Ew6a/oHWMXt+3E+IOJh8DdnSLL36cf2xuZ/gsF2+1RriINlhN2ACFGvwE6x9ATvdqzHJ
         koynFcukRS4pgNwN4eOoC1IOWFuCAieX2lPXbl6h1L9mgGJYv96CDeZbq4DB3HkkuZAM
         aCNQ==
X-Received: by 10.194.2.68 with SMTP id 4mr26171221wjs.82.1433792940029; Mon,
 08 Jun 2015 12:49:00 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Mon, 8 Jun 2015 12:48:59 -0700 (PDT)
In-Reply-To: <CABEDGg8-B1QzkDas1dCcC7QivfOJuaGydki3OpON2T2WFVttFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271118>

On Mon, Jun 8, 2015 at 10:50 AM, Konr=C3=A1d L=C5=91rinczi <klorinczi@g=
mail.com> wrote:
> I would like to group some files, so I can list group files together,
> list group changes together, filter by group for staging, also order
> by group.
> It seems, there is no such feature in GIT I would need, so I send it
> as suggestion.
>
> We can call this feature as "Group files" or "Label files" (labeling
> is used in Gmail, so this may be also a naming alternative).
>
>
> Example file list I would like to group together into [group1]:
> theme/header.php
> theme/footer.php
> theme/body.php
> lib/theme.php

Can't you use a shell variable like:

group1=3D"theme/header.php theme/footer.php theme/body.php lib/theme.ph=
p"

?

> They are in different directories, but mostly belongs together, so if
> I group them, then I can work easier with them.
>
>
> - I could select a file group for staging, so only the changes in the
> group would be added to stage.

git add $group1

> Changed files in the group:
> [group1]/theme/header.php
> [group1]/lib/theme.php
>
>
> - I could list files filtered by a group. Files filtered by [group1]:
> [group1]/theme/header.php
> [group1]/theme/footer.php
> [group1]/theme/body.php
> [group1]/lib/theme.php

ls -l $group1

> - I could order file list to list group files first, then directory f=
iles.
> [group1]/theme/header.php
> [group1]/theme/footer.php
> [group1]/theme/body.php
> [group1]/lib/theme.php
> other/files.php

I am not sure I see what you want to do with that.
