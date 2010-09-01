From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 08:04:03 +1000
Message-ID: <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 00:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqvPu-00085R-UF
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 00:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0IAWEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 18:04:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab0IAWEF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 18:04:05 -0400
Received: by wyb35 with SMTP id 35so9759131wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UUvYnfNqI0nAGagkXQmOaQj2JAWJUPVc/hRUisC/SmY=;
        b=R/t4UkHMBMRf9aP0bvEVkxuPzIqawSGWJ1EvJckrqV+jh7QEnUUGrggcdbF2Z0yDav
         5pnqSLyXNYDuuqbkSjJlxY4SLjmc0ugkLnx7ZhPDYr4Qqg5SrX0kGfoRcqiA7ucavPji
         OOTyMynauF9ALndECv99KWz2Q4rwY5zhfYszU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DFl0j71s9zdkJ3cvh+XCHvmay3go4RU5OusUi15gytrsww/DBJNKBMMYHJFhUQSMwk
         h+i4+euh/D72yMlR58gzET/plsr5gkrxo1WnLrXurJs4ehvkOT3eOUCRpS6VAIYujeta
         KPZ9WEhpsIuFe3sqjYNwtI0A+3knuXC0MC4bQ=
Received: by 10.216.158.18 with SMTP id p18mr832275wek.2.1283378643733; Wed,
 01 Sep 2010 15:04:03 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 1 Sep 2010 15:04:03 -0700 (PDT)
In-Reply-To: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155095>

On Thu, Sep 2, 2010 at 12:36 AM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> http://gitorious.org/python-libbittorrent/pybtlib
>
> hurrah - success! =C2=A0git fsck shows a "dangling commit"!
>
> so, as a proof-of-concept, 400 lines of python code plus a bittorrent
> library shows that it's possible to create a peer-to-peer distributed
> version of "git fetch", by treating the pack objects as "files to be
> shared".

You should have a look at gittorrent [1] (and finish it too if you are
interested). There were discussions whether a pack is stable enough to
be shared like this, one of the reason "commit reel" was introduced.

[1] http://code.google.com/p/gittorrent/
--=20
Duy
