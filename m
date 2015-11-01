From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] ls-files: Add eol diagnostics
Date: Sun, 1 Nov 2015 21:17:43 +0100
Message-ID: <CAHGBnuOicaQEYB21usR3pnVQOE_d+k5mYadxVmqociLFZZtAfg@mail.gmail.com>
References: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
	<vpqbnbfpc6p.fsf@anie.imag.fr>
	<5635D0B1.9040800@gmail.com>
	<vpqmvuxzhot.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsz4W-00021Y-Ta
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 21:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbbKAURo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 15:17:44 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35587 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAURo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 15:17:44 -0500
Received: by igpw7 with SMTP id w7so44204616igp.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 12:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+IY1GBq91kHxCAov8b+v0DCMiTiEfCfZNEQGS19uSLY=;
        b=YceOSfkpDZZSfQ76BKOqSjLX3TSwylxPR7kbljJnbxEwZkOn6jdunaLBzL7D4iLdUQ
         BP5jgMyWVUzsuO8PV5o1hZQp3lBnZppE8VUcuu/zQJyi4aU6E7OwXk/LkVl3/FKiA5qX
         OKQVCQb7kqwc9kV+wu1AGuGKi5oT/ikO9Nuu1Zvo0K3CtyJtIVdlFlueAkhVw69Wj+or
         PGUwy15ADDSYQfnNAJHYAT4klKswuuWp9KP+4A1eSJ/U1Iryrj3GfTRjbEHhL/zhi83+
         7xH0EdAJZh5CIcfZA4FLEWJywHU5O7QaIoNR0vlHwGf3gbcFQcsB/PnmbQCB+MtcWa65
         AXqA==
X-Received: by 10.50.40.67 with SMTP id v3mr7388122igk.30.1446409063580; Sun,
 01 Nov 2015 12:17:43 -0800 (PST)
Received: by 10.107.182.133 with HTTP; Sun, 1 Nov 2015 12:17:43 -0800 (PST)
In-Reply-To: <vpqmvuxzhot.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280664>

On Sun, Nov 1, 2015 at 7:40 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

>> Any I find it a bit confusing to refer to the index where, as e.g. for
>> a freshly cloned repo the index should be empty,
>
> No it is not. The index is a complete snapshot of your working tree.
> When you have no uncommited staged changes, the index contains all files
> that are in HEAD. Most commands show you _changes_ in the index (wrt
> HEAD or wrt the working tree), but the index itself contain all files.

Thanks for the info.

> At stage 4), you really want to see the content of the index, because
> your HEAD is still broken.

Ok, I'm convinced. Thanks again!

-- 
Sebastian Schuberth
