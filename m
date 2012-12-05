From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git-svn with non-standard repository layout
Date: Wed, 5 Dec 2012 17:26:54 +0100
Message-ID: <CAA01Csoam7pXqPKnjvJB46T_sdjcW2S1oXdQT3HbUdfN4TK0kw@mail.gmail.com>
References: <CAA01CspaYewmhTcYCWscsOWoNPvb6a=G1Ak0-=_spJSh6fsdHg@mail.gmail.com>
	<50BE68C9.7070100@cafu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Carsten Fuchs <carsten.fuchs@cafu.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgHoV-0005F1-QD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 17:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2LEQ04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 11:26:56 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48931 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab2LEQ0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 11:26:55 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so2803733qcr.19
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=cjfneDRKb6Ho+0ko5HgJmJRfeu2Ku+6zCna3NaKZTM8=;
        b=CYNX3fsEo7fpVl6ExOe6Uuw4E1zyCuH7AYE4xz+89v7K58Zw/WWkU5DBOkOTNvGn9K
         Zj14TuIkPqzH3dj872rtBQg0Gsqfvm5qCqU3LA1SBuKel6uSK5ybPHvtC0+A9BUItWMq
         Lz2uwaAQKvCyNPw62W+pLpyX/PqDCFZjkIgZi3xF3+0oRot8ysZmUzKLUsVHA30CiGey
         PVwAIJ4GyWAjruS48vlrOijRQhMFLxslURowK+gLiU1ZbLvjONTQQa2ZncTE+Je90yez
         +tLAWrQbMZGe1QBYKbvPabK0SrypHL8zg4A5DBpSoPaa29QSN5+E9kB+sp7uar3LpLoV
         bnYw==
Received: by 10.224.71.16 with SMTP id f16mr29580665qaj.45.1354724814282; Wed,
 05 Dec 2012 08:26:54 -0800 (PST)
Received: by 10.49.26.132 with HTTP; Wed, 5 Dec 2012 08:26:54 -0800 (PST)
In-Reply-To: <50BE68C9.7070100@cafu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211131>

On Tue, Dec 4, 2012 at 10:19 PM, Carsten Fuchs <carsten.fuchs@cafu.de> wrote:
> Hi Piotr,
>
> Am 2012-12-04 18:29, schrieb Piotr Krukowiecki:
>
>> Is there a way to handle svn repository with following layout?
>>
>> repo/trunk
>> repo/branches/branch1
>> repo/branches/branch2
>> repo/branches/work/developer1/branch3
>> repo/branches/work/developer1/branch4
>> repo/branches/work/developer2/branch5
>
> see my post at
>     http://www.cafu.de/forum/viewtopic.php?f=14&t=1092
> heading "Branches outside branches/".
>
> You may need something like
>     git config --add svn-remote.svn.fetch
> "path.../branchX:refs/remotes/branchX"
> for each of your branches.

Thanks,

that works :)

Although not an ideal solution - I have to manually configure all
branches + update them as they are created


--
Piotr Krukowiecki
