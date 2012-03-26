From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: How to get status-like short format for old commits?
Date: Mon, 26 Mar 2012 20:53:45 +0200
Message-ID: <CAA01CsppeF8r_hDhuE7snExxJ6zaWdt5Znu82ZzDmyNMzWRDfA@mail.gmail.com>
References: <CAA01CsqM_cmf8A5OjdkX4i-ituCWK95ygEoK_Y0-2LkKo1D7kA@mail.gmail.com>
	<20120326120703.GA5454@ikke-laptop.buyways.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin <compufreak@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:54:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCF3E-0001TC-3E
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186Ab2CZSxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 14:53:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43735 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174Ab2CZSxq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 14:53:46 -0400
Received: by yenl12 with SMTP id l12so4100559yen.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mRyM7/oEx1ksjHz4ihUyINfkPTdY7L+gWcm6ccXbpOA=;
        b=0ErC2JUHWjqe1fcqNNJ7eMxw/gBCVnhi69VzZ5fuh4CaubJo5oXndQQ2X5sJ3R24qJ
         B81AgTWMLkVEaqJhRZ634dvwJrtfdPEcvvWm/QKTY3aXkvkaq3ZeCZfTV8WdeWwFJM/9
         2Kj/edgyW7X6l9dYeKKbBqCAeGUuaHV0JeMtXkcvpic6RWauDj4G/9NxvsKdoEjlEYw0
         cLwfxcGmftNLR4Jzs/eR7JbYmo+0PAkwXyM+ZHXHd2iDR6FLffO3o96qWhLXZ24pvRwd
         u31zQaLryw+SsxbCzFd4AFuS8iaNcWdomFe4xOLTXW7TYLkgy4j736wF+Grp1POY2V9p
         nDzg==
Received: by 10.50.170.104 with SMTP id al8mr6669657igc.9.1332788025351; Mon,
 26 Mar 2012 11:53:45 -0700 (PDT)
Received: by 10.50.170.40 with HTTP; Mon, 26 Mar 2012 11:53:45 -0700 (PDT)
In-Reply-To: <20120326120703.GA5454@ikke-laptop.buyways.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193955>

Thanks,

not so nice as status, but still ok.

Piotrek

On Mon, Mar 26, 2012 at 2:07 PM, Kevin <compufreak@gmail.com> wrote:
> You might want git log --name-status. It will show something similar =
as
> git status -s. (so with A,M,D etc. as status).
>
>
>
> On Mon, Mar 26, 2012 at 01:24:24PM +0200, Piotr Krukowiecki wrote:
>> Hi,
>>
>> I there a way to get a clear status of some past commits, like 'git
>> status' shows for current index/HEAD? I.e. something like
>>
>> git status HEAD^
>> # =A0 =A0 modified: =A0 Makefile
>> # =A0 =A0 deleted: =A0 =A0t/t0080-vcs-svn.sh
>> # =A0 =A0 new file: =A0 t/t9011-svn-da.sh
>> # =A0 =A0 renamed: =A0 xxx -> yyy
>>
>>
>> Thanks,
>> --
>> Piotr Krukowiecki
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Piotr Krukowiecki
